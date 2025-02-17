import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/marketing/marketing_dashboard/marketing_dashboard_screen.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class BrochureScreen extends StatefulWidget {
  const BrochureScreen({super.key});

  @override
  State<BrochureScreen> createState() => _BrochureScreenState();
}

class _BrochureScreenState extends State<BrochureScreen> {
  int brochureIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Brochure"),
      body: Column(children: [
        const SizedBox(
          height: AppSizes.size10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                brochureIndex = 0;
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                    color: brochureIndex == 0
                        ? AppColors.appColors
                        : const Color(0xff3F3D3C),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(
                  'Hindi',
                  style: AppTextStyle.semiBold14
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                brochureIndex = 1;
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: brochureIndex == 1
                      ? AppColors.appColors
                      : const Color(0xff3F3D3C),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  'English',
                  style: AppTextStyle.semiBold14
                      .copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
        // if (isDetailsBenifits == false)
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width,
          child: PDFScreen(
            path: brochureIndex == 0
                ? 'https://secure.mirror.org.in/uploads/ebookPdf/mirrorBroucher/MirrorPPTHindi.pdf'
                : 'https://secure.mirror.org.in/uploads/ebookPdf/mirrorBroucher/MirrorEnglishBrocher.pdf',
          ),
        ),
      ]),
    );
  }
}
