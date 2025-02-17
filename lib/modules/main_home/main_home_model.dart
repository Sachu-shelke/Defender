import 'package:defenders/model/prime_plan_model/get_prime_plan_details_model.dart';

class MainHomeModel {
  int selectedIndex;
  List<GetPrimePlanDetailsData> primeList;

  MainHomeModel({
    required this.selectedIndex,
    required this.primeList,
  });
}
