import 'dart:async';


import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'trangchu/pagesmall_thongtin.dart';
import 'trangchu/pagesmall_diemso.dart';
import 'trangchu/pagesmall_lichhoc.dart';
import 'trangchu/pagesmall_khaosat.dart';
import 'trangchu/pagesmall_tailieu_thamkhao.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    MessagesPage(),
    NotificationsPage(),
    SettingsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _userName = "User"; // Mặc định

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    try {
      final userData = await ApiService.getUserData();
      if (userData != null && mounted) {
        setState(() {
          _userName = userData['fullName'] ?? "User";
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, .........."),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () {
              setState(() {
                _selectedIndex = 4; // Switch to account page
              });
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildBottomNavItem(Icons.home, "Trang chủ", 0),
          _buildBottomNavItem(Icons.message, "Tin nhắn", 1),
          _buildBottomNavItem(Icons.notifications, "Thông báo", 2),
          _buildBottomNavItem(Icons.settings, "Cài đặt", 3),
          _buildBottomNavItem(Icons.person, "Tài khoản", 4),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(isSelected ? 10 : 6), // To hơn khi được chọn
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue.withOpacity(0.15) : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: isSelected ? 32 : 22, // To hơn khi được chọn
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
      label: label,
    );
  }

}

// Các màn hình con
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      if (_controller.hasClients) {
        if (_controller.page == 2) {
          _controller.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _controller.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thông báo gần đây
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ' Thông Báo Gần Đây ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    itemCount: 3,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/image${index + 1}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                        (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tiêu đề "Tiện ích"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  ' Tiện Ích',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.apps_outlined,
                  size: 22,
                  color: Colors.black87,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8), // Thêm khoảng cách nhỏ dưới tiêu đề
          // Grid Menu phần còn lại giữ nguyên
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 12, // Tăng khoảng cách hàng
              crossAxisSpacing: 16,
              childAspectRatio: 0.9, // Tăng chiều cao của mỗi item
              children: [

                _buildMenuItem(
                  context,
                  Icons.info_outline,
                  'Thông tin',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageSmallThongTin(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.grade_outlined,
                  'Điểm số',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageSmallDiemSo(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  Icons.calendar_today,
                  'Lịch học',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageSmallLichHoc(),
                      ),
                    );
                  },
                ),

                _buildMenuItem(context, Icons.folder_outlined, 'Tài liệu\ntham khảo'),
              ],
            ),
          ),

          // Tiêu đề "Dịch vụ thanh toán"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  ' Dịch Vụ Thanh Toán',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.payment_outlined,
                  size: 22,
                  color: Colors.black87,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8), // Thêm khoảng cách nhỏ dưới tiêu đề
          // Grid Menu phần còn lại giữ nguyên
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 12, // Tăng khoảng cách hàng
              crossAxisSpacing: 16,
              childAspectRatio: 0.9, // Tăng chiều cao của mỗi item
              children: [
                _buildMenuItem(context, Icons.payment, 'Nộp tiền học'),
                _buildMenuItem(context, Icons.attach_money, 'Đóng học lại'),
                _buildMenuItem(context, Icons.groups, 'Tiền đoàn'),
                _buildMenuItem(context, Icons.more_horiz, 'Nộp tiền khác'),
              ],
            ),
          ),

          // Tiêu đề "Học vụ"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  ' Học Vụ',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.school_outlined,
                  size: 22,
                  color: Colors.black87,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8), // Thêm khoảng cách nhỏ dưới tiêu đề
          // Grid Menu phần còn lại giữ nguyên
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 12, // Tăng khoảng cách hàng
              crossAxisSpacing: 16,
              childAspectRatio: 0.9, // Tăng chiều cao của mỗi item
              children: [
                _buildMenuItem(context, Icons.warning_amber_outlined, 'Cảnh cáo\nhọc vụ'),
                _buildMenuItem(context, Icons.bar_chart, 'Khảo sát\nchất lượng'),
                _buildMenuItem(context, Icons.report_problem, 'Báo cáo\nvi phạm'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String label, {
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Hình tròn màu xanh nhạt với nền xám
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Chữ bên dưới icon
          SizedBox(
            height: 34,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoSlab(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Updated ProfilePage to match the image
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tài khoản"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Greeting
                  SizedBox(height: 4),
                  // Name
                  Text(
                    "TRAN NAM ANH",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Personal section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Cá nhân",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  _buildProfileMenuTile(
                    "Đổi ảnh đại diện",
                    Icons.person_outline,
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  _buildProfileMenuTile(
                    "Đổi ảnh nền",
                    Icons.image_outlined,
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Advanced settings section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Cài đặt nâng cao",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  _buildProfileMenuTile(
                    "Thanh toán học phí",
                    Icons.receipt_long_outlined,
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  _buildProfileMenuTile(
                    "Đổi mật khẩu",
                    Icons.lock_outline,
                    Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuTile(
      String title,
      IconData leadingIcon,
      IconData trailingIcon, {
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              leadingIcon,
              size: 22,
              color: Colors.black54,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              trailingIcon,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Cài đặt"));
  }
}

// Updated NotificationsPage to match the second image
class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Khuyến mại', 'Cảnh báo', 'Biến động', 'Tin khác'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông báo"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],

      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    'Tìm kiếm',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          // Today's section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  'Hôm nay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Notification item
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '10:37',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.more_vert,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Notification content card
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/image1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Notification description
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_objects,
                          color: Colors.amber,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'xin chào',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'helllooooo',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'hellooooooo',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),

    );
  }
}

// Updated MessagesPage to match the first image
class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat cùng Công Nghệ Đông Á",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // Welcome message from BIDV BOT
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'xin chào',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),

          // Chat input bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Nhập nội dung',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
      BuildContext context, {
        required String title,
        required String backgroundImage,
        IconData? icon,
        Color? iconColor,
      }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
          ),

          // Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: iconColor ?? Colors.white,
                      size: 20,
                    ),
                  if (icon != null) SizedBox(width: 4),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLink(
      BuildContext context,
      String title, {
        required IconData icon,
        required Color color,
      }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        dense: true,
      ),
    );
  }
}
