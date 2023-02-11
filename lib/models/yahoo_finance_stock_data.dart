class YahooFinanceStockDataModel {
  Data? data;

  YahooFinanceStockDataModel({this.data});

  YahooFinanceStockDataModel.fromJson(Map<String, dynamic> json) {
    data = json['quoteResponse'] != null ? Data.fromJson(json['quoteResponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['quoteResponse'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<LivePriceData>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      list = <LivePriceData>[];
      json['result'].forEach((v) {
        list!.add(LivePriceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['result'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LivePriceData {
  String? compShortName;
  String? compLongName;
  String? symbol;
  String? fullExchangeName;
  double? ltpPrice;
  double? regularMarketChangePercent;

  LivePriceData(
      {this.compShortName,
        this.compLongName,
        this.symbol,
        this.fullExchangeName,
        this.ltpPrice,
        this.regularMarketChangePercent,
      });

  LivePriceData.fromJson(Map<String, dynamic> json) {
    compShortName = json['shortName'] ?? '';
    compLongName = json['longName'] ?? '';
    symbol = json['symbol'] ?? '';
    fullExchangeName = json['fullExchangeName'] ?? '';
    ltpPrice = json['regularMarketPrice'] ?? 0.0;
    regularMarketChangePercent = json['regularMarketChangePercent'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shortName'] = compShortName;
    data['longName'] = compLongName;
    data['symbol'] = symbol;
    data['fullExchangeName'] = fullExchangeName;
    data['bseLtpPrice'] = ltpPrice;
    data['regularMarketChangePercent'] = regularMarketChangePercent;
    return data;
  }
}
