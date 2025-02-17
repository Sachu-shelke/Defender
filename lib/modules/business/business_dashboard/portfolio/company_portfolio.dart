import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:defenders/modules/data_uploading/data_uploading_screen.dart';

class CompanyPortfolio extends StatefulWidget {
  final BusinessDashboardModel model;
  const CompanyPortfolio({super.key, required this.model});

  @override
  State<CompanyPortfolio> createState() => _CompanyPortfolioState();
}

class _CompanyPortfolioState extends State<CompanyPortfolio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.size10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DataUploadingScreen()));
          },
          child: Text(
            "Today's Business",
            style: AppTextStyle.semiBold18,
          ),
        ),
        SizedBox(
          height: (widget.model.companyIncomeList.length) * 47,
          child: GridView.builder(
            itemCount: widget.model.companyIncomeList.length,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(1, 2),
                          color: AppColors.containerShaddowbg,
                          spreadRadius: 2)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.model.companyIncomeList[index].color !=
                              null)
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    widget.model.companyIncomeList[index].color,
                              ),
                            ),
                          if (widget.model.companyIncomeList[index].color !=
                              null)
                            const SizedBox(
                              width: AppSizes.size6,
                            ),
                          Text(
                            widget.model.companyIncomeList[index].income,
                            style: AppTextStyle.black20
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.size6,
                      ),
                      Text(
                        widget.model.companyIncomeList[index].name,
                        style: AppTextStyle.regular14,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: AppSizes.size10,
        ),
        Text(
          "This Month Royalty",
          style: AppTextStyle.semiBold18,
        ),
        SizedBox(
          height: (widget.model.companyRoyalityList.length) * 48,
          child: GridView.builder(
            itemCount: widget.model.companyRoyalityList.length,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(1, 2),
                          color: AppColors.containerShaddowbg,
                          spreadRadius: 2)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.model.companyRoyalityList[index].color !=
                              null)
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget
                                    .model.companyRoyalityList[index].color,
                              ),
                            ),
                          if (widget.model.companyRoyalityList[index].color !=
                              null)
                            const SizedBox(
                              width: AppSizes.size6,
                            ),
                          Text(
                            widget.model.companyRoyalityList[index].income,
                            style: AppTextStyle.black20
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.size6,
                      ),
                      Text(
                        widget.model.companyRoyalityList[index].name,
                        style: AppTextStyle.regular14,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
