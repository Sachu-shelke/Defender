import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/model/home_model/get_categories_model.dart';

class LeadsWidget extends StatelessWidget {
  final List<CategoriesResponse> graphicsList;
  const LeadsWidget({super.key, required this.graphicsList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppConstString.leads.tr(),
                style: AppTextStyle.semiBold16,
              ),
              Text(
                AppConstString.viewAll,
                style: AppTextStyle.semiBold14
                    .copyWith(color: AppColors.appColors),
              ),
            ],
          ),
        ),
        Container(
          height: (graphicsList.length / 4) * 100,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: graphicsList.length > 12 ? 12 : graphicsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 6.0),
              itemBuilder: (context, index) {
                return GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: 'coming Soon');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderGreyColor),
                        color: AppColors.whiteColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              imageUrl: graphicsList[index].imageurl.toString(),
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Text(
                            graphicsList[index].categoryName.toString(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
