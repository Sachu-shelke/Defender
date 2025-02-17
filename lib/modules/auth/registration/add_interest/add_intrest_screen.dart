import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_model.dart';
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_presenter.dart';
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_view.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

@RoutePage()
class InterestScareen extends StatefulWidget {
  // final SignupModel signupModel;
  // final RegistrationPresenter presenter;
  const InterestScareen({
    super.key,
    // required this.signupModel,
    // required this.presenter,
  });

  @override
  State<InterestScareen> createState() => _InterestScareenState();
}

class _InterestScareenState extends State<InterestScareen>
    with WidgetsBindingObserver
    implements AddIntrestView {
  AddIntrestPresenter presenter = BasicAddIntrestPresenter();
  late AddIntrestModel model;
  @override
  void initState() {
    presenter.registrationView = this;
    presenter.getCategories(context: context);
    super.initState();
  }

  @override
  void refreshModel(AddIntrestModel addIntrestModel) {
    if (mounted) {
      setState(() {
        model = addIntrestModel;
      });
    }
  }

  // final intrestController = Get.put(InterestController());
  TextEditingController controller = TextEditingController();

  addInterest() {
    if (model.interestsubSelectedCategoriesList.length > 3) {
      List idList = [];

      for (var i = 0; i < model.interestsubSelectedCategoriesList.length; i++) {
        idList.add(model.interestsubSelectedCategoriesList[i].interestId);
      }

      presenter.addCategories(

          // signUpPresenter: widget.presenter,
          // signupModel: widget.signupModel,
          idList: idList,
          context: context);

      // BlocProvider.of<HomeCubit>(context).addUserInterest(
      //     userId: widget.signupModel.mobile.toString(),
      //     interestSubcategoryId: idList);
    } else {
      CommonMethod().dialogData(
          context: context,
          title: 'Error',
          errorMessage: "Please select at least 4 interests'");
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBars.errorSnackBar(title: 'Please select at least 4 interests'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          leading: const SizedBox(),
          title: "Interest",
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: InkWell(
                onTap: () {
                  addInterest();
                },
                child: const Text(
                  'NEXT',
                  textScaleFactor: 1.0,
                  style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Text(
                'What do you want to get on Mirror?',
                style: AppTextStyle.semiBold24,
              ),
              const SizedBox(
                height: AppSizes.size16,
              ),
              const Text(
                  'Select at least 4 Interests to personalize your MIRROR experience. it will be applied to your use.'),
              const SizedBox(
                height: AppSizes.size10,
              ),
              if (model.interestsubSelectedCategoriesList.isNotEmpty)
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.containerShaddowbg.withOpacity(0.10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: model.interestsubSelectedCategoriesList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColors.appColors)),
                          child: Text(
                            model.interestsubSelectedCategoriesList[index]
                                .interestName!,
                            textScaleFactor: 1.0,
                          ),
                        );
                      }),
                ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.7,
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: model.interestCategoriesList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          InkWell(
                            onTap: () {
                              if (model.interestCategoriesList[index]
                                      .isSelected ==
                                  false) {
                                model.interestsubSelectedCategoriesList
                                    .add(model.interestCategoriesList[index]);
                              } else {
                                model.interestsubSelectedCategoriesList.remove(
                                    model.interestCategoriesList[index]);
                              }
                              model.interestCategoriesList[index].isSelected =
                                  !model.interestCategoriesList[index]
                                      .isSelected!;
                              setState(() {});
                              // context.router
                              //     .push(InterestSubScareen(
                              //       interestSubCatName: model
                              //           .interestCategoriesList[index].interestName
                              //           .toString(),
                              //       interestSubCatId: model
                              //           .interestCategoriesList[index].interestId
                              //           .toString(),
                              //     ))
                              //     .then((value) => {setState(() {})});
                            },
                            child: Container(
                              // margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.containerbg,
                                  border: Border.all(
                                      width: 2,
                                      color: model.interestCategoriesList[index]
                                                  .isSelected ==
                                              true
                                          ? Colors.green.shade900
                                          : AppColors.containerbg)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // if (intrestController
                                  //         .interestCategoriesList[index].icon !=
                                  //     null)
                                  //   CachedNetworkImage(
                                  //     imageUrl: intrestController
                                  //         .interestCategoriesList[index].icon!,
                                  //     fit: BoxFit.fill,
                                  //     height: 100,
                                  //     width: 100,
                                  //     progressIndicatorBuilder: (context, url,
                                  //             downloadProgress) =>
                                  //         const Center(
                                  //             child:
                                  //                 CircularProgressIndicator()),
                                  //     errorWidget: ((context, url, error) =>
                                  //         Container()),
                                  //   ),
                                  Expanded(
                                    child: Text(
                                      model.interestCategoriesList[index]
                                          .interestName
                                          .toString(),
                                      textScaleFactor: 1.0,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.regular16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (model.interestCategoriesList[index].isSelected ==
                              true)
                            Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.secoundColors),
                                ))
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addInterest();
          },
          child: const Center(
              child: Text(
            'Next',
            textScaleFactor: 1.0,
            style: TextStyle(color: AppColors.whiteColor),
          )),
        ),
      ),
    );
  }
}
