// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/routes/router_import.gr.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_const_assets.dart';
import 'package:defenders/constants/app_const_text.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/constants/app_storage_key.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/modules/hacked_data/hacked_data_screen.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:translator/translator.dart';

import '../../main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/src/response.dart' as dio;

// import 'package:dio_http_cache/dio_http_cache.dart';
// ignore_for_file: implementation_imports, avoid_catches_without_on_clauses

class NetworkDio {
  static late Dio _dio;
  static Circle processIndicator = Circle();
  static late Map<String, dynamic> shoppingHeader;
  static late Map<String, dynamic> rssHeader;
  static late Map<String, dynamic> appHeader;

  // static late DioCacheManager dioCacheManager;
  // static final Options cacheOptions =
  //     buildCacheOptions(const Duration(seconds: 1), forceRefresh: true);

  static Future<void> setDynamicHeader({
    required String authorizationToken,
  }) async {
    final BaseOptions options = BaseOptions(
        receiveTimeout: const Duration(minutes: 3),
        connectTimeout: const Duration(minutes: 3));
    // dioCacheManager = DioCacheManager(CacheConfig());
    shoppingHeader = _getGiftVochuresHeaders(
      authorizationToken: authorizationToken,
    );
    appHeader = _getHeaders(
      authorizationToken: authorizationToken,
    );
    rssHeader = _getRssHeaders(
      authorizationToken: authorizationToken,
    );

    options.headers.addAll(appHeader);
    _dio = Dio(options);
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          request: false,
          requestHeader: true,
          responseHeader: false,
          requestBody: true,
          responseBody: true));
    }
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      for (var i = 0; i < result.length; i++) {
        if (ConnectionState.none.name == result[i].name) {
          appRouter.push(const NoInternetScreenRoute());
        }
      }
    });
  }

  static Map<String, String> _getRssHeaders({
    required String authorizationToken,
  }) {
    return <String, String>{
      // 'Content-Type': 'application/json',
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      'Authorization': authorizationToken,
      "apitoken": ApiPath.apiKey,
    };
  }

  static Map<String, String> _getHeaders({
    required String authorizationToken,
  }) {
    return <String, String>{
      // 'Content-Type': 'application/json',
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      'Authorization': authorizationToken, //ApiPath.authorization,
      'TP_APPLICATION_KEY': ApiPath.tpApplicationKey,
      'apitoken': ApiPath.apiKey
    };
  }

  static Map<String, String> _getGiftVochuresHeaders({
    required String authorizationToken,
  }) {
    return <String, String>{
      'Content-Type': 'application/json',
      // "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      'Authorization': authorizationToken, //ApiPath.authorization,
      'API_KEY': ApiPath.apiKey,
    };
  }

  static Future<bool> check() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
      // Mobile network available.
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      return true;
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return false;
  }

  static Future<String?> getSha1(context, url) async {
    HttpClient client1 = HttpClient();
    client1.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request =
        await client1.getUrl(Uri.parse(GlobalSingleton.sslCheckURL));

    HttpClientResponse response1 = await request.close();
    return response1.certificate?.sha1.toString();
  }

  static void redirectToHackedPage(context) {
    appRouter.pushWidget(const HackedDataScreen());
  }

  static Future<bool> isValidSSLPinning(context, url) async {
    String key = await getSha1(context, url) ?? "";
    return key !=
        (GlobalSingleton.isProd
            ? AppConstString.sha1KeyProd
            : AppConstString.sha1KeyUat);
  }

  // static Future<bool> isValidSSLPinForCheckUpdate(context, url) async {
  //   String key = await getSha1(context, url) ?? "";
  //   return key != AppConstString.sha1KeyCheckUpdates;
  // }

  static Future<Map<String, dynamic>?> postDioHttpMethod({
    BuildContext? context,
    bool? notShowError,
    bool? forceReturn,
    bool? isEncryptionUse,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        // if (await isValidSSLPinning(context, url)) {
        //   redirectToHackedPage(context);
        // }
        // else {
        print(data.toString());
        final dio.Response<dynamic> response = await _dio.post(
          url,
          data: isEncryptionUse == true
              ? data
              : {
                  'encReq': base64Encode(utf8.encode(
                      CommonMethod.reciprocalencrypt(text: json.encode(data))))
                },
        );
        Map<String, dynamic> responseBody = <String, dynamic>{};
        if (context != null) {
          processIndicator.hide(context);
        }
        if (response.statusCode == 200) {
          try {
            String env = CommonMethod.reciprocalencrypt(
                text: utf8.decode(base64Decode(response.data)));

            // print(responseBody);
            responseBody = json.decode(env.toString());
          } catch (e) {
            responseBody = response.data as Map<String, dynamic>;
          }
          if (responseBody['status'] == 200 || responseBody['status'] == 201) {
            // if (context != null) {
            //   processIndicator.hide(context);
            // }
            return responseBody;
          } else if (responseBody['status'] == true || forceReturn == true) {
            // if (context != null) {
            //   processIndicator.hide(context);
            // }
            return responseBody;
          } else {
            if (notShowError != true) {
              showError(
                title: 'Error',
                errorMessage: responseBody['error'] ??
                    responseBody['message'] ??
                    responseBody['errors'],
                context: context,
              );
            }
            return responseBody;
          }
        } else {
          String env = CommonMethod.reciprocalencrypt(
              text: utf8.decode(base64Decode(response.data)));

          // print(responseBody);
          responseBody = json.decode(env.toString());
          if (notShowError != true) {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
          }
          return responseBody;
        }
        // }
      } on DioException catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }

        // print(responseBody);

        if (e.error == 'Http status error [404]') {
          Map<String, dynamic> responseBody = <String, dynamic>{};
          showError(
            title: 'Error',
            errorMessage: "Http status error [404]",
            context: context,
          );
          return responseBody;
        } else {
          if (e.message ==
              "SocketException: Failed host lookup: 'secure.mirror.org.in' (OS Error: No address associated with hostname, errno = 7)") {
            showError(
              title: 'Error',
              errorMessage:
                  "Sorry Conection error. Plz try after some tine our contach our Support team ${AppConstString.supportNumber} 😔",
              context: context,
            );
          } else {
            Map<String, dynamic> responseBody = <String, dynamic>{};
            String env = CommonMethod.reciprocalencrypt(
                text: utf8.decode(base64Decode(e.response!.data)));

            // print(responseBody);
            responseBody = json.decode(env.toString());

            if (notShowError != true) {
              showError(
                title: 'Error',
                errorMessage: e.response != null
                    ? responseBody['error'] != null
                        ? (responseBody['error'].runtimeType == List &&
                                responseBody['error'].isNotEmpty)
                            ? responseBody['error'][0]
                            : responseBody['error']
                        : responseBody['errors'] != null
                            ? (responseBody['errors'].runtimeType == List &&
                                    responseBody['errors'].isNotEmpty)
                                ? responseBody['errors'][0]
                                : responseBody['errors']
                            : responseBody['message']
                    : 'Somethings went wrong',
                context: context,
              );

              if (responseBody['message'] == 'Invalid token') {
                StorageManager.clearSharedPreferences();
                appRouter.pushAndPopUntil(const LoginScreenRoute(),
                    predicate: (pr) => false);
              }
              // if (e.response!.data['token'] != null) {
              //   GlobalSingleton.loginInfo!.token = e.response!.data['token'];
              //   StorageManager.setStringValue(
              //     key: 'data',
              //     value: encrypt(
              //       text: jsonEncode(GlobalSingleton.loginInfo),
              //     ),
              //   );
              //   await NetworkDio.setDynamicHeader(
              //     authorizationToken: GlobalSingleton.loginInfo!.token.toString(),
              //   );
              // }
            }
            return responseBody;
          }
        }
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }

        if (notShowError != true) {
          showError(
            title: 'Error',
            errorMessage: "Somethings went wrong",
            context: context,
          );
        }
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> shoppingPostDioHttpMethod({
    BuildContext? context,
    bool? notShowError,
    bool? forceReturn,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        // if (await isValidSSLPinning(context, url)) {
        //   redirectToHackedPage(context);
        // }
        // else {

        final dio.Response<dynamic> response = await _dio.post(
          url,
          options: Options(headers: shoppingHeader),
          data: data,
          // options: cacheOptions,
        );

        Map<String, dynamic> responseBody = <String, dynamic>{};
        if (context != null) {
          processIndicator.hide(context);
        }
        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(response.data.toString());
          } catch (e) {
            responseBody = response.data as Map<String, dynamic>;
          }
          if (responseBody['status'] == 'success') {
            // if (context != null) {
            //   processIndicator.hide(context);
            // }
            return responseBody;
          } else if (responseBody['status'] == 'error') {
            showError(
              title: 'Error',
              errorMessage: responseBody['message'].toString(),
              context: context,
            );
            return responseBody;
          } else {
            if (notShowError != true) {
              showError(
                title: 'Error',
                errorMessage: responseBody['message'].toString(),
                context: context,
              );
            }
            return null;
          }
        } else {
          if (notShowError != true) {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
          }
          return null;
        }
        // }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        if (notShowError != true) {
          showError(
            title: 'Error',
            errorMessage: "Somethings went wrong",
            context: context,
          );
        }
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        if (notShowError != true) {
          showError(
            title: 'Error',
            errorMessage: "Somethings went wrong",
            context: context,
          );
        }
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDioHttpMethod({
    BuildContext? context,
    required String url,
    Map<String, dynamic>? queryParameters,
    bool? notShowError,
    bool? forceReturn,
    bool? isGiftVoucher,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        // if (await isValidSSLPinning(context, url)) {
        //   redirectToHackedPage(context);
        // }
        // else {

        final dio.Response<dynamic> response = await _dio.get(
          url,
          // options: cacheOptions,
        );
        Map<String, dynamic> responseBody = <String, dynamic>{};
        if (context != null) {
          processIndicator.hide(context);
        }
        log(responseBody.toString());
        if (response.statusCode == 200) {
          try {
            String env = CommonMethod.reciprocalencrypt(
                text: utf8.decode(base64Decode(response.data)));

            // print(responseBody);
            responseBody = json.decode(env.toString());
            log(responseBody.toString());
            // responseBody = json.decode(response.data.toString());
          } catch (e) {
            responseBody = response.data as Map<String, dynamic>;
          }
          if (responseBody['status'] == 200 || responseBody['status'] == 201) {
            // if (context != null) {
            //   processIndicator.hide(context);
            // }
            // log(responseBody.toString());
            return responseBody;
          } else if (responseBody['status'] == true || forceReturn == true) {
            // if (context != null) {
            //   processIndicator.hide(context);
            // }
            // log(responseBody.toString());
            return responseBody;
          } else {
            if (notShowError != true) {
              showError(
                title: 'Error',
                errorMessage: responseBody['error'].toString(),
                context: context,
              );
            }
            return null;
          }
        } else {
          if (notShowError != true) {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
          }
          return null;
        }
        // }
      } on DioException catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        Map<String, dynamic> responseBody = <String, dynamic>{};
        String env = CommonMethod.reciprocalencrypt(
            text: utf8.decode(base64Decode(e.response!.data)));

        // print(responseBody);
        responseBody = json.decode(env.toString());
        if (notShowError != true) {
          showError(
            title: 'Error',
            errorMessage: e.response != null
                ? responseBody['error'] ?? responseBody['message']
                : 'Somethings went wrong',
            context: context,
          );

          if (responseBody['message'] == 'Invalid token') {
            StorageManager.clearSharedPreferences();
            appRouter.pushAndPopUntil(const LoginScreenRoute(),
                predicate: (pr) => false);
          }
          // if (e.response!.data['token'] != null) {
          //   GlobalSingleton.loginInfo!.token = e.response!.data['token'];
          //   StorageManager.setStringValue(
          //     key: 'data',
          //     value: encrypt(
          //       text: jsonEncode(GlobalSingleton.loginInfo),
          //     ),
          //   );
          //   await NetworkDio.setDynamicHeader(
          //     authorizationToken: GlobalSingleton.loginInfo!.token.toString(),
          //   );
          // }
        }
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        if (notShowError != true) {
          showError(
            title: 'Error',
            errorMessage: "Somethings went wrong",
            context: context,
          );
        }
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
  }

  static Future<String> getRssFeed({
    BuildContext? context,
    required String url,
  }) async {
    final bool internet = await check();

    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        final dio.Response<dynamic> response =
            await _dio.get(url, options: Options(headers: rssHeader));
        String responseBody = '';
        if (context != null) {
          processIndicator.hide(context);
        }

        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(response.data.toString());
            return responseBody.toString();
          } catch (e) {
            responseBody = response.data.toString();
            return responseBody.toString();
          }
        } else {
          showError(
            title: 'Error',
            errorMessage: response.statusMessage.toString(),
            context: context,
          );
          return '';
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return '';
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return '';
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return '';
    }
  }

  static Future<Map<String, dynamic>?> putDioHttpMethod({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.put(
            url,
            data: data,
          );
          Map<String, dynamic> responseBody = <String, dynamic>{};
          if (context != null) {
            processIndicator.hide(context);
          }

          if (response.statusCode == 200) {
            try {
              responseBody =
                  json.decode(response.data.toString()) as Map<String, dynamic>;
            } catch (e) {
              responseBody = response.data as Map<String, dynamic>;
            }
            if (responseBody['statuscode'] == 200) {
              if (responseBody['data']['status_code'] == "CC00011") {
                StorageManager.setStringValue(
                  key: AppStorageKey.deletedAccountText,
                  value: responseBody['data']['message'],
                );
                // appRouter.pushAndPopUntil(const DeletedAccountScreenRoute(),
                //     predicate: (_) => false);
              } else {
                return responseBody['data'] as Map<String, dynamic>;
              }
            } else {
              showError(
                title: 'Error',
                errorMessage: responseBody['message'].toString(),
                context: context,
              );
              return null;
            }
          } else {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  //CMS dio
  static Future<Map<String, dynamic>?> getDioHttpMethodCMS(
      {BuildContext? context,
      required String url,
      Map<String, dynamic>? queryParams}) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.get(
            url,
            queryParameters: queryParams,
          );
          Map<String, dynamic> responseBody = <String, dynamic>{};
          if (context != null) {
            processIndicator.hide(context);
          }

          if (response.statusCode == 200) {
            try {
              responseBody =
                  json.decode(response.data.toString()) as Map<String, dynamic>;
            } catch (e) {
              responseBody = response.data as Map<String, dynamic>;
            }
            if (responseBody['status_code'] == "SCR_0001" ||
                responseBody['status_code'] == "SCR_0002") {
              return responseBody;
            } else {
              showError(
                title: 'Error',
                errorMessage: responseBody['message'].toString(),
                context: context,
              );
              return null;
            }
          } else {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static Future<String?> postDioHttpMethodSSOStr({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.post(
            url,
            data: data,
          );
          if (context != null) {
            processIndicator.hide(context);
          }
          if (response.statusCode == 200) {
            try {
              if (response.data['link'] != null ||
                  response.data['link'] != "") {
                return response.data['link'];
              } else {
                return response.data['msg'];
              }
            } catch (e) {
              return response.data['message'];
            }
          } else if (response.statusCode == 401) {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
          } else {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postDioHttpMethodSSO({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      try {
        if (context != null) {
          processIndicator.show(context);
        }
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.post(
            url,
            data: data,
          );
          Map<String, dynamic> responseBody = <String, dynamic>{};
          if (context != null) {
            processIndicator.hide(context);
          }
          if (response.statusCode == 200) {
            try {
              try {
                responseBody = json.decode(response.data.toString())
                    as Map<String, dynamic>;
              } catch (e) {
                responseBody = response.data as Map<String, dynamic>;
              }
              return responseBody;
            } catch (e) {
              return response.data['message'];
            }
          } else if (response.statusCode == 401) {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
          } else {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postPartnerNetworkDio({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet == true) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.post(
            url,
            data: data,
          );
          Map<String, dynamic> responseBody = <String, dynamic>{};
          if (context != null) {
            processIndicator.hide(context);
          }

          if (response.statusCode == 200) {
            try {
              responseBody =
                  json.decode(response.data.toString()) as Map<String, dynamic>;
            } catch (e) {
              responseBody = response.data as Map<String, dynamic>;
            }
            return responseBody;
          } else {
            responseBody =
                json.decode(response.data.toString()) as Map<String, dynamic>;
            showError(
              title: 'Error',
              errorMessage: responseBody['message'].toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: 'Somethings went wrong',
          context: context,
        );
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postOfferListCat({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      if (context != null) {
        processIndicator.show(context);
      }
      try {
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.post(
            url,
            data: data,
          );
          Map<String, dynamic> responseBody = <String, dynamic>{};
          if (context != null) {
            processIndicator.hide(context);
          }

          if (response.statusCode == 200) {
            try {
              responseBody =
                  json.decode(response.data.toString()) as Map<String, dynamic>;
            } catch (e) {
              responseBody = response.data as Map<String, dynamic>;
            }
            return responseBody;
          } else {
            showError(
              title: 'Error',
              errorMessage: response.statusMessage.toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: 'Somethings went wrong',
          context: context,
        );
        return null;
      } catch (e) {
        if (context != null) {
          processIndicator.hide(context);
        }
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> postCheckUpdateNetworkDio({
    BuildContext? context,
    required String url,
    required dynamic data,
  }) async {
    final bool internet = await check();
    if (internet) {
      /*if (context != null) {
        processIndicator.show(context);
      }*/
      try {
        if (await isValidSSLPinning(context, url)) {
          redirectToHackedPage(context);
        } else {
          final dio.Response<dynamic> response = await _dio.post(
            url,
            data: data,
          );
          Map<String, dynamic> responseBody = <String, dynamic>{};
          /*if (context != null) {
          processIndicator.hide(context);
        }*/

          if (response.statusCode == 200) {
            try {
              responseBody =
                  json.decode(response.toString()) as Map<String, dynamic>;
            } catch (e) {
              responseBody = response.data as Map<String, dynamic>;
            }
            return responseBody;
          } else {
            responseBody =
                json.decode(response.toString()) as Map<String, dynamic>;
            showError(
              title: 'Error',
              errorMessage: responseBody['message'].toString(),
              context: context,
            );
            return null;
          }
        }
      } on DioException catch (_) {
        showError(
          title: 'Error',
          errorMessage: 'Somethings went wrong',
          context: context,
        );
        return null;
      } catch (e) {
        showError(
          title: 'Error',
          errorMessage: "Somethings went wrong",
          context: context,
        );
        return null;
      }
    } else {
      appRouter.push(const NoInternetScreenRoute());
      return null;
    }
    return null;
  }

  static void showSuccess({
    required String title,
    required String sucessMessage,
    BuildContext? context,
  }) {
    if (context != null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(sucessMessage),
      //     backgroundColor: AppColors.successColor,
      //   ),

      // );
      //
      popupBottomSheet(context, sucessMessage);
    }
  }

  static void showWarning({
    required String message,
    BuildContext? context,
    bool? isDimissible,
  }) {
    if (context != null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(message),
      //     backgroundColor: AppColors.blueColor,
      //   ),
      // );
      popupBottomSheet(
        context,
        message,
        isDimissible: isDimissible,
      );
    }
  }

  static void showError({
    required String title,
    required String errorMessage,
    BuildContext? context,
  }) {
    if (context != null) {
      dialogData(context: context, errorMessage: errorMessage, title: title);
      // popupBottomSheet(context, errorMessage);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBars.errorSnackBar(title: errorMessage));
    }
  }
}

int selectedLang = 0;

List lanList = [
  {
    'name': 'English',
  },
  {
    'name': 'Hindi',
  },
  {
    'name': 'Gujrati',
  },
  {
    'name': 'Marathi',
  },
];

Future<String> getTrans({
  required String text,
  required String lanCode,
}) async {
  final translator = GoogleTranslator();
  var translation = await translator.translate(text, to: lanCode);

  return translation.text;
}

dialogData({
  required BuildContext context,
  required String title,
  required String errorMessage,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, setstate) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTextStyle.semiBold20.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                  child: SingleChildScrollView(
                    child: Row(
                      children: List.generate(
                          4,
                          (index) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: InkWell(
                                      onTap: () {
                                        selectedLang = index;
                                        setstate(() {});
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            lanList[index]['name'],
                                            style: AppTextStyle.semiBold14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (selectedLang == index)
                                    Container(
                                      height: 2,
                                      width: 80,
                                      color: AppColors.secoundColors,
                                    )
                                ],
                              )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                selectedLang == 0
                    ? Text(errorMessage)
                    : FutureBuilder<String>(
                        future: getTrans(
                            text: errorMessage,
                            lanCode: selectedLang == 1
                                ? 'hi'
                                : selectedLang == 2
                                    ? 'gu'
                                    : 'mr'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Image.asset(
                                AppAssets.mirrorLoader,
                                width: 100,
                              ),
                            );
                          } else {
                            return Text('${snapshot.data}');
                          }
                        },
                      ),
                // Text(
                //   selectedLang == 0
                //       ? errorMessage
                //       : getTrans(
                //               text: errorMessage,
                //               lanCode: selectedLang == 1
                //                   ? 'hi'
                //                   : selectedLang == 2
                //                       ? 'gu'
                //                       : 'mr')
                //           .toString(),
                //   // selectedLang == 0 ? "" : errorMessage,
                //   // 'Mirror respects your privacy. Therefore we do not collect or store your contact history. this feature only helps to remind for your leads.',
                //   textAlign: TextAlign.left,
                //   style: AppTextStyle.regular16,
                // ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 40),
                      decoration: BoxDecoration(
                        color: AppColors.appColors,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        'OK',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}

Future<void> popupBottomSheet(BuildContext buildContext, String text,
    {bool? isDimissible}) async {
  final completer = Completer<void>();

  showModalBottomSheet(
    backgroundColor: AppColors.secondaryContainerColor,
    context: buildContext,
    isDismissible: isDimissible ?? true,
    enableDrag: isDimissible ?? true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      Future.delayed(const Duration(seconds: 3)).then((_) {
        if (!completer.isCompleted) {
          Navigator.pop(context); // Close the bottom sheet
          completer.complete();
        }
      });

      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: EdgeInsets.only(
            top: AppSizes.size20,
            right: AppSizes.size20,
            left: AppSizes.size20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: AppTextStyle.semiBold14.copyWith(
                    color: AppColors.darkBlueTextColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: AppSizes.size30,
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((value) {
    if (!completer.isCompleted) {
      completer.complete();
    }
  });

  return completer.future;
}
