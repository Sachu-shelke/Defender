class MobileRechargePlanMode {
  int? status;
  String? message;
  MobileRechargePlanData? data;

  MobileRechargePlanMode({this.status, this.message, this.data});

  MobileRechargePlanMode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? MobileRechargePlanData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MobileRechargePlanData {
  List<TOPUP>? tOPUP;
  List<TOPUP>? l3G4G;
  List<TOPUP>? romaing;
  List<TOPUP>? cOMBO;
  List<TOPUP>? fullTalktime;
  List<TOPUP>? offer;

  MobileRechargePlanData({this.tOPUP, this.l3G4G, this.romaing, this.cOMBO});

  MobileRechargePlanData.fromJson(Map<String, dynamic> json) {
    if (json['TOPUP'] != null) {
      tOPUP = <TOPUP>[];
      json['TOPUP'].forEach((v) {
        tOPUP!.add(TOPUP.fromJson(v));
      });
    }
    if (json['3G/4G'] != null) {
      l3G4G = <TOPUP>[];
      json['3G/4G'].forEach((v) {
        l3G4G!.add(TOPUP.fromJson(v));
      });
    }
    if (json['Romaing'] != null) {
      romaing = <TOPUP>[];
      json['Romaing'].forEach((v) {
        romaing!.add(TOPUP.fromJson(v));
      });
    }
    if (json['COMBO'] != null) {
      cOMBO = <TOPUP>[];
      json['COMBO'].forEach((v) {
        cOMBO!.add(TOPUP.fromJson(v));
      });
    }
    if (json['FULLTT'] != null) {
      fullTalktime = <TOPUP>[];
      json['FULLTT'].forEach((v) {
        fullTalktime!.add(TOPUP.fromJson(v));
      });
    }
    if (json['OFFER'] != null) {
      offer = <TOPUP>[];
      json['OFFER'].forEach((v) {
        offer!.add(TOPUP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tOPUP != null) {
      data['TOPUP'] = tOPUP!.map((v) => v.toJson()).toList();
    }
    if (l3G4G != null) {
      data['3G/4G'] = l3G4G!.map((v) => v.toJson()).toList();
    }
    if (romaing != null) {
      data['Romaing'] = romaing!.map((v) => v.toJson()).toList();
    }
    if (cOMBO != null) {
      data['COMBO'] = cOMBO!.map((v) => v.toJson()).toList();
    }
    if (fullTalktime != null) {
      data['FULLTT'] = fullTalktime!.map((v) => v.toJson()).toList();
    }
    if (offer != null) {
      data['OFFER'] = offer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TOPUP {
  String? rs;
  String? desc;
  String? validity;
  String? lastUpdate;

  TOPUP({this.rs, this.desc, this.validity, this.lastUpdate});

  TOPUP.fromJson(Map<String, dynamic> json) {
    rs = json['rs'].toString();
    desc = json['desc'].toString();
    validity = json['validity'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rs'] = rs;
    data['desc'] = desc;
    data['validity'] = validity;
    data['last_update'] = lastUpdate;
    return data;
  }
}
