import 'dart:convert';

BannerList partnerListModelFromJson(String str) =>
    BannerList.fromJson(json.decode(str));

String partnerListModelToJson(BannerList data) => json.encode(data.toJson());

class GetBannerModel {
  int? status;
  String? message;
  List<BannerList>? data;

  GetBannerModel({this.status, this.message, this.data});

  GetBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerList>[];
      json['data'].forEach((v) {
        data!.add(BannerList.fromJson(v));
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

// class GetBannerData {
//   List<BannerList>? mHybrid;
//   List<BannerList>? business;
//   List<BannerList>? offer;
//   List<BannerList>? tiny;
//   List<BannerList>? insurance;
//   List<BannerList>? affiliate;
//   List<BannerList>? wallet;

//   GetBannerData(
//       {this.mHybrid,
//       this.business,
//       this.offer,
//       this.tiny,
//       this.insurance,
//       this.affiliate,
//       this.wallet});

//   GetBannerData.fromJson(Map<String, dynamic> json) {
//     if (json['M Hybrid'] != null) {
//       mHybrid = <BannerList>[];
//       json['M Hybrid'].forEach((v) {
//         mHybrid!.add(BannerList.fromJson(v));
//       });
//     }
//     if (json['Business'] != null) {
//       business = <BannerList>[];
//       json['Business'].forEach((v) {
//         business!.add(BannerList.fromJson(v));
//       });
//     }
//     if (json['Offer'] != null) {
//       offer = <BannerList>[];
//       json['Offer'].forEach((v) {
//         offer!.add(BannerList.fromJson(v));
//       });
//     }
//     if (json['Tiny'] != null) {
//       tiny = <BannerList>[];
//       json['Tiny'].forEach((v) {
//         tiny!.add(BannerList.fromJson(v));
//       });
//     }
//     if (json['Insurance'] != null) {
//       insurance = <BannerList>[];
//       json['Insurance'].forEach((v) {
//         insurance!.add(BannerList.fromJson(v));
//       });
//     }
//     if (json['Affiliate'] != null) {
//       affiliate = <BannerList>[];
//       json['Affiliate'].forEach((v) {
//         affiliate!.add(BannerList.fromJson(v));
//       });
//     }
//     if (json['Wallet'] != null) {
//       wallet = <BannerList>[];
//       json['Wallet'].forEach((v) {
//         wallet!.add(BannerList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (mHybrid != null) {
//       data['M Hybrid'] = mHybrid!.map((v) => v.toJson()).toList();
//     }
//     if (business != null) {
//       data['Business'] = business!.map((v) => v.toJson()).toList();
//     }
//     if (offer != null) {
//       data['Offer'] = offer!.map((v) => v.toJson()).toList();
//     }
//     if (tiny != null) {
//       data['Tiny'] = tiny!.map((v) => v.toJson()).toList();
//     }
//     if (insurance != null) {
//       data['Insurance'] = insurance!.map((v) => v.toJson()).toList();
//     }
//     if (affiliate != null) {
//       data['Affiliate'] = affiliate!.map((v) => v.toJson()).toList();
//     }
//     if (wallet != null) {
//       data['Wallet'] = wallet!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class BannerList {
  int? id;
  String? title;
  String? img;
  int? typeId;
  String? bannerFor;

  BannerList({this.id, this.title, this.img, this.typeId, this.bannerFor});

  BannerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    typeId = json['type_id'];
    bannerFor = json['banner_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['img'] = img;
    data['type_id'] = typeId;
    data['banner_for'] = bannerFor;
    return data;
  }
}
