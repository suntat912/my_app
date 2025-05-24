import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/statistic_response.dart';
class ApiService {
  // Base URL của API
  static const String baseUrl = 'http://172.20.10.8:8080/account';

  // Token header
  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Hàm đăng nhập
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        await _saveUserData(data);
        return data;
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Đăng nhập thất bại');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }

  // Lưu thông tin người dùng
  static Future<void> _saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    // Lưu token
    if (data.containsKey('token')) {
      await prefs.setString('auth_token', data['token']);
    }

    // Lưu thông tin người dùng
    if (data.containsKey('user')) {
      await prefs.setString('user_data', json.encode(data['user']));

      // Lưu tên người dùng nếu có
      if (data['user'].containsKey('fullName')) {
        await prefs.setString('user_name', data['user']['fullName']);
      }

      // Lưu ID người dùng
      if (data['user'].containsKey('id')) {
        await prefs.setString('user_id', data['user']['id'].toString());
      }
    }
  }

  // Lấy thông tin người dùng từ local storage
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');

    if (userData != null) {
      return json.decode(userData) as Map<String, dynamic>;
    }
    return null;
  }

  // Lấy thông tin người dùng từ API
  static Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Cập nhật thông tin người dùng trong local storage
        await _saveUserData({'user': data});
        return data;
      } else {
        throw Exception('Không thể lấy thông tin người dùng');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  // Lấy danh sách thông báo
  static Future<List<dynamic>> fetchNotifications() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/notifications'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['notifications'] ?? [];
      } else {
        throw Exception('Không thể lấy thông báo');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  // Lấy thông tin điểm số
  static Future<List<dynamic>> fetchGrades() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/grades'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['grades'] ?? [];
      } else {
        throw Exception('Không thể lấy điểm số');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  // Lấy lịch học
  static Future<List<dynamic>> fetchSchedule() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/schedule'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['schedule'] ?? [];
      } else {
        throw Exception('Không thể lấy lịch học');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  // Đăng xuất
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    await prefs.remove('user_name');
    await prefs.remove('user_id');
  }

  // Kiểm tra trạng thái đăng nhập
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }

  // điểm số
  static Future<StatisticResponse> fetchStatistics() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/statistics'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return StatisticResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load statistics: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi gọi API thống kê: $e');
    }
  }
}
