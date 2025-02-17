import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/constants/environments.dart';

class ApiPath {
  static late String apiEndPoint;
  static late String shoppingapiEndPoint;
  static late String graphQlEndPoint;
  static late String giftCardEndPoint;
  static late String cmsEndPoint;
  static late String imageEndPoint;
  static late String apiTokenPoint;
  static late String dtOneEndPoint;
  static late String travelPurchaseEndPoint;
  static late String authCredData;
  static late String uatEndPoint;
  static late String offersPartnersEndPoint;
  static late String forceUpdateURL;
  static late String bucketUrl;

  static void setupAppBaseUrls(EnvironmentVariables urls) {
    apiEndPoint = urls.baseUrl;
    shoppingapiEndPoint = urls.shoppingBaseUrl;
    cmsEndPoint = urls.cmsBaseUrl;
    graphQlEndPoint = urls.graphQlEndPoint;
    apiTokenPoint = urls.cmsAPIToken;
    giftCardEndPoint = urls.giftCardEndPoint;
    dtOneEndPoint = urls.dtOneEndPoint;
    travelPurchaseEndPoint = urls.travelPurchaseEndPoint;
    forceUpdateURL = urls.forceUpdateURL;
    bucketUrl = urls.bucketUrl;
    uatEndPoint = urls.offersPartnersEndPoint;
    offersPartnersEndPoint = urls.offersPartnersEndPoint;
    GlobalSingleton.sslCheckURL = urls.sslCheckURL;
  }

  static const String tpApplicationKey = '9d04cea4-af10-472b-80f0-7f2c4b9584ed';

  static const String apiKey = 'ZX2IN3P6MW8ASCVHT4YPBMJIKER9DF5OL1GL8MTRUB0GH7';
  static const String bannerId = 'ca-app-pub-1307516877764610/9608151220';
  // static const String bannerId = 'ca-app-pub-3940256099942544/6300978111';
  static const String dynamicLink = 'https://mirrorbusiness.page.link';
  static const String secretKey = '9cfb46c0b3d5acb8';

  //OTP
  static const String otp = 'otp/get-otp';
  static const String verifyOtp = 'otp/Verify-otp';

  // unblock user
  static const String unblockUser = 'users/unblock-user';

  //login
  static const String login = 'users/login';
  //Mirror Wallet Balance
  static const getWalletBalance = 'wallet/get-wallet-balance';
  static const String getAddMoneyHistory = 'add_money/add-money-histroy';

  //register
  static const String register = 'users/register';
  static const String state = 'state/get-state';
  static const String city = 'city/get-citys';
  static const String pinCode = 'pincode/get-pincode';
  static const String refferBy = 'users/reffer-by';

  //Get Training Link
  static const String getTraining = 'meeting/get-meeting';
  static const String updateStatusInMeeting =
      'meeting/update-userwise-meeting-details';
  //recorded Training
  static const String getRecordedCategories = 'course_video/get-category';
  static const String getRecordedVideoList = 'course_video/get-video-list';

  //forget Password
  static const String forgetPassword = 'users/reset-password';

  //send Money
  static const String sendMoneyUserDeatisl = 'users/get-user-details';
  static const String sendMoney = 'send_money/send-money';
  static const String recentSendMoney = 'send_money/send-money-histroy';

  //income passbook
  static const String incomePassbook = 'report/get-income-passbook';

  //create mpin
  static const String getMpin = "users/get-mpin";

  //passbook api
  static const passbook = 'report/get-passbook';
  static const cashbackPassbook = 'report/get-cashback-passbook';
  static const primePassbook = 'report/get-prime-passbook';
  static const rewardPassbook = 'spinner/get-spinner-cashback';

  //Prime Plan
  static const getAllPrimePlanDetails = 'referral/plan/get-referral-plan';
  static const primePurchase = 'referral/plan/purchase';

  //data Backup
  static const String dataBackup = 'users/get-user-old-income';
  static const String checkDataBackup = 'users/check-old-income-exists';

//company Details
  static const String companyPortfolio = 'refferal-report/company-portfolio';
  static const String companyGraph = 'refferal-report/target-royality-graph';

  //marketing
  static const String getGraphicsCategories = 'graphics/get-graphics-category';
  static const String getGraphics = 'graphics/get-graphics';
  static const String getNewGraphics = 'graphics/get-graphics-categorywise';
  static const String updateLike = 'graphics/update-like-share-count';

  //add money
  static const String addMoneyManual = 'add_money/add-money-request';
  static const String getAddMoneyOrderId = 'add_money/add-money-order';

  //phonePe Add Money
  static const String phonePeRequest = 'phonepe/payment-request';
  static const String phonePePaymentResponse = 'phonepe/payment-response';

  //Team Details
  static const getTeamDeatils = 'refferal-report/team-level-details';
  static const String teamDetails = 'refferal-report/team-details';

  //Affilate to wallet
  static const affilateToWallet = "referral/plan/affiliate-to-wallet";
  static const affilateToWalletHistroy =
      "referral/plan/affiliate-to-wallet-histroy";

  //user log action
  static const userLogAction = 'log/user-log';
  static const userLogHistory = 'log/user-history';

  //Follow Msg Ccontectnt
  static const String msgContectnt =
      'user_activity_track/get-today-notification-content';
  static const String uploadUserContact =
      'user_activity_track/add-user-contact-log';

  //feedback
  static const getFeedBackCategories = "feedback/get-feedback-category";
  static const addFeedback = "feedback/add-feedback";
  static const getFeedbackReason = "feedback/get-feedback-reason";

  //Redeem
  static const String redeem = 'referral/plan/request-redeem';
  static const String redeemHistory = 'report/get-redeem-history';

  //Banner
  static const String getBanner = "banner/get-banner";

  //user service rating
  static const String userRating = 'rating/add-rating';

  //get Profile
  static const String getProfile = "users/get-profile";
  static const String updateProfile = "users/update-user-profile";

  //Leads
  static const String getleads = 'leads/get-category';

  //store fcm token
  static const String registerToken = "notification/register-fcm-token";

  //Notification
  static const String notification = 'notification/get-fcm-notification';

  //Leads
  static const String totalRankDistribution =
      'refferal-report/total-rank-distribution';

  //getUseIntrest Appuse
  static const getIntrestCategory = 'user_intrest/get-user-intrest-category';
  static const addIntrestCategory = 'user_intrest/add-user-intrest';
}
