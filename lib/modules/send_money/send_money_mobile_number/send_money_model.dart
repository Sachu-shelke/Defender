import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/model/recharge_model/recent_recharge_model.dart';

class SendMoneyScreenModel {
  LoginData userDetails;
  List<RecentRechargeData> recentSendMoneyList;
  SendMoneyScreenModel(
      {required this.recentSendMoneyList, required this.userDetails});
}
