class DateModel {
  final String code;
  final String message;
  final List<DateDataModel> data;

  DateModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      code: json['code'],
      message: json['message'],
      data: List<DateDataModel>.from(
          json['data'].map((item) => DateDataModel.fromJson(item))),
    );
  }
}

class DateDataModel {
  final int dplId;
  final String date;
  final bool enabled;
  final bool holidayYn;

  DateDataModel({
    required this.dplId,
    required this.date,
    required this.enabled,
    required this.holidayYn,
  });

  factory DateDataModel.fromJson(Map<String, dynamic> json) {
    return DateDataModel(
      dplId: json['dplId'] ?? 0,
      date: json['date'],
      enabled: json['enabled'] ?? false,
      holidayYn: json['holidayYn'] ?? false,
    );
  }
}
