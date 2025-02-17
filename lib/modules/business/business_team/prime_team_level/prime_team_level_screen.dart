import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/business/business_team/prime_team_level/prime_team_level_model.dart';
import 'package:defenders/modules/business/business_team/prime_team_level/prime_team_level_presenter.dart';
import 'package:defenders/modules/business/business_team/prime_team_level/prime_team_level_view.dart';
import 'package:defenders/modules/business/business_team/team_dashboard/team_dashboard_screen.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/no_transaction_widget.dart';

@RoutePage()
class PrimeTeamLevelScreen extends StatefulWidget {
  final String level;
  final String primeId;
  const PrimeTeamLevelScreen(
      {super.key, required this.level, required this.primeId});

  @override
  State<PrimeTeamLevelScreen> createState() => _PrimeTeamLevelScreenState();
}

class _PrimeTeamLevelScreenState extends State<PrimeTeamLevelScreen>
    implements PrimeTeamLevelView {
  late PrimeTeamLevelModel model;
  PrimeTeamLevelPresenter presenter = BasicPrimeTeamLevelPresenter();
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  String showIdLike = "All";
  @override
  void initState() {
    presenter.updateView = this;

    presenter.getTeamDetails(
        userID: GlobalSingleton.loginInfo!.data!.id.toString(),
        level: widget.level,
        context: context,
        primeId: widget.primeId,
        page: page);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        (_scrollController.offset)) {
      // if (model.lastPageIndex > page) {
      setState(() {
        page++;
      });
      presenter.getTeamDetails(
          page: page,
          level: widget.level,
          primeId: widget.primeId,
          context: context,
          userID: GlobalSingleton.loginInfo!.data!.id.toString());
    }
  }

  @override
  void refreshModel(PrimeTeamLevelModel primeTeamLevelModel) {
    model = primeTeamLevelModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Level ${widget.level}',
        actions: [
          if (widget.primeId == "3" || widget.primeId == "0")
            PopupMenuButton(
              padding: EdgeInsets.zero,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                child: Text(
                  "$showIdLike ▼",
                  style: AppTextStyle.semiBold20
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
              onSelected: (value) {
                page++;
                presenter.getTeamDetails(
                    page: page,
                    level: widget.level,
                    primeId: widget.primeId,
                    context: context,
                    userID: GlobalSingleton.loginInfo!.data!.id.toString());
                showIdLike = value;
                setState(() {});
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    value: 'All',
                    child: Text("All"),
                  ),
                  PopupMenuItem(
                    value: 'Active',
                    child: Text("Active"),
                  ),
                  PopupMenuItem(
                    value: 'Inactive',
                    child: Text("Inactive"),
                  ),
                ];
              },
            ),
        ],
      ),
      body: Stack(
        children: [
          if (model.teamDetailsdata.isNotEmpty)
            ListView.builder(
                itemCount: model.teamDetailsdata.length,
                shrinkWrap: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (showIdLike == "Inactive" &&
                      model.teamDetailsdata[index].plan != null) {
                    return const SizedBox();
                  } else if (showIdLike == "Active" &&
                      model.teamDetailsdata[index].plan == null) {
                    return const SizedBox();
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeamDashboardScreen(
                                    data: model.teamDetailsdata[index],
                                  )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 4,
                                offset: Offset(1, 3),
                                color: AppColors.containerShaddowbg,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          model.teamDetailsdata[index].plan !=
                                                  null
                                              ? AppColors.sucessGreen
                                              : AppColors.errorColor),
                                ),
                                const SizedBox(
                                  width: AppSizes.size10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.teamDetailsdata[index].name
                                          .toString(),
                                      style: AppTextStyle.semiBold14,
                                    ),
                                    const SizedBox(
                                      height: AppSizes.size4,
                                    ),
                                    Text(
                                      'User Id ${model.teamDetailsdata[index].mlmId}',
                                      style: AppTextStyle.semiBold14,
                                    ),
                                    const SizedBox(
                                      height: AppSizes.size4,
                                    ),
                                    Text(
                                      'DOJ ${model.teamDetailsdata[index].joiningDate}',
                                      style: AppTextStyle.semiBold14,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    CommonMethod.call(
                                        number: model
                                            .teamDetailsdata[index].mobile
                                            .toString());
                                  },
                                  child: Image.asset(
                                    AppAssets.phoneIcon,
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }),
          if (model.teamDetailsdata.isEmpty)
            const Center(
              child: NoTransaction(
                str: 'No Data Found',
              ),
            )
        ],
      ),
    );
  }
}
