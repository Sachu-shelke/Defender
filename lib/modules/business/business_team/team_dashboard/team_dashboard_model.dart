import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';

class TeamDashboardModel {
  List<DashboardIncomeList> incomeList;
  TeamDetailsModel? teamDetails;
  TeamDashboardModel({
    required this.incomeList,
    this.teamDetails,
  });
}
