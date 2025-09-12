import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/configs/router/routes.dart';
import 'package:school_app/utils/widget/customer_alert_response.dart';

import '../../../utils/helper/api_base_helper.dart';

class AuthProvider extends ChangeNotifier {
  ApiBaseHelper? api;
  String username = ''; //emilys
  String password = ''; //emilyspass
  String token = '';
  bool isLoadingLogin = false;
  void onLogIn(BuildContext context) async {
    isLoadingLogin = true;

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
          debugPrint('res: $res');
          //  await LocalStorage.storeData(key: 'token', value: );
          router.go('/home');
        })
        .onError((ErrorModel error, stackTrace) {
          debugPrint(
            'on Error -------------------->>> ${error.bodyString['message']}',
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
  void onGetUser({String? token}) async {
    isLoadingGetUser = true;
    try {
      await Dio()
          .get(
            'https://dummyjson.com/auth/me',
            options: Options(
              headers: {
                'Authorization':
                    token ??
                    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3NDQ5NjI5MTQsImV4cCI6MTc0NDk3MDExNH0.OA1grYVKNqzh2HCGDmT7AbGf3j89FLuwPuxU2y8GR8U',
              },
            ),
          )
          .then((res) {
            user = "${res.data['firstName']} ${res.data['lastName']}";
          });
    } on DioException catch (e) {
      debugPrint('catch get user: $e');
    }
    isLoadingGetUser = false;
    notifyListeners();
  }

  void signOut() {
    token = '';
    notifyListeners();
  }
}
