class TeamDetailsModel {
  int? status;
  String? message;
  List<TeamDetailsData>? data;
  List<Leveldata>? leveldata;

  TeamDetailsModel({this.status, this.message, this.data, this.leveldata});

  TeamDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TeamDetailsData>[];
      json['data'].forEach((v) {
        data!.add(TeamDetailsData.fromJson(v));
      });
    }
    if (json['leveldata'] != null) {
      leveldata = <Leveldata>[];
      json['leveldata'].forEach((v) {
        leveldata!.add(Leveldata.fromJson(v));
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
    if (leveldata != null) {
      data['leveldata'] = leveldata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamDetailsData {
  String? totalMember;
  String? totalActive;
  String? totalEarning;
  String? totalWithdrawal;
  String? totalRepurchaseIncome;
  String? totalInactive;
  String? hybrid;
  String? booster;
  String? primeA;
  String? primeB;
  num? silver;
  num? gold;
  num? platinum;
  num? diamond;
  num? doubleDiamond;
  num? ambassador;
  num? carFund;
  num? houseFund;
  num? mobileFund;
  num? travelFund;
  num? comunityFund;
  List<Rank>? rank;

  TeamDetailsData(
      {this.totalMember,
      this.totalActive,
      this.totalEarning,
      this.totalWithdrawal,
      this.totalInactive,
      this.totalRepurchaseIncome,
      this.booster,
      this.hybrid,
      this.primeA,
      this.primeB,
      this.rank,
      this.silver,
      this.gold,
      this.platinum,
      this.diamond,
      this.doubleDiamond,
      this.ambassador,
      this.carFund,
      this.mobileFund,
      this.houseFund,
      this.travelFund,
      this.comunityFund});

  TeamDetailsData.fromJson(Map<String, dynamic> json) {
    totalMember = json['total_member'].toString();
    totalActive = json['total_active'].toString();
    totalInactive = json['total_inactive'].toString();
    totalEarning = json['total_earning'].toString();
    totalWithdrawal = json['total_withdrawal'].toString();
    totalRepurchaseIncome = json['total_repurchase_income'].toString();
    hybrid = json['hybrid'].toString();
    booster = json['booste'].toString();
    primeA = json['prime_a'].toString();
    primeB = json['prime_b'].toString();
    silver = json['total_silver_income'];
    gold = json['total_gold_income'];
    platinum = json['Platinum'] ?? 0;
    diamond = json['total_diamond_income'];
    doubleDiamond = json['total_DoubleDiamond_income'];
    ambassador = json['total_ambassador_income'];
    carFund = json['total_carfund_income'];
    houseFund = json['total_housefund_income'];
    travelFund = json['total_travelfund_income'];
    comunityFund = json['total_Communityfund_income'];
    mobileFund = json['total_mobilefund_income'];
    if (json['rank'] != null) {
      rank = <Rank>[];
      json['rank'].forEach((v) {
        rank!.add(Rank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_member'] = totalMember;
    data['total_active'] = totalActive;
    data['total_earning'] = totalEarning;
    data['total_withdrawal'] = totalWithdrawal;
    data['total_repurchase_income'] = totalRepurchaseIncome;
    if (rank != null) {
      data['rank'] = rank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leveldata {
  int? totalActive;
  int? levelcount;
  int? level;
  int? totalInactive;

  Leveldata(
      {this.totalActive, this.totalInactive, this.levelcount, this.level});

  Leveldata.fromJson(Map<String, dynamic> json) {
    totalActive = json['total_active'];
    levelcount = json['levelcount'];
    totalInactive = json['total_inactive'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_active'] = totalActive;
    data['levelcount'] = levelcount;
    data['level'] = level;
    return data;
  }
}

class Data {
  List<Rank>? rank;

  Data({this.rank});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['rank'] != null) {
      rank = <Rank>[];
      json['rank'].forEach((v) {
        rank!.add(Rank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rank != null) {
      data['rank'] = rank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rank {
  String? userRank;

  Rank({this.userRank});

  Rank.fromJson(Map<String, dynamic> json) {
    userRank = json['user_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_rank'] = userRank;
    return data;
  }
}
