import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_storage_key.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

@RoutePage()
class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = StorageManager.getIntValue(
          AppStorageKey.appLanguageSelectedIndex,
        ) ??
        0;
    setState(() {});
    super.initState();
  }

  List lang = [
    {"lan": "English", "code": "en", "Country": "US"},
    {"lan": "हिंदी", "code": "hi", "Country": "IN"},
    {"lan": "मराठी", "code": "mr", "Country": "IN"},
    {"lan": "ગુજરાતી", "code": "gu", "Country": "IN"},
    {"lan": "தமிழ்", "code": "ta", "Country": "IN"}, // tamil
    {"lan": "తెలుగు", "code": "te", "Country": "IN"}, //telugu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Language'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lang.length,
              itemBuilder: ((context, index) => customAppListTile(
                  index: index,
                  title: lang[index]['lan'],
                  onTap: () {
                    selectedIndex = index;
                    setState(() {});
                  })),
            ),
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          EasyLocalization.of(context)!.setLocale(
            Locale(lang[selectedIndex]['code'], lang[selectedIndex]['Country']),
          );
          StorageManager.setIntValue(
              key: AppStorageKey.appLanguageSelectedIndex,
              value: selectedIndex);

          Fluttertoast.showToast(msg: 'Language Changed!');
          setState(() {});
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          color: AppColors.appColors,
          child: Center(
            child: Text(
              AppConstString.ctn.tr(),
              style: AppTextStyle.bold18.copyWith(color: AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget customAppListTile(
      {required int index, required String title, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyle.semiBold18.copyWith(
                  color: selectedIndex == index
                      ? AppColors.appColors
                      : AppColors.blackColor),
            ),
            const Spacer(),
            if (selectedIndex == index)
              const Icon(
                Icons.check_box,
                color: AppColors.appColors,
              )
          ],
        ),
      ),
    );
  }
}
