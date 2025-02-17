import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/data_uploading/data_uploading_model.dart';
import 'package:defenders/modules/data_uploading/data_uploading_presenter.dart';
import 'package:defenders/modules/data_uploading/data_uploading_view.dart';
import 'package:defenders/widget/button/primary_button.dart';

@RoutePage()
class DataUploadingScreen extends StatefulWidget {
  const DataUploadingScreen({super.key});

  @override
  State<DataUploadingScreen> createState() => _DataUploadingScreenState();
}

class _DataUploadingScreenState extends State<DataUploadingScreen>
    implements DataUploadingView {
  DataUploadingPresenter presenter = BasicDataUploadingPresenter();
  late DataUploadingModel model;
  bool isStart = false;
  final double _progressValue = 0.0;
// 5 minutes

  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
  }

  @override
  void refreshModel(DataUploadingModel incomePassbookModel) {
    model = incomePassbookModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: AppSizes.size30,
            ),
            Image.asset(
              AppAssets.backup,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Text(
              'Backup found',
              style: AppTextStyle.semiBold26.copyWith(color: Colors.green),
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            Text(
              'Restoring your data from server. Please wait Some Time',
              style: AppTextStyle.semiBold16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSizes.size50,
            ),
            if (isStart == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.appColors,
                  ),
                  minHeight: 10,
                  value: _progressValue,
                ),
              ),
            if (isStart == true)
              Text(
                'Backup ${(_progressValue * 100).toStringAsFixed(2)}% complete',
                style: const TextStyle(fontSize: 18.0),
              ),
          ],
        ),
      ),
      bottomNavigationBar: isStart == true
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                  onTap: () {
                    isStart = true;
                    _startTimer();
                    presenter.getBackupData(
                      context: context,
                    );
                  },
                  text: 'Start'),
            ),
    );
  }

  void _startTimer() {}
}
