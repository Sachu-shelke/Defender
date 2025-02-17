import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/business/business_team/prime_team/prime_team_model.dart';
import 'package:defenders/modules/business/business_team/prime_team/prime_team_presenter.dart';
import 'package:defenders/modules/business/business_team/prime_team/prime_team_view.dart';
import 'package:defenders/modules/business/business_widget/team_level_widget.dart';
import 'package:defenders/modules/business/business_widget/user_business_details.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';

@RoutePage()
class PrimeTeamScreen extends StatefulWidget {
  final String planId;

  const PrimeTeamScreen({super.key, @PathParam('catId') required this.planId});

  @override
  State<PrimeTeamScreen> createState() => _PrimeTeamScreenState();
}

class _PrimeTeamScreenState extends State<PrimeTeamScreen>
    implements PrimeTeamView {
  late PrimeTeamModel model;
  PrimeTeamPresenter presenter = BasicPrimeTeamPresenter();
  String planId = '3';

  @override
  void initState() {
    presenter.updateView = this;
    planId = widget.planId;
    presenter.getTeamDetails(
        userId: GlobalSingleton.loginInfo!.data!.id.toString(),
        planID: planId,
        context: context);
    super.initState();
  }

  @override
  void refreshModel(PrimeTeamModel primeTeamModel) {
    model = primeTeamModel;
    if (mounted) {
      setState(() {});
    }
  }

  String getPlanName() {
    switch (planId) {
      case '0':
        return 'My Team';
      case '1':
        return 'Hybrid Team';
      case '2':
        return 'Booster Team';
      case '3':
        return 'Prime A Team';
      case '4':
        return 'Prime B Team';
      default:
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getPlanName(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: UserBusinessDetails(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: PrimaryButton(
                      text: 'Prime B',
                      color: Colors.green,
                      onTap: () {
                        if (planId != '4') {
                          planId = '4';
                          presenter.getTeamDetails(
                              userId: GlobalSingleton.loginInfo!.data!.id
                                  .toString(),
                              planID: '4',
                              context: context);
                          setState(() {});
                          // context.router
                          //     .push(PrimeTeamScreenRoute(planId: '4'));
                        }
                      },
                    )),
                    const SizedBox(
                      width: AppSizes.size6,
                    ),
                    Expanded(
                        child: PrimaryButton(
                      text: 'Booster',
                      color: Colors.black,
                      onTap: () {
                        if (planId != '2') {
                          planId = '2';
                          presenter.getTeamDetails(
                              userId: GlobalSingleton.loginInfo!.data!.id
                                  .toString(),
                              planID: '2',
                              context: context);
                          setState(() {});
                          // context.router
                          //     .push(PrimeTeamScreenRoute(planId: '2'));
                        }
                      },
                    )),
                    const SizedBox(
                      width: AppSizes.size6,
                    ),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Hybrid',
                        color: Colors.blue,
                        onTap: () {
                          if (planId != '1') {
                            planId = '1';
                            presenter.getTeamDetails(
                                userId: GlobalSingleton.loginInfo!.data!.id
                                    .toString(),
                                planID: '1',
                                context: context);
                            setState(() {});
                            // context.router
                            //     .push(PrimeTeamScreenRoute(planId: '1'));
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.size6,
                    ),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Prime A',
                        color: Colors.orange,
                        onTap: () {
                          if (planId != '3') {
                            planId = '3';
                            presenter.getTeamDetails(
                                userId: GlobalSingleton.loginInfo!.data!.id
                                    .toString(),
                                planID: '3',
                                context: context);
                            setState(() {});
                            // context.router
                            //     .push(PrimeTeamScreenRoute(planId: '3'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (model.teamDetails != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTeamTitle(
                    isOnPress: (planId == '0' || planId == '3') ? true : false,
                    activeUsers:
                        model.teamDetails!.data!.first.totalActive.toString(),
                    inactiveUsers:
                        model.teamDetails!.data!.first.totalInactive.toString(),
                    title: 'My Team',
                    color: Colors.yellow[700]!,
                  ),
                ),
              if (model.teamDetails != null)
                ListView.builder(
                    itemCount: model.teamDetails!.leveldata!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MyLevelTeam(
                        planId: planId,
                        isOnPress: true,
                        // (planId == '0' || planId == '3') ? true : false,
                        activeUsers: model
                            .teamDetails!.leveldata![index].totalActive
                            .toString(),
                        inactiveUsers: model
                            .teamDetails!.leveldata![index].totalInactive
                            .toString(),
                        index: model.teamDetails!.leveldata![index].level
                            .toString(),
                        totalUsers: (planId == '0' || planId == '3')
                            ? model.teamDetails!.leveldata![index].levelcount
                                .toString()
                            : model.teamDetails!.leveldata![index].totalActive
                                .toString(),
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class MyTeamTitle extends StatelessWidget {
  final String title;
  final String activeUsers;
  final String inactiveUsers;
  final Color color;
  final bool isOnPress;
  const MyTeamTitle(
      {super.key,
      required this.title,
      required this.color,
      required this.activeUsers,
      required this.isOnPress,
      required this.inactiveUsers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.containerbg,
        border: Border.all(width: 1.5, color: Colors.red),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(title, textScaleFactor: 1.0, style: AppTextStyle.semiBold16),
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              if (isOnPress == true)
                const CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 10,
                ),
              if (isOnPress == true)
                const SizedBox(
                  width: 10,
                ),
              if (isOnPress == true)
                Text(inactiveUsers,
                    textScaleFactor: 1.0, style: AppTextStyle.semiBold16),
              if (isOnPress == true)
                const SizedBox(
                  width: 20,
                ),
              const CircleAvatar(
                backgroundColor: AppColors.successColor,
                radius: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(activeUsers,
                  textScaleFactor: 1.0, style: AppTextStyle.semiBold16),
            ],
          ),
        ],
      ),
    );
  }
}
