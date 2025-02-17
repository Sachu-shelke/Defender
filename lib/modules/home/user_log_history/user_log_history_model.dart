import 'package:defenders/model/home_model/royality_progress_model.dart';

class UserLogHistoryModel {
  List<RoyalityProgressData> royalityModel;
  Map<String, double>? dataMap;
  UserLogHistoryModel({this.dataMap, required this.royalityModel});
}
