import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageSmallLichHoc extends StatelessWidget {
  const PageSmallLichHoc({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> schedule = [
      {
        'time': '07:00 - 09:30',
        'subject': 'Toán Cao Cấp',
        'room': 'Phòng A101',
        'teacher': 'TS. Nguyễn Văn A',
        'ca': 'Ca 1',
      },
      {
        'time': '09:40 - 12:00',
        'subject': 'Lập Trình Flutter',
        'room': 'Phòng B202',
        'teacher': 'ThS. Trần Thị B',
        'ca': 'Ca 2',
      },
      {
        'time': '13:00 - 15:30',
        'subject': 'Kỹ Năng Mềm',
        'room': 'Phòng C303',
        'teacher': 'CN. Lê Văn C',
        'ca': 'Ca 3',
      },
      {
        'time': '15:40 - 18:00',
        'subject': 'Tiếng Anh Chuyên Ngành',
        'room': 'Phòng D404',
        'teacher': 'ThS. Nguyễn Thị D',
        'ca': 'Ca 4',
      },
      {
        'time': '18:10 - 20:45',
        'subject': 'Kỹ Thuật Lập Trình',
        'room': 'Phòng E505',
        'teacher': 'TS. Lê Văn E',
        'ca': 'Ca 5',
      },
    ];

    // Tính danh sách các ngày từ Thứ 2 đến Chủ nhật trong tuần hiện tại
    final today = DateTime.now();
    final monday = today.subtract(Duration(days: today.weekday - 1)); // Thứ 2
    final weekDates = List.generate(7, (index) {
      final date = monday.add(Duration(days: index));
      final dayOfWeek = 'Thứ ${index + 2 > 8 ? 'CN' : index + 2}'; // CN nếu index==6
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      return '$dayOfWeek - ngày $formattedDate';
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Lịch Học',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Thanh chọn ngày trong tuần
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: weekDates.length,
                separatorBuilder: (context, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return _buildDayButton(context, weekDates[index], index == 0);
                },
              ),
            ),
            const SizedBox(height: 16),
            // Danh sách lịch học
            Expanded(
              child: ListView.builder(
                itemCount: schedule.length,
                itemBuilder: (context, index) {
                  final item = schedule[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text(
                        item['subject']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Thời gian: ${item['time']}'),
                          Text('Phòng: ${item['room']}'),
                          Text('Giảng viên: ${item['teacher']}'),
                          Text('Ca học: ${item['ca']}'),
                        ],
                      ),
                      onTap: () {
                        print('Xem chi tiết buổi học: ${item['subject']}');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget cho nút ngày trong tuần
  Widget _buildDayButton(BuildContext context, String label, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        print('Chọn ngày: $label');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
