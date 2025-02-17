import 'package:defenders/model/graphics/new_graphics/new_get_graphics_categories_model.dart';
import 'package:defenders/model/graphics/new_graphics/new_get_graphics_modekl.dart';

class MarketingDashboardModel {
  List<NewGraphicsCategoryData> marketingCategories;
  List<NewGraphicsCategoryData> todaysStatus;
  List<NewGetGraphicsData> marketingSubCategories;
  NewGraphicsCategoryData? isSelectedValue;
  MarketingDashboardModel(
      {required this.marketingCategories,
      required this.isSelectedValue,
      required this.todaysStatus,
      required this.marketingSubCategories});
}

// class MarketingDashboardModel {
//   GetGraphicsCategoryModel graphicsdata;
//   MarketingDashboardModel({required this.graphicsdata});
// }
