class AdvanceDeclineModel {
  Data? data;

  AdvanceDeclineModel({this.data});

  AdvanceDeclineModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<AdvanceDeclineModelData> list = [];

  Data(this.list);

  Data.fromJson(List<dynamic> json) {
    json.forEach((v) {
      list.add(AdvanceDeclineModelData.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvanceDeclineModelData {
  String? indice;
  String? advances;
  String? declines;
  String? unchanged;

  AdvanceDeclineModelData({
    this.indice,
    this.advances,
    this.declines,
    this.unchanged,
  });

  AdvanceDeclineModelData.fromJson(Map<String, dynamic> json) {
    indice = json['indice'] ?? '';
    advances = json['advances'] ?? '';
    declines = json['declines'] ?? '';
    unchanged = json['unchanged'] ?? '';
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indice'] = this.indice;
    data['advances'] = this.advances;
    data['declines'] = this.declines;
    data['unchanged'] = this.unchanged;
    return data;
  }
}

