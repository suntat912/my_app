class StatisticResponse {
  final String tbcThang4;
  final String xepHangHocLuc;
  final String tbcHocTapThang4;
  final String xepLoaiHocTapThang4;
  final String soTinChiTichLuy;
  final String tbcHocTapThang10;
  final String xepLoaiHocTapThang10;
  final String soMonThiLai;
  final String soMonHocLai;
  final String soMonChoDiem;

  StatisticResponse({
    required this.tbcThang4,
    required this.xepHangHocLuc,
    required this.tbcHocTapThang4,
    required this.xepLoaiHocTapThang4,
    required this.soTinChiTichLuy,
    required this.tbcHocTapThang10,
    required this.xepLoaiHocTapThang10,
    required this.soMonThiLai,
    required this.soMonHocLai,
    required this.soMonChoDiem,
  });

  factory StatisticResponse.fromJson(Map<String, dynamic> json) {
    return StatisticResponse(
      tbcThang4: json['tbcThang4'],
      xepHangHocLuc: json['xepHangHocLuc'],
      tbcHocTapThang4: json['tbcHocTapThang4'],
      xepLoaiHocTapThang4: json['xepLoaiHocTapThang4'],
      soTinChiTichLuy: json['soTinChiTichLuy'],
      tbcHocTapThang10: json['tbcHocTapThang10'],
      xepLoaiHocTapThang10: json['xepLoaiHocTapThang10'],
      soMonThiLai: json['soMonThiLai'],
      soMonHocLai: json['soMonHocLai'],
      soMonChoDiem: json['soMonChoDiem'],
    );
  }
}
