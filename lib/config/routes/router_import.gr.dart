// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i47;
import 'package:flutter/material.dart' as _i48;
import 'package:defenders/model/auth_model/signup_model.dart' as _i51;
import 'package:defenders/model/prime_plan_model/get_prime_plan_details_model.dart'
    as _i54;

import 'package:defenders/modules/auth/forget_password/create_password/create_password_screen.dart'
    as _i7;
import 'package:defenders/modules/auth/forget_password/forget_password.dart'
    as _i11;
import 'package:defenders/modules/auth/login/login_screen.dart' as _i19;
import 'package:defenders/modules/auth/mpin/mpin_screen.dart' as _i25;
import 'package:defenders/modules/auth/otp/otp_screen.dart' as _i23;
import 'package:defenders/modules/auth/registration/add_interest/add_intrest_screen.dart'
    as _i17;
import 'package:defenders/modules/auth/registration/gender_selection/gender_selection_screen.dart'
    as _i43;
import 'package:defenders/modules/auth/registration/registration_presenter.dart'
    as _i52;
import 'package:defenders/modules/auth/registration/registration_screen.dart'
    as _i39;
import 'package:defenders/modules/auth/registration/term_and_condition/term_and_condition_screen.dart'
    as _i45;
import 'package:defenders/modules/business/business_team/prime_team/prime_team_screen.dart'
    as _i32;
import 'package:defenders/modules/business/business_team/prime_team_level/prime_team_level_screen.dart'
    as _i31;
import 'package:defenders/modules/data_uploading/data_uploading_screen.dart'
    as _i8;
import 'package:defenders/modules/documents/id_card_page.dart' as _i14;
import 'package:defenders/modules/documents/insurance_cover_page.dart'
    as _i16;
import 'package:defenders/modules/documents/prime_invoice_page.dart'
    as _i27;
import 'package:defenders/modules/documents/rank_certificate_page.dart'
    as _i36;
import 'package:defenders/modules/feedback/feedback_complaine/feedback_presenter.dart'
    as _i50;
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen.dart'
    as _i10;
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen/add_feedback_screen.dart'
    as _i1;
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen/feedback_reason_screen.dart'
    as _i9;
import 'package:defenders/modules/feedback/feedback_complaine/feedback_screen_model.dart'
    as _i49;
import 'package:defenders/modules/hacked_data/hacked_data_screen.dart'
    as _i12;
import 'package:defenders/modules/home/home_screen.dart' as _i13;
import 'package:defenders/modules/income_passbook/income_passbook_screen.dart'
    as _i15;
import 'package:defenders/modules/main_home/main_home_screen.dart'
    as _i20;
import 'package:defenders/modules/notification/notification_screen.dart'
    as _i22;
import 'package:defenders/modules/passbook/cashback_passbook/cashback_wallet_screen.dart'
    as _i6;
import 'package:defenders/modules/passbook/passbook_page/passbook_page.dart'
    as _i24;
import 'package:defenders/modules/passbook/prime_passbook/prime_passbook_screen.dart'
    as _i28;
import 'package:defenders/modules/passbook/wallet_passbook/wallet_passbook_screen.dart'
    as _i46;
import 'package:defenders/modules/prime/prime_daashboard/prime_dashboard_screen.dart'
    as _i26;
import 'package:defenders/modules/prime/prime_purchase/prime_purchase_screen.dart'
    as _i29;
import 'package:defenders/modules/profile/languages/languages_screen.dart'
    as _i18;
import 'package:defenders/modules/profile/profile_screen.dart' as _i33;
import 'package:defenders/modules/redeem/redeem_screen.dart' as _i37;
import 'package:defenders/modules/send_money/send_money_by_qr/qr_display_screen.dart'
    as _i34;
import 'package:defenders/modules/send_money/send_money_by_qr/qr_scanner_screen.dart'
    as _i35;
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_payment/send_money_payment_screen.dart'
    as _i40;
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_presenter.dart'
    as _i53;
import 'package:defenders/modules/send_money/send_money_mobile_number/send_money_screen.dart'
    as _i41;
import 'package:defenders/modules/splash_screen/splash_screen.dart'
    as _i44;
import 'package:defenders/modules/suceess/add_money_sucess_screen.dart'
    as _i5;
import 'package:defenders/modules/suceess/prime_plan_sucess_screen.dart'
    as _i30;
import 'package:defenders/modules/suceess/send_money_sucess_screen.dart'
    as _i42;
import 'package:defenders/widget/no_internet_screen.dart' as _i21;
import 'package:defenders/widget/sucess/redeem_sucess_screen.dart'
    as _i38;

/// generated route for
/// [_i1.AddFeedbackScreen]
class AddFeedbackScreenRoute
    extends _i47.PageRouteInfo<AddFeedbackScreenRouteArgs> {
  AddFeedbackScreenRoute({
    _i48.Key? key,
    required _i49.FeebackScreenModel model,
    required _i50.FeedbackPresenter presenter,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          AddFeedbackScreenRoute.name,
          args: AddFeedbackScreenRouteArgs(
            key: key,
            model: model,
            presenter: presenter,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFeedbackScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddFeedbackScreenRouteArgs>();
      return _i1.AddFeedbackScreen(
        key: args.key,
        model: args.model,
        presenter: args.presenter,
      );
    },
  );
}

class AddFeedbackScreenRouteArgs {
  const AddFeedbackScreenRouteArgs({
    this.key,
    required this.model,
    required this.presenter,
  });

  final _i48.Key? key;

  final _i49.FeebackScreenModel model;

  final _i50.FeedbackPresenter presenter;

  @override
  String toString() {
    return 'AddFeedbackScreenRouteArgs{key: $key, model: $model, presenter: $presenter}';
  }
}

class AddMoneyManualScreenRouteArgs {
  const AddMoneyManualScreenRouteArgs({
    this.key,
    required this.amount,
    required this.isForEpin,
  });

  final _i48.Key? key;

  final String amount;

  final bool isForEpin;

  @override
  String toString() {
    return 'AddMoneyManualScreenRouteArgs{key: $key, amount: $amount, isForEpin: $isForEpin}';
  }
}

class AddMoneyPaymentRequestScreenRouteArgs {
  const AddMoneyPaymentRequestScreenRouteArgs({
    this.key,
    required this.isForEpin,
    required this.amount,
  });

  final _i48.Key? key;

  final bool isForEpin;

  final String amount;

  @override
  String toString() {
    return 'AddMoneyPaymentRequestScreenRouteArgs{key: $key, isForEpin: $isForEpin, amount: $amount}';
  }
}

/// generated route for
/// [_i5.AddMoneySucessScreen]
class AddMoneySucessScreenRoute extends _i47.PageRouteInfo<void> {
  const AddMoneySucessScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          AddMoneySucessScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddMoneySucessScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i5.AddMoneySucessScreen();
    },
  );
}

/// generated route for
/// [_i6.CashbackPassbookScreen]
class CashbackPassbookScreenRoute extends _i47.PageRouteInfo<void> {
  const CashbackPassbookScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          CashbackPassbookScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CashbackPassbookScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i6.CashbackPassbookScreen();
    },
  );
}

/// generated route for
/// [_i7.CreatePasswordScreen]
class CreatePasswordScreenRoute
    extends _i47.PageRouteInfo<CreatePasswordScreenRouteArgs> {
  CreatePasswordScreenRoute({
    _i48.Key? key,
    required String mobilerNumber,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          CreatePasswordScreenRoute.name,
          args: CreatePasswordScreenRouteArgs(
            key: key,
            mobilerNumber: mobilerNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'CreatePasswordScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePasswordScreenRouteArgs>();
      return _i7.CreatePasswordScreen(
        key: args.key,
        mobilerNumber: args.mobilerNumber,
      );
    },
  );
}

class CreatePasswordScreenRouteArgs {
  const CreatePasswordScreenRouteArgs({
    this.key,
    required this.mobilerNumber,
  });

  final _i48.Key? key;

  final String mobilerNumber;

  @override
  String toString() {
    return 'CreatePasswordScreenRouteArgs{key: $key, mobilerNumber: $mobilerNumber}';
  }
}

/// generated route for
/// [_i8.DataUploadingScreen]
class DataUploadingScreenRoute extends _i47.PageRouteInfo<void> {
  const DataUploadingScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          DataUploadingScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'DataUploadingScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i8.DataUploadingScreen();
    },
  );
}

/// generated route for
/// [_i9.FeedbackReasonScreen]
class FeedbackReasonScreenRoute
    extends _i47.PageRouteInfo<FeedbackReasonScreenRouteArgs> {
  FeedbackReasonScreenRoute({
    _i48.Key? key,
    required _i49.FeebackScreenModel model,
    required _i50.FeedbackPresenter presenter,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          FeedbackReasonScreenRoute.name,
          args: FeedbackReasonScreenRouteArgs(
            key: key,
            model: model,
            presenter: presenter,
          ),
          initialChildren: children,
        );

  static const String name = 'FeedbackReasonScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedbackReasonScreenRouteArgs>();
      return _i9.FeedbackReasonScreen(
        key: args.key,
        model: args.model,
        presenter: args.presenter,
      );
    },
  );
}

class FeedbackReasonScreenRouteArgs {
  const FeedbackReasonScreenRouteArgs({
    this.key,
    required this.model,
    required this.presenter,
  });

  final _i48.Key? key;

  final _i49.FeebackScreenModel model;

  final _i50.FeedbackPresenter presenter;

  @override
  String toString() {
    return 'FeedbackReasonScreenRouteArgs{key: $key, model: $model, presenter: $presenter}';
  }
}

/// generated route for
/// [_i10.FeedbackScreen]
class FeedbackScreenRoute extends _i47.PageRouteInfo<void> {
  const FeedbackScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          FeedbackScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i10.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i11.ForgetPasswordScreen]
class ForgetPasswordScreenRoute
    extends _i47.PageRouteInfo<ForgetPasswordScreenRouteArgs> {
  ForgetPasswordScreenRoute({
    _i48.Key? key,
    required bool isActiveId,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          ForgetPasswordScreenRoute.name,
          args: ForgetPasswordScreenRouteArgs(
            key: key,
            isActiveId: isActiveId,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgetPasswordScreenRouteArgs>();
      return _i11.ForgetPasswordScreen(
        key: args.key,
        isActiveId: args.isActiveId,
      );
    },
  );
}

class ForgetPasswordScreenRouteArgs {
  const ForgetPasswordScreenRouteArgs({
    this.key,
    required this.isActiveId,
  });

  final _i48.Key? key;

  final bool isActiveId;

  @override
  String toString() {
    return 'ForgetPasswordScreenRouteArgs{key: $key, isActiveId: $isActiveId}';
  }
}

/// generated route for
/// [_i12.HackedDataScreen]
class HackedDataScreenRoute
    extends _i47.PageRouteInfo<HackedDataScreenRouteArgs> {
  HackedDataScreenRoute({
    _i48.Key? key,
    bool fromSplash = false,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          HackedDataScreenRoute.name,
          args: HackedDataScreenRouteArgs(
            key: key,
            fromSplash: fromSplash,
          ),
          rawPathParams: {'fromSplash': fromSplash},
          initialChildren: children,
        );

  static const String name = 'HackedDataScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HackedDataScreenRouteArgs>(
          orElse: () => HackedDataScreenRouteArgs(
                  fromSplash: pathParams.getBool(
                'fromSplash',
                false,
              )));
      return _i12.HackedDataScreen(
        key: args.key,
        fromSplash: args.fromSplash,
      );
    },
  );
}

class HackedDataScreenRouteArgs {
  const HackedDataScreenRouteArgs({
    this.key,
    this.fromSplash = false,
  });

  final _i48.Key? key;

  final bool fromSplash;

  @override
  String toString() {
    return 'HackedDataScreenRouteArgs{key: $key, fromSplash: $fromSplash}';
  }
}

/// generated route for
/// [_i13.HomeScreen]
class HomeScreenRoute extends _i47.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i13.HomeScreen();
    },
  );
}

/// generated route for
/// [_i14.IdCardScreen]
class IdCardScreenRoute extends _i47.PageRouteInfo<void> {
  const IdCardScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          IdCardScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'IdCardScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i14.IdCardScreen();
    },
  );
}

/// generated route for
/// [_i15.IncomePassbookScreen]
class IncomePassbookScreenRoute
    extends _i47.PageRouteInfo<IncomePassbookScreenRouteArgs> {
  IncomePassbookScreenRoute({
    _i48.Key? key,
    String? filter,
    required bool isFromDrawer,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          IncomePassbookScreenRoute.name,
          args: IncomePassbookScreenRouteArgs(
            key: key,
            filter: filter,
            isFromDrawer: isFromDrawer,
          ),
          initialChildren: children,
        );

  static const String name = 'IncomePassbookScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IncomePassbookScreenRouteArgs>();
      return _i15.IncomePassbookScreen(
        key: args.key,
        filter: args.filter,
        isFromDrawer: args.isFromDrawer,
      );
    },
  );
}

class IncomePassbookScreenRouteArgs {
  const IncomePassbookScreenRouteArgs({
    this.key,
    this.filter,
    required this.isFromDrawer,
  });

  final _i48.Key? key;

  final String? filter;

  final bool isFromDrawer;

  @override
  String toString() {
    return 'IncomePassbookScreenRouteArgs{key: $key, filter: $filter, isFromDrawer: $isFromDrawer}';
  }
}

/// generated route for
/// [_i16.InsuranceCoverScreen]
class InsuranceCoverScreenRoute extends _i47.PageRouteInfo<void> {
  const InsuranceCoverScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          InsuranceCoverScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'InsuranceCoverScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i16.InsuranceCoverScreen();
    },
  );
}

/// generated route for
/// [_i17.InterestScareen]
class InterestScareenRoute extends _i47.PageRouteInfo<void> {
  const InterestScareenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          InterestScareenRoute.name,
          initialChildren: children,
        );

  static const String name = 'InterestScareenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i17.InterestScareen();
    },
  );
}

/// generated route for
/// [_i18.LanguagesScreen]
class LanguagesScreenRoute extends _i47.PageRouteInfo<void> {
  const LanguagesScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          LanguagesScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguagesScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i18.LanguagesScreen();
    },
  );
}

/// generated route for
/// [_i19.LoginScreen]
class LoginScreenRoute extends _i47.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i19.LoginScreen();
    },
  );
}

/// generated route for
/// [_i20.MainHomeScreen]
class MainHomeScreenRoute extends _i47.PageRouteInfo<MainHomeScreenRouteArgs> {
  MainHomeScreenRoute({
    _i48.Key? key,
    bool? isFromSignup,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          MainHomeScreenRoute.name,
          args: MainHomeScreenRouteArgs(
            key: key,
            isFromSignup: isFromSignup,
          ),
          initialChildren: children,
        );

  static const String name = 'MainHomeScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainHomeScreenRouteArgs>(
          orElse: () => const MainHomeScreenRouteArgs());
      return _i20.MainHomeScreen(
        key: args.key,
        isFromSignup: args.isFromSignup,
      );
    },
  );
}

class MainHomeScreenRouteArgs {
  const MainHomeScreenRouteArgs({
    this.key,
    this.isFromSignup,
  });

  final _i48.Key? key;

  final bool? isFromSignup;

  @override
  String toString() {
    return 'MainHomeScreenRouteArgs{key: $key, isFromSignup: $isFromSignup}';
  }
}

/// generated route for
/// [_i21.NoInternetScreen]
class NoInternetScreenRoute extends _i47.PageRouteInfo<void> {
  const NoInternetScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          NoInternetScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoInternetScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i21.NoInternetScreen();
    },
  );
}

/// generated route for
/// [_i22.NotificationScreen]
class NotificationScreenRoute extends _i47.PageRouteInfo<void> {
  const NotificationScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          NotificationScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i22.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i23.OtpScreen]
class OtpScreenRoute extends _i47.PageRouteInfo<OtpScreenRouteArgs> {
  OtpScreenRoute({
    _i48.Key? key,
    required String otpType,
    _i51.SignupModel? signupModel,
    _i52.RegistrationPresenter? presenter,
    _i53.SendMoneyPresenter? sendMoneypresenter,
    String? sendMoneyAmount,
    String? sendMoneyMobileNumber,
    String? sendMoneyUserId,
    String? sendMoneyWalletType,
    String? sendMoneyMessage,
    required String mobileNumber,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          OtpScreenRoute.name,
          args: OtpScreenRouteArgs(
            key: key,
            otpType: otpType,
            signupModel: signupModel,
            presenter: presenter,
            sendMoneypresenter: sendMoneypresenter,
            sendMoneyAmount: sendMoneyAmount,
            sendMoneyMobileNumber: sendMoneyMobileNumber,
            sendMoneyUserId: sendMoneyUserId,
            sendMoneyWalletType: sendMoneyWalletType,
            sendMoneyMessage: sendMoneyMessage,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpScreenRouteArgs>();
      return _i23.OtpScreen(
        key: args.key,
        otpType: args.otpType,
        signupModel: args.signupModel,
        presenter: args.presenter,
        sendMoneypresenter: args.sendMoneypresenter,
        sendMoneyAmount: args.sendMoneyAmount,
        sendMoneyMobileNumber: args.sendMoneyMobileNumber,
        sendMoneyUserId: args.sendMoneyUserId,
        sendMoneyWalletType: args.sendMoneyWalletType,
        sendMoneyMessage: args.sendMoneyMessage,
        mobileNumber: args.mobileNumber,
      );
    },
  );
}

class OtpScreenRouteArgs {
  const OtpScreenRouteArgs({
    this.key,
    required this.otpType,
    this.signupModel,
    this.presenter,
    this.sendMoneypresenter,
    this.sendMoneyAmount,
    this.sendMoneyMobileNumber,
    this.sendMoneyUserId,
    this.sendMoneyWalletType,
    this.sendMoneyMessage,
    required this.mobileNumber,
  });

  final _i48.Key? key;

  final String otpType;

  final _i51.SignupModel? signupModel;

  final _i52.RegistrationPresenter? presenter;

  final _i53.SendMoneyPresenter? sendMoneypresenter;

  final String? sendMoneyAmount;

  final String? sendMoneyMobileNumber;

  final String? sendMoneyUserId;

  final String? sendMoneyWalletType;

  final String? sendMoneyMessage;

  final String mobileNumber;

  @override
  String toString() {
    return 'OtpScreenRouteArgs{key: $key, otpType: $otpType, signupModel: $signupModel, presenter: $presenter, sendMoneypresenter: $sendMoneypresenter, sendMoneyAmount: $sendMoneyAmount, sendMoneyMobileNumber: $sendMoneyMobileNumber, sendMoneyUserId: $sendMoneyUserId, sendMoneyWalletType: $sendMoneyWalletType, sendMoneyMessage: $sendMoneyMessage, mobileNumber: $mobileNumber}';
  }
}

/// generated route for
/// [_i24.PassbookPage]
class PassbookPageRoute extends _i47.PageRouteInfo<void> {
  const PassbookPageRoute({List<_i47.PageRouteInfo>? children})
      : super(
          PassbookPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'PassbookPageRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i24.PassbookPage();
    },
  );
}

/// generated route for
/// [_i25.PinCodeOtp]
class PinCodeOtpRoute extends _i47.PageRouteInfo<PinCodeOtpRouteArgs> {
  PinCodeOtpRoute({
    _i48.Key? key,
    required bool isSignup,
    required bool isSplash,
    bool? isForgetOtp,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          PinCodeOtpRoute.name,
          args: PinCodeOtpRouteArgs(
            key: key,
            isSignup: isSignup,
            isSplash: isSplash,
            isForgetOtp: isForgetOtp,
          ),
          initialChildren: children,
        );

  static const String name = 'PinCodeOtpRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinCodeOtpRouteArgs>();
      return _i25.PinCodeOtp(
        key: args.key,
        isSignup: args.isSignup,
        isSplash: args.isSplash,
        isForgetOtp: args.isForgetOtp,
      );
    },
  );
}

class PinCodeOtpRouteArgs {
  const PinCodeOtpRouteArgs({
    this.key,
    required this.isSignup,
    required this.isSplash,
    this.isForgetOtp,
  });

  final _i48.Key? key;

  final bool isSignup;

  final bool isSplash;

  final bool? isForgetOtp;

  @override
  String toString() {
    return 'PinCodeOtpRouteArgs{key: $key, isSignup: $isSignup, isSplash: $isSplash, isForgetOtp: $isForgetOtp}';
  }
}

/// generated route for
/// [_i26.PrimeDashboardScreen]
class PrimeDashboardScreenRoute
    extends _i47.PageRouteInfo<PrimeDashboardScreenRouteArgs> {
  PrimeDashboardScreenRoute({
    _i48.Key? key,
    required bool isFromEpin,
    String? userId,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          PrimeDashboardScreenRoute.name,
          args: PrimeDashboardScreenRouteArgs(
            key: key,
            isFromEpin: isFromEpin,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'PrimeDashboardScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrimeDashboardScreenRouteArgs>();
      return _i26.PrimeDashboardScreen(
        key: args.key,
        isFromEpin: args.isFromEpin,
        userId: args.userId,
      );
    },
  );
}

class PrimeDashboardScreenRouteArgs {
  const PrimeDashboardScreenRouteArgs({
    this.key,
    required this.isFromEpin,
    this.userId,
  });

  final _i48.Key? key;

  final bool isFromEpin;

  final String? userId;

  @override
  String toString() {
    return 'PrimeDashboardScreenRouteArgs{key: $key, isFromEpin: $isFromEpin, userId: $userId}';
  }
}

/// generated route for
/// [_i27.PrimeInvoiceScreen]
class PrimeInvoiceScreenRoute extends _i47.PageRouteInfo<void> {
  const PrimeInvoiceScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          PrimeInvoiceScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrimeInvoiceScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i27.PrimeInvoiceScreen();
    },
  );
}

/// generated route for
/// [_i28.PrimePassbookScreen]
class PrimePassbookScreenRoute extends _i47.PageRouteInfo<void> {
  const PrimePassbookScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          PrimePassbookScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrimePassbookScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i28.PrimePassbookScreen();
    },
  );
}

/// generated route for
/// [_i29.PrimePlanPurchaseScreen]
class PrimePlanPurchaseScreenRoute
    extends _i47.PageRouteInfo<PrimePlanPurchaseScreenRouteArgs> {
  PrimePlanPurchaseScreenRoute({
    _i48.Key? key,
    required bool isFromEpin,
    String? userId,
    required _i54.GetPrimePlanDetailsData data,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          PrimePlanPurchaseScreenRoute.name,
          args: PrimePlanPurchaseScreenRouteArgs(
            key: key,
            isFromEpin: isFromEpin,
            userId: userId,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'PrimePlanPurchaseScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrimePlanPurchaseScreenRouteArgs>();
      return _i29.PrimePlanPurchaseScreen(
        key: args.key,
        isFromEpin: args.isFromEpin,
        userId: args.userId,
        data: args.data,
      );
    },
  );
}

class PrimePlanPurchaseScreenRouteArgs {
  const PrimePlanPurchaseScreenRouteArgs({
    this.key,
    required this.isFromEpin,
    this.userId,
    required this.data,
  });

  final _i48.Key? key;

  final bool isFromEpin;

  final String? userId;

  final _i54.GetPrimePlanDetailsData data;

  @override
  String toString() {
    return 'PrimePlanPurchaseScreenRouteArgs{key: $key, isFromEpin: $isFromEpin, userId: $userId, data: $data}';
  }
}

/// generated route for
/// [_i30.PrimeSucessScreen]
class PrimeSucessScreenRoute extends _i47.PageRouteInfo<void> {
  const PrimeSucessScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          PrimeSucessScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrimeSucessScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i30.PrimeSucessScreen();
    },
  );
}

/// generated route for
/// [_i31.PrimeTeamLevelScreen]
class PrimeTeamLevelScreenRoute
    extends _i47.PageRouteInfo<PrimeTeamLevelScreenRouteArgs> {
  PrimeTeamLevelScreenRoute({
    _i48.Key? key,
    required String level,
    required String primeId,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          PrimeTeamLevelScreenRoute.name,
          args: PrimeTeamLevelScreenRouteArgs(
            key: key,
            level: level,
            primeId: primeId,
          ),
          initialChildren: children,
        );

  static const String name = 'PrimeTeamLevelScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrimeTeamLevelScreenRouteArgs>();
      return _i31.PrimeTeamLevelScreen(
        key: args.key,
        level: args.level,
        primeId: args.primeId,
      );
    },
  );
}

class PrimeTeamLevelScreenRouteArgs {
  const PrimeTeamLevelScreenRouteArgs({
    this.key,
    required this.level,
    required this.primeId,
  });

  final _i48.Key? key;

  final String level;

  final String primeId;

  @override
  String toString() {
    return 'PrimeTeamLevelScreenRouteArgs{key: $key, level: $level, primeId: $primeId}';
  }
}

/// generated route for
/// [_i32.PrimeTeamScreen]
class PrimeTeamScreenRoute
    extends _i47.PageRouteInfo<PrimeTeamScreenRouteArgs> {
  PrimeTeamScreenRoute({
    _i48.Key? key,
    required String planId,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          PrimeTeamScreenRoute.name,
          args: PrimeTeamScreenRouteArgs(
            key: key,
            planId: planId,
          ),
          rawPathParams: {'catId': planId},
          initialChildren: children,
        );

  static const String name = 'PrimeTeamScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PrimeTeamScreenRouteArgs>(
          orElse: () =>
              PrimeTeamScreenRouteArgs(planId: pathParams.getString('catId')));
      return _i32.PrimeTeamScreen(
        key: args.key,
        planId: args.planId,
      );
    },
  );
}

class PrimeTeamScreenRouteArgs {
  const PrimeTeamScreenRouteArgs({
    this.key,
    required this.planId,
  });

  final _i48.Key? key;

  final String planId;

  @override
  String toString() {
    return 'PrimeTeamScreenRouteArgs{key: $key, planId: $planId}';
  }
}

/// generated route for
/// [_i33.ProfileScreen]
class ProfileScreenRoute extends _i47.PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute({
    _i48.Key? key,
    required bool isFromDrawer,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          ProfileScreenRoute.name,
          args: ProfileScreenRouteArgs(
            key: key,
            isFromDrawer: isFromDrawer,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileScreenRouteArgs>();
      return _i33.ProfileScreen(
        key: args.key,
        isFromDrawer: args.isFromDrawer,
      );
    },
  );
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs({
    this.key,
    required this.isFromDrawer,
  });

  final _i48.Key? key;

  final bool isFromDrawer;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{key: $key, isFromDrawer: $isFromDrawer}';
  }
}

/// generated route for
/// [_i34.QrDisplayScreen]
class QrDisplayScreenRoute extends _i47.PageRouteInfo<void> {
  const QrDisplayScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          QrDisplayScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrDisplayScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i34.QrDisplayScreen();
    },
  );
}

/// generated route for
/// [_i35.QrScannerScreen]
class QrScannerScreenRoute extends _i47.PageRouteInfo<void> {
  const QrScannerScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          QrScannerScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrScannerScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i35.QrScannerScreen();
    },
  );
}

/// generated route for
/// [_i36.RankCertificateScreen]
class RankCertificateScreenRoute extends _i47.PageRouteInfo<void> {
  const RankCertificateScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          RankCertificateScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'RankCertificateScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i36.RankCertificateScreen();
    },
  );
}

/// generated route for
/// [_i37.RedeemScreen]
class RedeemScreenRoute extends _i47.PageRouteInfo<RedeemScreenRouteArgs> {
  RedeemScreenRoute({
    _i48.Key? key,
    required bool isFromEwallet,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          RedeemScreenRoute.name,
          args: RedeemScreenRouteArgs(
            key: key,
            isFromEwallet: isFromEwallet,
          ),
          initialChildren: children,
        );

  static const String name = 'RedeemScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RedeemScreenRouteArgs>();
      return _i37.RedeemScreen(
        key: args.key,
        isFromEwallet: args.isFromEwallet,
      );
    },
  );
}

class RedeemScreenRouteArgs {
  const RedeemScreenRouteArgs({
    this.key,
    required this.isFromEwallet,
  });

  final _i48.Key? key;

  final bool isFromEwallet;

  @override
  String toString() {
    return 'RedeemScreenRouteArgs{key: $key, isFromEwallet: $isFromEwallet}';
  }
}

/// generated route for
/// [_i38.RedeemSucessScreen]
class RedeemSucessScreenRoute
    extends _i47.PageRouteInfo<RedeemSucessScreenRouteArgs> {
  RedeemSucessScreenRoute({
    _i48.Key? key,
    required String redeemNumbeer,
    required String redeemAmount,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          RedeemSucessScreenRoute.name,
          args: RedeemSucessScreenRouteArgs(
            key: key,
            redeemNumbeer: redeemNumbeer,
            redeemAmount: redeemAmount,
          ),
          initialChildren: children,
        );

  static const String name = 'RedeemSucessScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RedeemSucessScreenRouteArgs>();
      return _i38.RedeemSucessScreen(
        key: args.key,
        redeemNumbeer: args.redeemNumbeer,
        redeemAmount: args.redeemAmount,
      );
    },
  );
}

class RedeemSucessScreenRouteArgs {
  const RedeemSucessScreenRouteArgs({
    this.key,
    required this.redeemNumbeer,
    required this.redeemAmount,
  });

  final _i48.Key? key;

  final String redeemNumbeer;

  final String redeemAmount;

  @override
  String toString() {
    return 'RedeemSucessScreenRouteArgs{key: $key, redeemNumbeer: $redeemNumbeer, redeemAmount: $redeemAmount}';
  }
}

/// generated route for
/// [_i39.RegistrationScreen]
class RegistrationScreenRoute extends _i47.PageRouteInfo<void> {
  const RegistrationScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          RegistrationScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i39.RegistrationScreen();
    },
  );
}

/// generated route for
/// [_i40.SendMoneyPaymentScreen]
class SendMoneyPaymentScreenRoute
    extends _i47.PageRouteInfo<SendMoneyPaymentScreenRouteArgs> {
  SendMoneyPaymentScreenRoute({
    _i48.Key? key,
    required String mobileNumber,
    required String userName,
    required String userID,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          SendMoneyPaymentScreenRoute.name,
          args: SendMoneyPaymentScreenRouteArgs(
            key: key,
            mobileNumber: mobileNumber,
            userName: userName,
            userID: userID,
          ),
          initialChildren: children,
        );

  static const String name = 'SendMoneyPaymentScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendMoneyPaymentScreenRouteArgs>();
      return _i40.SendMoneyPaymentScreen(
        key: args.key,
        mobileNumber: args.mobileNumber,
        userName: args.userName,
        userID: args.userID,
      );
    },
  );
}

class SendMoneyPaymentScreenRouteArgs {
  const SendMoneyPaymentScreenRouteArgs({
    this.key,
    required this.mobileNumber,
    required this.userName,
    required this.userID,
  });

  final _i48.Key? key;

  final String mobileNumber;

  final String userName;

  final String userID;

  @override
  String toString() {
    return 'SendMoneyPaymentScreenRouteArgs{key: $key, mobileNumber: $mobileNumber, userName: $userName, userID: $userID}';
  }
}

/// generated route for
/// [_i41.SendMoneyScreen]
class SendMoneyScreenRoute
    extends _i47.PageRouteInfo<SendMoneyScreenRouteArgs> {
  SendMoneyScreenRoute({
    _i48.Key? key,
    required String? isFromEpin,
    String? mobileNumber,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          SendMoneyScreenRoute.name,
          args: SendMoneyScreenRouteArgs(
            key: key,
            isFromEpin: isFromEpin,
            mobileNumber: mobileNumber,
          ),
          rawPathParams: {'isFromEpin': isFromEpin},
          initialChildren: children,
        );

  static const String name = 'SendMoneyScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SendMoneyScreenRouteArgs>(
          orElse: () => SendMoneyScreenRouteArgs(
              isFromEpin: pathParams.optString('isFromEpin')));
      return _i41.SendMoneyScreen(
        key: args.key,
        isFromEpin: args.isFromEpin,
        mobileNumber: args.mobileNumber,
      );
    },
  );
}

class SendMoneyScreenRouteArgs {
  const SendMoneyScreenRouteArgs({
    this.key,
    required this.isFromEpin,
    this.mobileNumber,
  });

  final _i48.Key? key;

  final String? isFromEpin;

  final String? mobileNumber;

  @override
  String toString() {
    return 'SendMoneyScreenRouteArgs{key: $key, isFromEpin: $isFromEpin, mobileNumber: $mobileNumber}';
  }
}

/// generated route for
/// [_i42.SendMoneySuccessScreen]
class SendMoneySuccessScreenRoute
    extends _i47.PageRouteInfo<SendMoneySuccessScreenRouteArgs> {
  SendMoneySuccessScreenRoute({
    _i48.Key? key,
    String title = "Your request has been successfully processed..!",
    String? cashback,
    String? mobileNumber,
    String? operator,
    String? reference,
    String? transaction,
    List<_i47.PageRouteInfo>? children,
  }) : super(
          SendMoneySuccessScreenRoute.name,
          args: SendMoneySuccessScreenRouteArgs(
            key: key,
            title: title,
            cashback: cashback,
            mobileNumber: mobileNumber,
            operator: operator,
            reference: reference,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'SendMoneySuccessScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendMoneySuccessScreenRouteArgs>(
          orElse: () => const SendMoneySuccessScreenRouteArgs());
      return _i42.SendMoneySuccessScreen(
        key: args.key,
        title: args.title,
        cashback: args.cashback,
        mobileNumber: args.mobileNumber,
        operator: args.operator,
        reference: args.reference,
        transaction: args.transaction,
      );
    },
  );
}

class SendMoneySuccessScreenRouteArgs {
  const SendMoneySuccessScreenRouteArgs({
    this.key,
    this.title = "Your request has been successfully processed..!",
    this.cashback,
    this.mobileNumber,
    this.operator,
    this.reference,
    this.transaction,
  });

  final _i48.Key? key;

  final String title;

  final String? cashback;

  final String? mobileNumber;

  final String? operator;

  final String? reference;

  final String? transaction;

  @override
  String toString() {
    return 'SendMoneySuccessScreenRouteArgs{key: $key, title: $title, cashback: $cashback, mobileNumber: $mobileNumber, operator: $operator, reference: $reference, transaction: $transaction}';
  }
}

/// generated route for
/// [_i43.SignupProfileScreen]
class SignupProfileScreenRoute extends _i47.PageRouteInfo<void> {
  const SignupProfileScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          SignupProfileScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupProfileScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i43.SignupProfileScreen();
    },
  );
}

/// generated route for
/// [_i44.SplashScreen]
class SplashScreenRoute extends _i47.PageRouteInfo<void> {
  const SplashScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i44.SplashScreen();
    },
  );
}

/// generated route for
/// [_i45.TermAndConditionScreen]
class TermAndConditionScreenRoute extends _i47.PageRouteInfo<void> {
  const TermAndConditionScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          TermAndConditionScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermAndConditionScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i45.TermAndConditionScreen();
    },
  );
}

/// generated route for
/// [_i46.WalletPassbookScreen]
class WalletPassbookScreenRoute extends _i47.PageRouteInfo<void> {
  const WalletPassbookScreenRoute({List<_i47.PageRouteInfo>? children})
      : super(
          WalletPassbookScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletPassbookScreenRoute';

  static _i47.PageInfo page = _i47.PageInfo(
    name,
    builder: (data) {
      return const _i46.WalletPassbookScreen();
    },
  );
}
