import 'package:defenders/model/auth_model/intrest_categories_model.dart';

class AddIntrestModel {
  List<InterestCategoriesResponse> interestCategoriesList;
  List<InterestCategoriesResponse> interestsubSelectedCategoriesList;
  AddIntrestModel(
      {required this.interestCategoriesList,
      required this.interestsubSelectedCategoriesList});
}
