class FinCodeDataModel {
  Data? data;

  FinCodeDataModel({this.data});

  FinCodeDataModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Model>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Model>[];
      json['list'].forEach((v) {
        list!.add(Model.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Model {
  String? compName;
  String? nseSymbol;
  String? bseSymbol;
  double? bseLtpPrice;
  double? nseLtpPrice;
  double? bseClosePrice;
  double? nseClosePrice;
  int? finCode;
  int? lastUpdatedAt;
  double? nseTodaysLow;
  double? nseTodaysHigh;
  double? nseTodaysOpen;
  double? bseTodaysLow;
  double? bseTodaysHigh;
  double? bseTodaysOpen;
  String? logoUrl;
  String? longTermVerdict;
  String? shortTermVerdict;
  String? longTermText;
  String? shortTermText;
  String? trendLong;
  String? trendShort;
  String? fundamentalScore;
  num? verdictChangeTime;
  num? shortTermVerdictChangeTime;
  num? longTermVerdictChangeTime;
  int? lastUpdateStatus;
  bool? isVisible;

  Model(
      {this.compName,
        this.nseSymbol,
        this.bseSymbol,
        this.bseLtpPrice,
        this.nseLtpPrice,
        this.bseClosePrice,
        this.nseClosePrice,
        this.finCode,
        this.lastUpdatedAt,
        this.nseTodaysLow,
        this.nseTodaysHigh,
        this.nseTodaysOpen,
        this.bseTodaysLow,
        this.bseTodaysHigh,
        this.bseTodaysOpen,
        this.logoUrl,
        this.longTermVerdict,
        this.shortTermVerdict,
        this.longTermText,
        this.shortTermText,
        this.trendLong,
        this.trendShort,
        this.fundamentalScore,
        this.verdictChangeTime,
        this.shortTermVerdictChangeTime,
        this.longTermVerdictChangeTime,
        this.isVisible = false,
        this.lastUpdateStatus = 0
      });

  Model.fromJson(Map<String, dynamic> json) {
    compName = json['compName'] ?? '';
    nseSymbol = json['nseSymbol'] ?? '';
    bseSymbol = json['bseSymbol'] ?? '';
    bseLtpPrice = json['bseLtpPrice'] ?? 0.0;
    nseLtpPrice = json['nseLtpPrice'] ?? 0.0;
    bseClosePrice = json['bseClosePrice'] ?? 0.0;
    nseClosePrice = json['nseClosePrice'] ?? 0.0;
    finCode = json['finCode'];
    lastUpdatedAt = json['lastUpdatedAt'];
    nseTodaysLow = json['nseTodaysLow'];
    nseTodaysHigh = json['nseTodaysHigh'];
    nseTodaysOpen = json['nseTodaysOpen'];
    bseTodaysLow = json['bseTodaysLow'];
    bseTodaysHigh = json['bseTodaysHigh'];
    bseTodaysOpen = json['bseTodaysOpen'];
    logoUrl = json['logoUrl'] ?? '';
    longTermVerdict = json['longTermVerdict'] ?? '';
    shortTermVerdict = json['shortTermVerdict'] ?? '';
    longTermText = json['longTermText'] ?? '';
    shortTermText = json['shortTermText'] ?? '';
    trendLong = json['trendLong'] ?? '';
    trendShort = json['trendShort'] ?? '';
    fundamentalScore = json['fundamentalScore'] ?? '';
    verdictChangeTime = json['verdictChangeTime'];
    shortTermVerdictChangeTime = json['shortTermVerdictChangeTime'];
    longTermVerdictChangeTime = json['longTermVerdictChangeTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['compName'] = compName;
    data['nseSymbol'] = nseSymbol;
    data['bseSymbol'] = bseSymbol;
    data['bseLtpPrice'] = bseLtpPrice;
    data['nseLtpPrice'] = nseLtpPrice;
    data['bseClosePrice'] = bseClosePrice;
    data['nseClosePrice'] = nseClosePrice;
    data['finCode'] = finCode;
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['nseTodaysLow'] = nseTodaysLow;
    data['nseTodaysHigh'] = nseTodaysHigh;
    data['nseTodaysOpen'] = nseTodaysOpen;
    data['bseTodaysLow'] = bseTodaysLow;
    data['bseTodaysHigh'] = bseTodaysHigh;
    data['bseTodaysOpen'] = bseTodaysOpen;
    data['logoUrl'] = logoUrl;
    data['longTermVerdict'] = longTermVerdict;
    data['shortTermVerdict'] = shortTermVerdict;
    data['longTermText'] = longTermText;
    data['shortTermText'] = shortTermText;
    data['trendLong'] = trendLong;
    data['trendShort'] = trendShort;
    data['fundamentalScore'] = fundamentalScore;
    data['verdictChangeTime'] = verdictChangeTime;
    data['shortTermVerdictChangeTime'] = shortTermVerdictChangeTime;
    data['longTermVerdictChangeTime'] = longTermVerdictChangeTime;
    return data;
  }
}
