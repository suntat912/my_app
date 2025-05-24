import 'package:flutter/material.dart';

class TaiKhoanPage extends StatefulWidget {
  @override
  _TaiKhoanPageState createState() => _TaiKhoanPageState();
}

class _TaiKhoanPageState extends State<TaiKhoanPage> {
  int _selectedIndex = 4; // Tab "Tài khoản" mặc định được chọn

  void _onItemTapped(int index) {
    if (index == 4) return; // Nếu nhấn lại vào "Tài khoản" thì không làm gì cả
    Navigator.pop(context); // Quay lại `MainScreen` nếu chọn tab khác
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tài khoản"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'TRAN NAM ANH',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Cá nhân'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Đổi ảnh nền'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Cài đặt nâng cao'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Đổi mật khẩu'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Cài đặt đăng nhập'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Tin nhắn"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Thông báo"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Cài đặt"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tài khoản"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
