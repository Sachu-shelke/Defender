// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/main.dart';
import 'package:defenders/model/auth_model/login_model.dart';
import 'package:defenders/model/passbook_model/wallet_passbook_model.dart';
import 'package:defenders/model/redeem/redeem_history_model.dart';
import 'package:defenders/model/team_details/team_details_model.dart';
import 'package:defenders/modules/redeem/redeem_model.dart';
import 'package:defenders/modules/redeem/redeem_view.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/button/primary_button.dart';

class RedeemPresenter {
  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {}
  Future<void> sendMoneyUserDetails({
    BuildContext? context,
    required String mobileNumber,
  }) async {}
  Future<void> redeem(
      {required String userId,
      String? amount,
      String? note,
      required BuildContext context}) async {}
  Future<void> redeemHistory(
      {required String userId,
      required bool isFromEwallet,
      BuildContext? context}) async {}
  set updateView(RedeemScreenView incomePassbookView) {}
}

class BasicRedeemPresenter implements RedeemPresenter {
  late RedeemScreenView view;
  late RedeemModel model;
  BasicRedeemPresenter() {
    view = RedeemScreenView();
    model = RedeemModel(
        epinHisoryModel: [],
        isButtonTap: false,
        userDetails: LoginData(),
        teamDetailsData: TeamDetailsData(),
        historyData: []);
  }

  @override
  Future<void> getTeamDetails(
      {required String userId,
      String? planID,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.teamDetails,
        data: {'user_id': userId, 'plan_id': planID},
        context: context);

    if (response != null && response['status'] == 200) {
      model.teamDetailsData = TeamDetailsModel.fromJson(response).data!.first;
    }
    view.refreshModel(model);
  }

  @override
  Future<void> sendMoneyUserDetails({
    BuildContext? context,
    required String mobileNumber,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.sendMoneyUserDeatisl,
        data: {'mobile_no': mobileNumber},
        context: context);
    if (response != null && response['status'] == 200) {
      model.userDetails = LoginModel.fromJson(response).data!;
      showModalBottomSheet(
        context: context!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: ((context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm User Details",
                  style: AppTextStyle.semiBold20,
                ),
                const SizedBox(
                  height: 10,
                ),
                customRow(
                    title: 'Name',
                    value:
                        "${model.userDetails.firstName} ${model.userDetails.lastName}"),
                customRow(
                    title: 'Mobile Number',
                    value: model.userDetails.mobile.toString()),
                customRow(
                    title: 'MR Id', value: model.userDetails.mlmId.toString()),
                customRow(
                    title: 'Referal Id',
                    value: model.userDetails.refmlmId.toString()),
                customRow(
                    title: 'Referal Name',
                    value:
                        "${model.userDetails.refFirstName} ${model.userDetails.refLastName}"),
                customRow(title: 'City', value: "${model.userDetails.circle}"),
                customRow(title: 'State', value: "${model.userDetails.region}"),
                const SizedBox(
                  height: 10,
                ),
                PrimaryButton(
                  text: "Confirm",
                  onTap: () {
                    context.router.push(
                      PrimeDashboardScreenRoute(
                          isFromEpin: true,
                          userId: model.userDetails.id.toString()),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        }),
      );
    } else {
      model.userDetails = LoginData();
    }
    view.refreshModel(model);
  }

  Widget customRow({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.semiBold16,
          ),
          Text(
            ' : ',
            style: AppTextStyle.semiBold16,
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyle.semiBold16.copyWith(color: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> redeem(
      {required String userId,
      String? amount,
      String? note,
      required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.redeem,
        data: {'user_id': userId, 'remarks': note, 'amount': amount},
        context: context);
    model.isButtonTap = false;
    print(response.toString());
    if (response != null && response['status'] == 200) {
      appRouter.pushAndPopUntil(
          RedeemSucessScreenRoute(
              redeemAmount: amount.toString(),
              redeemNumbeer: response['data']['trans_no'].toString()),
          predicate: (route) => false); //data/trans_no
    }
    view.refreshModel(model);
  }

  @override
  Future<void> redeemHistory(
      {required String userId,
      required bool isFromEwallet,
      BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint +
          (isFromEwallet == true
              ? EncryptedApiPath.epinHistory
              : EncryptedApiPath.redeemHistory),
      data: {'user_id': userId, "page": 1},
      // context: context
    );

    if (response != null && response['status'] == 200) {
      if (isFromEwallet == true) {
        model.epinHisoryModel =
            WalletPassbookDataModel.fromJson(response).data!;
      } else {
        model.historyData = RedeemHistoryModel.fromJson(response).data!;
      }
    }
    view.refreshModel(model);
  }

  @override
  set updateView(RedeemScreenView redeemView) {
    view = redeemView;
    view.refreshModel(model);
  }
}
