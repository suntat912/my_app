import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add this import
import 'services/api_service.dart';
import 'trangchu.dart'; // Import file main.dart



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic> userData = {}; // Store fetched user data

  // Fetch authentication data from API
  Future<bool> authenticate(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Sử dụng ApiService để đăng nhập
      userData = await ApiService.login(email, password);
      return true;
    } catch (e) {
      print('Error during authentication: $e');
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isValidEmail(String email) {
    return email.endsWith("@gmail.com") || email.endsWith("@eaut.edu.com");
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        String enteredEmail = _emailController.text;
        String enteredPassword = _passwordController.text;

        // Call the authenticate method instead of using fetchData as a Map
        bool loginSuccess = await authenticate(enteredEmail, enteredPassword);

        if (loginSuccess) {
          // If login successful, navigate to MainScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        } else {
          // Show error message if login fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email hoặc mật khẩu không đúng")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Có lỗi xảy ra: $e")),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    bool isLoggedIn = await ApiService.isLoggedIn();
    if (isLoggedIn) {
      // Nếu đã đăng nhập, chuyển thẳng đến MainScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Đăng nhập", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập email";
                    }
                    if (!_isValidEmail(value)) {
                      return "Email phải có đuôi @gmail.com hoặc @eaut.edu.com";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập mật khẩu";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _login,
                  child: Text("Đăng nhập"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}