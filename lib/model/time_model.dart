class TimeModel {
  final String code;
  final String message;
  final TimeDataModel data;

  TimeModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      code: json['code'],
      message: json['message'],
      data: TimeDataModel.fromJson(json['data']),
    );
  }
}

class TimeDataModel {
  final int prdId;
  final int dplId;
  final String productName;
  final String productDisplayName;
  final String reserveDt;
  final int riderCount;
  final List<TimeListModel> timeList;
  final int ticketPrice;
  final int ticketSalePrice;

  TimeDataModel({
    required this.prdId,
    required this.dplId,
    required this.productName,
    required this.productDisplayName,
    required this.reserveDt,
    required this.riderCount,
    required this.timeList,
    required this.ticketPrice,
    required this.ticketSalePrice,
  });

  factory TimeDataModel.fromJson(Map<String, dynamic> json) {
    return TimeDataModel(
      prdId: json['prdId'],
      dplId: json['dplId'],
      productName: json['productName'],
      productDisplayName: json['productDisplayName'],
      reserveDt: json['reserveDt'],
      riderCount: json['riderCount'],
      timeList: List<TimeListModel>.from(
        json['timeList'].map((item) => TimeListModel.fromJson(item)),
      ),
      ticketPrice: json['ticketPrice'],
      ticketSalePrice: json['ticketSalePrice'],
    );
  }
}

class TimeListModel {
  final String timeSlot;
  final String stcDetailId;
  final String? stockStartTime;
  final String? stockEndTime;
  final bool stockUseYn;
  final int stockCount;
  final int totStockCount;
  final bool enabled;
  final String? operationStopYn;
  final String? appOnlyYn;
  final List<BasicProductDetailModel> productDetailList;
  final String stockStatusStr;
  final int stockStatus;

  TimeListModel({
    required this.timeSlot,
    required this.stcDetailId,
    this.stockStartTime,
    this.stockEndTime,
    required this.stockUseYn,
    required this.stockCount,
    required this.totStockCount,
    required this.enabled,
    this.operationStopYn,
    this.appOnlyYn,
    required this.productDetailList,
    required this.stockStatusStr,
    required this.stockStatus,
  });

  factory TimeListModel.fromJson(Map<String, dynamic> json) {
    return TimeListModel(
      timeSlot: json['timeSlot'],
      stcDetailId: json['stcDetailId'],
      stockStartTime: json['stockStartTime'],
      stockEndTime: json['stockEndTime'],
      stockUseYn: json['stockUseYn'],
      stockCount: json['stockCount'],
      totStockCount: json['totStockCount'],
      enabled: json['enabled'],
      operationStopYn: json['operationStopYn'],
      appOnlyYn: json['appOnlyYn'],
      productDetailList: List<BasicProductDetailModel>.from(
        json['productDetailList']
            .map((item) => BasicProductDetailModel.fromJson(item)),
      ),
      stockStatusStr: json['stockStatusStr'],
      stockStatus: json['stockStatus'],
    );
  }
}

class BasicProductDetailModel {
  final int prdDetailId;
  final String entranceStartTime;
  final String entranceEndTime;
  final int orderNo;

  BasicProductDetailModel({
    required this.prdDetailId,
    required this.entranceStartTime,
    required this.entranceEndTime,
    required this.orderNo,
  });

  factory BasicProductDetailModel.fromJson(Map<String, dynamic> json) {
    return BasicProductDetailModel(
      prdDetailId: json['prdDetailId'],
      entranceStartTime: json['entranceStartTime'],
      entranceEndTime: json['entranceEndTime'],
      orderNo: json['orderNo'],
    );
  }
}
