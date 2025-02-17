import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/team_details/team_details_info_model.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class TodayPrimeDirectScreen extends StatefulWidget {
  final bool isFromPrime;
  const TodayPrimeDirectScreen({super.key, required this.isFromPrime});

  @override
  State<TodayPrimeDirectScreen> createState() => _TodayPrimeDirectScreenState();
}

class _TodayPrimeDirectScreenState extends State<TodayPrimeDirectScreen> {
  List<TeamDetailsInfoData> modelList = <TeamDetailsInfoData>[];

  @override
  void initState() {
    getTeamDetails(
        page: 1,
        userID: GlobalSingleton.loginInfo!.data!.id.toString(),
        context: context);
    super.initState();
  }

  Future<void> getTeamDetails({
    required String userID,
    BuildContext? context,
    required int page,
  }) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.dailyTeamDetails,
      context: context,
      data: {
        'user_id': userID,
        "type": widget.isFromPrime == true ? "Prime" : "Team",
        'page': page
      },
    );
    if (response != null && response['status'] == 200) {
      if (page == 1) {
        modelList = TeamDetailsInfoModel.fromJson(response).data!;
      } else {
        modelList.addAll(TeamDetailsInfoModel.fromJson(response).data!);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.isFromPrime == true ? "Today Prime" : "Today Team",
        ),
        body: ListView.builder(
          itemCount: modelList.length,
          // controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // CallLogEntry log = reciveentries![index];
            return InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TeamPortfolioScreen(
                //       userInfo: modelList[index],
                //     ),
                //   ),
                // );
                // TeamDashboardScreen
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.appColors),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.appColors,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(6, 6),
                                  blurRadius: 15.0,
                                  color: Color.fromARGB(255, 132, 179, 202),
                                  spreadRadius: 1)
                            ]),
                        alignment: Alignment.topCenter,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(20),
                            child: Image.asset(
                              AppAssets.appLogo,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name : ${modelList[index].name.toString()}'),
                          Text(
                              'Mobile Number : ${modelList[index].mobile.toString()}'),
                          Text(
                              'Date of Join : ${modelList[index].joiningDate.toString()}'),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          // CommonMethod().getUserLog(action: 'Call', id: 4);
                          if (modelList[index].mobile != null) {
                            CommonMethod.whatsapp(
                                mobileNumber:
                                    modelList[index].mobile.toString());
                          }
                        },
                        child: Image.asset(
                          AppAssets.whatsapp,
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      InkWell(
                        onTap: () async {
                          if (modelList[index].mobile != null) {
                            // getTimeFunction();
                            // CommonMethod().getUserLog(action: 'Call', id: 4);
                            await FlutterPhoneDirectCaller.callNumber(
                                modelList[index].mobile.toString());

                            // await FlutterPhoneDirectCaller.callNumber(
                            //     modelList[index].mobile.toString());
                            // _incrementDailyCount();
                          }
                          setState(() {});
                        },
                        child: Image.asset(
                          AppAssets.phoneIcon,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  )
                  // ListTile(
                  //   title: Text('Name: ${log.name ?? ''}'),
                  //   subtitle: Text('Mobile Number :- ${log.number ?? ''}'),
                  // ),
                  ),
            );
          },
        ));
  }
}
