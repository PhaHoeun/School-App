import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/configs/router/routes.dart';
import 'package:school_app/utils/widget/customer_alert_response.dart';

import '../../../utils/helper/api_base_helper.dart';
import '../../../utils/helper/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  ApiBaseHelper? api;
  String username = ''; //emilys
  String password = ''; //emilyspass
  String token = '';
  bool isLoadingLogin = false;

  void setApi(ApiBaseHelper apiHelper) {
    api = apiHelper;
  }

  // Load token from local storage
  Future<void> initAuth() async {
    token = await LocalStorage.getStringValue(key: 'token', defaultValue: '');
    notifyListeners();
  }

  void onLogIn(BuildContext context) async {
    isLoadingLogin = true;
    notifyListeners();
    await api
        ?.onNetworkRequesting(
          url: '/auth/login',
          isAuthorize: false,
          methode: METHODE.post,
          body: {
            'username': username,
            'password': password,
            'expiresInMins': 120,
          },
        )
        .then((res) async {
          debugPrint('log in success: ---------------------->>> 200');
          await LocalStorage.storeData(
            key: 'token',
            value: res['accessToken'].toString(),
          );
          router.go('/home');
        })
        .onError((ErrorModel error, stackTrace) {
          debugPrint(
            'on Error log in -------------------->>> ${error.bodyString['message']}',
          );
          CustomerAlertResponse.showError(
            context,
            message: error.bodyString['message'],
          );
        });
    isLoadingLogin = false;
    notifyListeners();
  }

  String user = '';
  bool isLoadingGetUser = false;
  void onGetUser(BuildContext context) async {
    if (token.isEmpty) {
      router.go('/log-in');
      return;
    }
    isLoadingGetUser = true;
    notifyListeners();
    await api
        ?.onNetworkRequesting(
          url: '/auth/me',
          methode: METHODE.get,
          token: token,
        )
        .then((res) {
          debugPrint('get user: --->>> ${res['firstName']} ${res['lastName']}');
          context.go('/home');
        })
        .onError((ErrorModel error, stackTrace) {
          debugPrint(
            'on Error get user -------------------->>> ${error.bodyString['message']}',
          );
          CustomerAlertResponse.showError(
            context,
            message: error.bodyString['message'],
          );
          router.go('/log-in');
        });
    isLoadingGetUser = false;
    notifyListeners();
  }

  void signOut() {
    token = '';
    notifyListeners();
  }
}
