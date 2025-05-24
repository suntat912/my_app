import 'package:flutter/material.dart';

class DiemQuaTrinhPage extends StatelessWidget {
  const DiemQuaTrinhPage({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {
        'hocKy': '2',
        'namHoc': '2024-2025',
        'maHP': 'IT3241',
        'tenHP': 'Lập trình ứng dụng với Python',
        'tinChi': '4',
        'diem10': '6.5',
        'diem4': '2.5',
        'diemChu': 'C+',
      },
      {
        'hocKy': '2',
        'namHoc': '2024-2025',
        'maHP': 'IT3261',
        'tenHP': 'Lập trình Web với PHP',
        'tinChi': '4',
        'diem10': '9.1',
        'diem4': '4',
        'diemChu': 'A+',
      },
      {
        'hocKy': '2',
        'namHoc': '2024-2025',
        'maHP': 'IT3261',
        'tenHP': 'Lập trình Web với PHP',
        'tinChi': '4',
        'diem10': '9.1',
        'diem4': '4',
        'diemChu': 'A+',
      },
      {
        'hocKy': '2',
        'namHoc': '2024-2025',
        'maHP': 'IT3261',
        'tenHP': 'Lập trình Web với PHP',
        'tinChi': '4',
        'diem10': '9.1',
        'diem4': '4',
        'diemChu': 'A+',
      },
      {
        'hocKy': '2',
        'namHoc': '2024-2025',
        'maHP': 'IT3261',
        'tenHP': 'Lập trình Web với PHP',
        'tinChi': '4',
        'diem10': '9.1',
        'diem4': '4',
        'diemChu': 'A+',
      },
      {
        'hocKy': '2',
        'namHoc': '2024-2025',
        'maHP': 'IT3261',
        'tenHP': 'Lập trình Web với PHP',
        'tinChi': '4',
        'diem10': '9.1',
        'diem4': '4',
        'diemChu': 'A+',
      },
      // Thêm các môn khác như trên nếu cần
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Điểm quá trình'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true, // Hiển thị thanh cuộn luôn
        controller: ScrollController(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Học kỳ')),
              DataColumn(label: Text('Năm học')),
              DataColumn(label: Text('Mã HP')),
              DataColumn(label: Text('Tên học phần')),
              DataColumn(label: Text('TC')),
              DataColumn(label: Text('Điểm 10')),
              DataColumn(label: Text('Điểm 4')),
              DataColumn(label: Text('Điểm chữ')),
            ],
            rows: subjects.map((subject) {
              return DataRow(cells: [
                DataCell(Text(subject['hocKy']!)),
                DataCell(Text(subject['namHoc']!)),
                DataCell(Text(subject['maHP']!)),
                DataCell(Text(subject['tenHP']!)),
                DataCell(Text(subject['tinChi']!)),
                DataCell(Text(subject['diem10']!)),
                DataCell(Text(subject['diem4']!)),
                DataCell(Text(subject['diemChu']!)),
              ]);
            }).toList(),
          ),
        ),
      ),

    );
  }
}
