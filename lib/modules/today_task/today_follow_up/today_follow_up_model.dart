import 'package:defenders/model/msg_content/msg_content_model.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';

class TodayFollowUpModel {
  List<TeamDetailsInfoData> teamDetailsdata;
  String level;
  TeamDetailsInfoModel todayData;
  GetMsgCotentData msg;
  TodayFollowUpModel(
      {required this.msg,
      required this.todayData,
      required this.level,
      required this.teamDetailsdata});
}
