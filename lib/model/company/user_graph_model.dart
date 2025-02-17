class CompanyGraphModel {
  int? status;
  String? message;
  List<CompanyGraphData>? data;

  CompanyGraphModel({this.status, this.message, this.data});

  CompanyGraphModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompanyGraphData>[];
      json['data'].forEach((v) {
        data!.add(CompanyGraphData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyGraphData {
  String? category;
  String? rank;
  String? rankAchievverAmount;
  int? level;
  String? receivedIncome;
  String? total;
  String? targetAchievverAmount;
  String? rankAchieverCategory;

  CompanyGraphData(
      {this.rank,
      this.rankAchievverAmount,
      this.level,
      this.total,
      this.category,
      this.rankAchieverCategory,
      this.receivedIncome,
      this.targetAchievverAmount});

  CompanyGraphData.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    category = json['category'];
    rankAchievverAmount = json['rank_achiever_amount'];
    level = json['level'];
    total = json['total'];
    receivedIncome = json['received_income'];
    targetAchievverAmount = json['target_achievver_amount'];
    rankAchieverCategory = json['rank_achiever_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rank'] = rank;
    data['rank_achievver_amount'] = rankAchievverAmount;
    data['level'] = level;
    data['received_income'] = receivedIncome;
    data['target_achievver_amount'] = targetAchievverAmount;
    return data;
  }
}
