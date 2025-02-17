import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/auth/registration/footer/signup_footer.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

@RoutePage()
class TermAndConditionScreen extends StatefulWidget {
  // final RegistrationPresenter presenter;
  // final SignupModel signupModel;
  const TermAndConditionScreen({
    super.key,
    // required this.signupModel, required this.presenter
  });

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  bool _checked = false;

  _onChanged(bool? value) {
    setState(() {
      _checked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
            leading: const SizedBox(),
            title: AppConstString.termsandConditions.tr()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              const Text(
                '''
    When joining an ${AppConstString.appName} affiliate program as a user, there are typically rules and regulations that govern your participation. While the specifics can vary between join ${AppConstString.appName} affiliate programs, these are rules and regulations that you want to follow:
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                '''Application and Acceptance: ''',
                style: AppTextStyle.semiBold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    You must complete an application to join the affiliate program.
    The ${AppConstString.appName} infoTech Pvt Ltd reserves the right to accept or reject your application.
    The ${AppConstString.appName} infoTech Pvt Ltd may consider factors such as website quality, content relevance, traffic, and promotional methods.
     ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                'Affiliate Responsibilities:',
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    You are responsible for accurately representing the ${AppConstString.appName} infoTech Pvt Ltd's products or services.
    You must join companies official meting regulalry.
    
    You must comply with all applicable laws, regulations, and industry standards.
    You are responsible for ensuring that your promotional activities are ethical and do not mislead or deceive users.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                'Affiliate Links and Tracking:',
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName} infoTech Pvt Ltd will provide you with unique affiliate links or codes to track referrals.
    You must use the provided affiliate links or codes to ensure accurate tracking of referred sales or leads.
    You may not modify or manipulate the affiliate links or codes without explicit permission.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                'Commission Structure:',
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName} infoTech Pvt Ltd will specify the commission rates or referral fees applicable to your affiliate account.
    The commission structure may vary based on different products, services, or referral types.
    The ${AppConstString.appName} infoTech Pvt Ltd may outline any restrictions or exclusions on commission eligibility.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Promotion Guidelines:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName} infoTech Pvt Ltd may provide guidelines on how you can promote their products or services.
    The guidelines may include approved marketing materials, advertising platforms, and content restrictions.
    You may be prohibited from engaging in certain promotional tactics or using misleading advertising.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Payment Terms:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName} infoTech Pvt Ltd will specify the payment terms, including the payment schedule and method.
    You may need to reach a minimum threshold before receiving payment.
    The ${AppConstString.appName} infoTech Pvt Ltd may deduct transaction fees or other applicable charges from your commission.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Termination:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd has the right to terminate your affiliate account at any time.
    Termination may occur due to violation of program rules, unethical behavior, or non-compliance with terms and conditions.
    Upon termination, you may lose access to affiliate links, pending commissions, and promotional materials.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Reporting and Communication:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd may provide regular reports on referred sales or leads.
    You may have access to a dashboard or affiliate portal to monitor your performance and earnings.
    Communication channels, such as email or support tickets, will be available for affiliate-related inquiries or support.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Intellectual Property:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    You must respect the ${AppConstString.appName}info Tech Pvt Ltd's intellectual property rights, including trademarks, logos, and branding.
    Proper usage guidelines for the ${AppConstString.appName}info Tech Pvt Ltd's intellectual property may be provided.
    Unauthorized use or misrepresentation of the ${AppConstString.appName}info Tech Pvt Ltd's intellectual property may lead to termination.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Amendments and Modifications:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd may update or modify the rules and regulations of the affiliate program.
    You will be notified of any changes, and it is your responsibility to review and comply with the updated terms.
    It is crucial to carefully read and understand the specific rules and regulations provided by the ${AppConstString.appName}info Tech Pvt Ltd's affiliate program. If you have any questions or concerns, reach out to the program representative for clarification. Compliance with the rules and regulations will help ensure a successful and mutually beneficial affiliate partnership.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Royalty Ruls and regulations:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    When it comes to affiliate programs and the payment of royalties to users, the rules and regulations can vary between ${AppConstString.appName}INFO TECH PVT LTD and Users. However, here are some detailed guidelines that are commonly associated with the payment of royalties to affiliate users:
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Eligibility and Application:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    Users must meet the eligibility criteria specified by the affiliate program.
    Users typically need to submit an application to join the program.
    The ${AppConstString.appName}info Tech Pvt Ltd reserves the right to accept or reject applications.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Royalty Calculation:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd will outline the method for calculating royalties.
    Royalties may be based on a percentage of prime sales.
    The specific commission rates or royalty percentages for different products or services should be clearly stated.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Tracking and Reporting:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd will provide users with unique affiliate links or codes to track referrals.
    It is the user's responsibility to use the provided links or codes to ensure accurate tracking of referred sales or leads.
    Regular reports on referred sales or leads will be provided by the ${AppConstString.appName}info Tech Pvt Ltd.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Payment Terms:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd will specify the payment terms, including the payment schedule and method.
    Users may need to reach a minimum threshold before receiving royalty payments.
    The ${AppConstString.appName}info Tech Pvt Ltd may deduct transaction fees or other applicable charges from the royalties.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Compliance with Policies:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    Users are expected to comply with all applicable laws, regulations, and industry standards.
    Users must adhere to the program's policies and guidelines, including those related to marketing and promotional activities.
    Ethical and transparent promotion of the ${AppConstString.appName}info Tech Pvt Ltd's products or services is required.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Communication and Support:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd will provide communication channels for affiliate-related inquiries and support.
    Users may have access to a dashboard or affiliate portal to monitor their performance and royalty earnings.
    Timely and effective communication between the user and the ${AppConstString.appName}info Tech Pvt Ltd is expected.
    ''',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              Text(
                "Amendments and Modifications:",
                style: AppTextStyle.bold16,
              ),
              const SizedBox(
                height: AppSizes.size6,
              ),
              const Text(
                '''
    The ${AppConstString.appName}info Tech Pvt Ltd may update or modify the rules and regulations of the affiliate program.
    Users will be notified of any changes, and it is their responsibility to review and comply with the updated terms.
    It is essential for users to carefully review the specific rules and regulations provided by the ${AppConstString.appName}info Tech Pvt Ltd's affiliate program before participating. If there are any questions or concerns, users should reach out to the program representative for clarification. Understanding and adhering to the rules and regulations will ensure a smooth and transparent royalty payment process.
    ''',
                textAlign: TextAlign.justify,
              ),
              SignupFooter(
                checked: _checked,
                onChanged: _onChanged,
              ),
              const SizedBox(
                height: AppSizes.size10,
              ),
              InkWell(
                onTap: () {
                  if (_checked) {
                    context.router.push(MainHomeScreenRoute());
                    // context.router.push(SignupProfileScreenRoute(
                    //     presenter: widget.presenter,
                    //     signmodel: widget.signupModel));
                    // widget.presenter.register(
                    //   context: context,
                    //   model: widget.signupModel,
                    // );
                  } else {
                    CommonMethod().dialogData(
                        context: context,
                        title: 'Error',
                        errorMessage: "Please accept terms and conditions");
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBars.errorSnackBar(
                    //       title: 'Please accept terms and conditions'),
                    // );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.appColors),
                  child: Center(
                    child: Text(
                      AppConstString.next.tr(),
                      style: AppTextStyle.bold14
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
