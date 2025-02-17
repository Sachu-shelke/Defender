import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_payment/send_money_payment_model.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_payment/send_money_payment_presenter.dart';
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_payment/send_money_payment_view.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/numbers_to_word.dart';
import 'package:defenders/widget/textfields/amount_text_field.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';

@RoutePage()
class SendMoneyPaymentScreen extends StatefulWidget {
  final String mobileNumber;
  final String userName;
  final String userID;
  const SendMoneyPaymentScreen({
    super.key,
    required this.mobileNumber,
    required this.userName,
    required this.userID,
  });

  @override
  State<SendMoneyPaymentScreen> createState() => _SendMoneyPaymentScreenState();
}

class _SendMoneyPaymentScreenState extends State<SendMoneyPaymentScreen>
    implements SendMoneyPaymentView {
  SendMoneyPaymentPresenter presenter = BasicSendMoneyPaymentPresenter();
  late SendMoneyPaymentModel model;
  late TextEditingController _amountController;
  late TextEditingController _mesageController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _amountController = TextEditingController();
    _mesageController = TextEditingController();
    presenter.updateView = this;
    super.initState();
  }

  @override
  void refreshModel(SendMoneyPaymentModel sendMoneyPaymentModel) {
    model = sendMoneyPaymentModel;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.arrow_back),
                    Expanded(
                      child: ListTile(
                        leading: Image.asset(
                          AppAssets.appLogo,
                          height: 45,
                          width: 45,
                        ),
                        title: Text(
                          widget.userName,
                          style: AppTextStyle.regular16,
                        ),
                        subtitle: Text('+91 ${widget.mobileNumber}'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                Row(
                  children: [
                    const Text('To'),
                    const SizedBox(
                      width: AppSizes.size50,
                    ),
                    Image.asset(
                      AppAssets.logo,
                      height: 25,
                      width: 25,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: AppSizes.size10,
                    ),
                    const Text('Mayway Bussiness  Linked wallet A/c')
                  ],
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                const Divider(),
                const SizedBox(
                  height: AppSizes.size30,
                ),
                AmountTextField(
                  controller: _amountController,
                  validator: (value) {
                    return value!.length > 100000
                        ? 'You Can only send Rs. 1 Lakh at a time. Please enter a lower amount'
                        : null;
                  },
                  onChanged: (p0) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                if (_amountController.text.isNotEmpty) ...[
                  (double.parse(_amountController.text) < 100000)
                      ? Text(
                          "Rupees ${NumberToWord().convert(Locale.en_ind, int.parse(_amountController.text))} Only",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular14
                              .copyWith(color: AppColors.textGreyColor),
                        )
                      : Text(
                          'You Can only send Rs. 1 Lakh at a time. Please enter a lower amount',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.regular14
                              .copyWith(color: AppColors.textColorRed),
                        ),
                ],
                const SizedBox(
                  height: AppSizes.size10,
                ),
                DefaultTextField(
                  controller: _mesageController,
                  // isValidation: true,
                  color: AppColors.whiteColor,
                  // vaidation: (p0) => null,
                  labelTextStrr: 'Add Message',
                ),
                const Spacer(),
                const Divider(),
                const SizedBox(
                  height: AppSizes.size30,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedPrimaryButton(
                  text:
                      'Pay Securely ${AppConstString.rupeesSymbol + _amountController.text} ',
                  isOntapValid: true,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      presenter.sendMoney(
                          context: context,
                          amount: _amountController.text,
                          message: _mesageController.text,
                          mobileNumber: widget.mobileNumber,
                          userId: widget.userID);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
