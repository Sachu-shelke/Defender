import 'package:defenders/model/profile/profile_model.dart';

class ProfileModel {
  ProfileData data;
  num totalCashback;
  num totalReferral;
  ProfileModel({
    required this.data,
    required this.totalCashback,
    required this.totalReferral,
  });
}
