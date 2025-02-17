import 'package:defenders/model/banner_model/banner_model.dart';
import 'package:defenders/model/company/user_graph_model.dart';
import 'package:defenders/model/graphics/get_graphics_main_model.dart';
import 'package:defenders/model/graphics/get_graphics_model.dart' as ge;
import 'package:defenders/model/home_model/get_categories_model.dart';
import 'package:defenders/model/home_model/rank_details_count_model.dart';
import 'package:defenders/model/notification/notification_model.dart';
import 'package:defenders/model/recent_screen_model.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';

class HomeScreenModel {
  ge.GetGraphicsCategoryModel graphicsList;
  TeamDetailsInfoModel todayData;
  List todayList;
  List<CategoriesResponse>? leadsList;
  GetRankDetailsModel silverDetailsResponse;
  List<BannerList>? bennerApiList;
  List<CompanyGraphData> graphData;
  Map<String, double>? dataMap;
  int selectedGraphData;
  List<RecentAppUseData> rechargeServiceList;
  List<GraphicsMainData> graphicsdata;
  List<NotificationData> notificationdata;
  List categoriesIdList;
  List mirrorConnectList;
  int tabindex;
  num todayIncome;
  num totalEarning;
  String tabelName;
  HomeScreenModel(
      {required this.graphicsList,
      required this.leadsList,
      required this.tabindex,
      required this.todayIncome,
      required this.totalEarning,
      required this.todayData,
      required this.selectedGraphData,
      required this.categoriesIdList,
      required this.notificationdata,
      required this.graphicsdata,
      required this.rechargeServiceList,
      required this.todayList,
      required this.mirrorConnectList,
      required this.graphData,
      required this.silverDetailsResponse,
      required this.tabelName});
}
