class GetRankDetailsModel {
  int? status;
  String? message;
  List<Data>? data;
  List<TotalCount>? totalCount;

  GetRankDetailsModel({this.status, this.message, this.data, this.totalCount});

  GetRankDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['totalCount'] != null) {
      totalCount = <TotalCount>[];
      json['totalCount'].forEach((v) {
        totalCount!.add(TotalCount.fromJson(v));
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
    if (totalCount != null) {
      data['totalCount'] = totalCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Silver>? silver;
  List<Silver>? gold;
  List<Silver>? platinum;
  List<Silver>? diamond;
  List<Silver>? doubleDiamond;
  List<Silver>? ambassdor;

  Data(
      {this.silver,
      this.gold,
      this.platinum,
      this.diamond,
      this.doubleDiamond,
      this.ambassdor});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Silver'] != null) {
      silver = <Silver>[];
      json['Silver'].forEach((v) {
        silver!.add(Silver.fromJson(v));
      });
    }
    if (json['Gold'] != null) {
      gold = <Silver>[];
      json['Gold'].forEach((v) {
        gold!.add(Silver.fromJson(v));
      });
    }
    if (json['Platinum'] != null) {
      platinum = <Silver>[];
      json['Platinum'].forEach((v) {
        platinum!.add(Silver.fromJson(v));
      });
    }
    if (json['Diamond'] != null) {
      diamond = <Silver>[];
      json['Diamond'].forEach((v) {
        diamond!.add(Silver.fromJson(v));
      });
    }
    if (json['Double Diamond'] != null) {
      doubleDiamond = <Silver>[];
      json['Double Diamond'].forEach((v) {
        doubleDiamond!.add(Silver.fromJson(v));
      });
    }
    if (json['Ambassdor'] != null) {
      ambassdor = <Silver>[];
      json['Ambassdor'].forEach((v) {
        ambassdor!.add(Silver.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (silver != null) {
      data['Silver'] = silver!.map((v) => v.toJson()).toList();
    }
    if (gold != null) {
      data['Gold'] = gold!.map((v) => v.toJson()).toList();
    }
    if (platinum != null) {
      data['Platinum'] = platinum!.map((v) => v.toJson()).toList();
    }
    if (diamond != null) {
      data['Diamond'] = diamond!.map((v) => v.toJson()).toList();
    }
    if (doubleDiamond != null) {
      data['Double Diamond'] =
          doubleDiamond!.map((v) => v.toJson()).toList();
    }
    if (ambassdor != null) {
      data['Ambassdor'] = ambassdor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Silver {
  String? mlmId;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? joiningDate;

  Silver(
      {this.mlmId,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.joiningDate});

  Silver.fromJson(Map<String, dynamic> json) {
    mlmId = json['mlm_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    joiningDate = json['joining_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mlm_id'] = mlmId;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['joining_date'] = joiningDate;
    return data;
  }
}

class TotalCount {
  int? totalRank;
  String? rank;

  TotalCount({this.totalRank, this.rank});

  TotalCount.fromJson(Map<String, dynamic> json) {
    totalRank = json['total_rank'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_rank'] = totalRank;
    data['rank'] = rank;
    return data;
  }
}
