part of 'router_import.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashScreenRoute.page, path: '/', initial: true),
        AutoRoute(
          page: HackedDataScreenRoute.page,
        ),
        AutoRoute(
          page: OtpScreenRoute.page,
        ),
        AutoRoute(
          page: FeedbackScreenRoute.page,
        ),

        AutoRoute(
          page: ForgetPasswordScreenRoute.page,
        ),
        AutoRoute(
          page: LoginScreenRoute.page,
        ),
        AutoRoute(
          page: PinCodeOtpRoute.page,
        ),
        AutoRoute(
          page: MainHomeScreenRoute.page,
        ),
        AutoRoute(
          page: AddMoneySucessScreenRoute.page,
        ),
        AutoRoute(
          page: NoInternetScreenRoute.page,
        ),
        AutoRoute(
          page: TermAndConditionScreenRoute.page,
        ),
        AutoRoute(
          page: DataUploadingScreenRoute.page,
        ),
        AutoRoute(
          page: InterestScareenRoute.page,
        ),
        AutoRoute(
          page: PrimeSucessScreenRoute.page,
        ),

        AutoRoute(
          page: PrimePlanPurchaseScreenRoute.page,
        ),

        AutoRoute(
          page: SendMoneyScreenRoute.page,
        ),
        AutoRoute(
          page: RegistrationScreenRoute.page,
        ),

        AutoRoute(
          page: SignupProfileScreenRoute.page,
        ),
        AutoRoute(
          page: NotificationScreenRoute.page,
        ),

        AutoRoute(
            page: SendMoneyScreenRoute.page,
            path: '/send_money_screen/:isFromEpin'),
        AutoRoute(page: PassbookPageRoute.page, path: '/passbook_page'),
        AutoRoute(
          page: PrimeDashboardScreenRoute.page,
        ),

        AutoRoute(
          page: CreatePasswordScreenRoute.page,
        ),
        AutoRoute(
          page: RedeemSucessScreenRoute.page,
        ),
        AutoRoute(
            page: PrimeTeamScreenRoute.page, path: '/Prime_Team_Screen/:catId'),
        AutoRoute(
          page: PrimeTeamLevelScreenRoute.page,
        ),
        AutoRoute(
          page: IdCardScreenRoute.page,
        ),
        // path: '/Prime_Team_Level_Screen/:level/:primeId'),
        AutoRoute(
            page: IncomePassbookScreenRoute.page,
            path: '/Income_Passbook_screen'),
        AutoRoute(page: RedeemScreenRoute.page, path: '/Redeem_Screen'),
      ];
}
