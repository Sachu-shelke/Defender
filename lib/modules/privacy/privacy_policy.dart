import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Privacy Policy"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: AppSizes.size6,
            ),
            Text(
              '''User Use and Return Policy for Recharge, DTH, and BBPS Services''',
              style: AppTextStyle.semiBold16,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            //
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
              '''Recharge Services: ''',
              style: AppTextStyle.semiBold16,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Users can avail of mobile recharge services for prepaid and postpaid numbers through our application.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),

            const Text(
              '''
Once a recharge transaction is initiated and the payment is successful, it cannot be cancelled or refunded.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),

            const Text(
              '''
Users are responsible for providing accurate mobile numbers and recharge amounts. Incorrect information provided by the user leading to a failed recharge will not be eligible for refunds.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),

            const Text(
              '''
In case of a failed recharge due to technical issues from our end, users will be refunded the recharge amount within 24 hours.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Recharge amounts are subject to the terms and conditions of the respective telecom service providers.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),

            Text(
              '''DTH Services: ''',
              style: AppTextStyle.semiBold16,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Users can recharge their DTH services for various providers available on our platform.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Similar to mobile recharge, once a DTH recharge transaction is initiated and the payment is successful, it cannot be cancelled or refunded.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Users must ensure the accuracy of the subscriber ID and recharge amount provided. Incorrect information leading to a failed recharge will not be eligible for refunds.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
In the event of a failed DTH recharge due to technical issues from our end, users will be refunded the recharge amount within 24 hours.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
DTH recharge amounts are subject to the terms and conditions of the respective DTH service providers.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),

            Text(
              '''BBPS (Bharat Bill Payment System) Services: ''',
              style: AppTextStyle.semiBold16,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Users can pay various utility bills, such as electricity, water, gas, and more, through our BBPS services.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Payments made for BBPS services are considered final and non-refundable once the transaction is successful.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Users must provide accurate bill details and payment amounts. Incorrect information leading to a failed payment will not be eligible for refunds.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
In the case of a failed BBPS transaction due to technical issues from our end, users will be refunded the payment amount within 24 hours.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
BBPS payments are subject to the terms and conditions of the respective billers and service providers.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            Text(
              '''Privacy Policy: ''',
              style: AppTextStyle.semiBold16,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
We are committed to protecting the privacy and security of our users' personal information.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),

            const Text(
              '''
Any personal information collected during the registration process or through transactions will be used solely for the purpose of providing our services and will not be shared with third parties without explicit consent from the user.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
We implement industry-standard security measures to safeguard user data and prevent unauthorized access or disclosure.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Users have the right to access, modify, or delete their personal information stored on our platform at any time.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
We may collect non-personal information such as device information, usage patterns, and analytics data to improve our services and enhance user experience.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
By using our application, users consent to the collection and use of their personal information as outlined in this privacy policy.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            Text(
              '''Legal Terms: ''',
              style: AppTextStyle.semiBold16,
            ),
            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
By using our wallet application and availing of recharge, DTH, and BBPS services, users agree to abide by the terms and conditions outlined in this policy.''',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Any disputes arising from transactions or services provided through our platform shall be subject to the jurisdiction of the courts in Pune Maharashtra.''',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Mirror infotech pvt ltd reserve the right to modify or update this policy at any time without prior notice. Users will be notified of any changes through our application or website.''',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''
Our liability is limited to the amount of the transaction in question. We shall not be liable for any indirect, incidental, or consequential damages arising from the use of our services.''',
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

            const SizedBox(
              height: AppSizes.size6,
            ),
            Text(
              '''Thank you for using our Mirror Services.''',
              style: AppTextStyle.bold16,
            ),

            const SizedBox(
              height: AppSizes.size10,
            ),

            const Text(
              '''
This policy is subject to change at our discretion. Users will be notified of any updates to the policy through our application or website.''',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: AppSizes.size10,
            ),
            const Text(
              '''
For any inquiries or assistance, please contact our customer support team at +91${AppConstString.supportNumber}.''',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(
              height: AppSizes.size6,
            ),
            const Text(
              '''Please ensure to review and customize the data policy according to your specific requirements and consult with legal advisors to ensure compliance with relevant data protection laws and regulations.''',
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
