class TeamDetailsInfoModel {
  int? status;
  String? message;
  String? teamCount;
  String? primeCount;
  String? level;
  List<TeamDetailsInfoData>? data;

  TeamDetailsInfoModel(
      {this.status, this.level, this.teamCount, this.message, this.data});

  TeamDetailsInfoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    level = json['level'].toString();
    message = json['message'];
    teamCount = json['teamCount'].toString();
    primeCount = json['primeCount'].toString();
    if (json['data'] != null) {
      data = <TeamDetailsInfoData>[];
      json['data'].forEach((v) {
        data!.add(TeamDetailsInfoData.fromJson(v));
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

class TeamDetailsInfoData {
  String? mlmId;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? joiningDate;
  String? plan;
  String? activePrimeMember;
  String? teamSize;
  String? city;
  String? id;
  String? rank;

  TeamDetailsInfoData(
      {this.mlmId,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.id,
      this.rank,
      this.joiningDate,
      this.plan});

  TeamDetailsInfoData.fromJson(Map<String, dynamic> json) {
    mlmId = json['mlm_id'];
    id = json['user_id'].toString();
    name = json['name'];
    email = json['email'];
    rank = json['user_rank'];
    mobile = json['mobile'];
    address = json['address'];
    joiningDate = json['joining_date'];
    plan = json['plan'];
    city = json['city'];
    // teamSize = json['team_size'].toString();
    activePrimeMember = json['active_prime_member'].toString();
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mlm_id'] = mlmId;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['joining_date'] = joiningDate;
    data['plan'] = plan;
    return data;
  }
}
