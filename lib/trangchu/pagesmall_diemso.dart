// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../models/statistic_response.dart';
//
// class PageSmallDiemSo extends StatelessWidget {
//   const PageSmallDiemSo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Điểm số'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildCurrentSemester(),
//               const SizedBox(height: 24),
//               FutureBuilder<StatisticResponse>(
//                 future: ApiService.fetchStatistics(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Lỗi: ${snapshot.error}');
//                   } else if (snapshot.hasData) {
//                     return _buildQuickStatsFromData(snapshot.data!);
//                   } else {
//                     return const Text('Không có dữ liệu');
//                   }
//                 },
//               ),
//
//               const SizedBox(height: 32),
//               _buildGradeItem(
//                 icon: Icons.assessment_outlined,
//                 label: 'Điểm quá trình',
//                 onTap: () {
//                   // Xử lý khi nhấn vào Điểm quá trình
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCurrentSemester() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.blue.shade100),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Học kỳ hiện tại',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Học kỳ 2 - 2023/2024',
//                 style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
//               ),
//               Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Text(
//                   'Đang diễn ra',
//                   style: TextStyle(fontSize: 12, color: Colors.blue),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGradeItem({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.only(top: 0),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, size: 32, color: Colors.blue),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickStatsFromData(StatisticResponse data) {
//     final stats = {
//       'TBC tích lũy thang điểm 4': data.tbcThang4,
//       'Xếp hạng học lực': data.xepHangHocLuc,
//       'TBC học tập thang 4': data.tbcHocTapThang4,
//       'Xếp loại học tập thang 4': data.xepLoaiHocTapThang4,
//       'Số tín chỉ đã tích lũy': data.soTinChiTichLuy,
//       'TBC học tập thang 10': data.tbcHocTapThang10,
//       'Xếp loại học tập thang 10': data.xepLoaiHocTapThang10,
//       'Số môn thi lại': data.soMonThiLai,
//       'Số môn học lại': data.soMonHocLai,
//       'Số môn chờ điểm': data.soMonChoDiem,
//     };
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Thống kê nhanh',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           GridView.count(
//             crossAxisCount: 2,
//             childAspectRatio: 3.5,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             children: stats.entries
//                 .map((e) => _buildStatItem(e.key, e.value))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatItem(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(fontSize: 13, color: Colors.black87),
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:my_app/trangchu/diemso/diemquatrinh_page.dart';
import '../trangchu/pagesmall_diemso.dart';
class PageSmallDiemSo extends StatelessWidget {
  const PageSmallDiemSo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điểm số'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCurrentSemester(),
              const SizedBox(height: 24),
              _buildQuickStatsStatic(),
              const SizedBox(height: 32),
              _buildGradeItem(
                icon: Icons.assessment_outlined,
                label: 'Điểm quá trình',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DiemQuaTrinhPage()),
                  );
                },

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSemester() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Học kỳ hiện tại',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Học kỳ 2 - 2023/2024',
                style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Đang diễn ra',
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsStatic() {
    final stats = {
      'TBC tích lũy thang điểm 4': '2.90',
      'Xếp hạng học lực': 'Khá',
      'TBC học tập thang 4': '2.9',
      'Xếp loại học tập thang 4': 'Khá',
      'TBC học tập thang 10': '7.42',
      'Xếp loại học tập thang 10': 'Khá',
      'Số tín chỉ đã tích lũy': '112',
      'Số môn thi lại': '0',
      'Số môn học lại': '0',
      'Số môn chờ điểm': '2',
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thống kê nhanh',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: stats.entries
                .map((e) => _buildStatItem(e.key, e.value))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
