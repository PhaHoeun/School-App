import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_app/configs/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/helper/api_base_helper.dart';

class AuthProvider extends ChangeNotifier {
  ApiBaseHelper? api;
// set api(ApiBaseHelper api) {
//     _api = api;
//   }

  String username = ''; //emilys
  String password = ''; //emilyspass
  String token = '';
  bool isLoadingLogin = false;
  void onLogIn(BuildContext context) async {
    isLoadingLogin = true;
    // try {
    await Dio()
        .post(
          'https://dummyjson.com/auth/login',
          data: {
            'username': username,
            'password': password,
            'expiresInMins': 120,
          },
        )
        .then((res) async {
          debugPrint('res: ${res.data['accessToken']}');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', res.data['accessToken']);
          if (res.statusCode == 200) {
            router.go('/home');
            onGetUser(token: res.data['accessToken']);
          } else {
            //  showTopSnackBar(
            //   Overlay.of(context),
            //   curve: Curves.ease,
            //   animationDuration: const Duration(milliseconds: 800),
            //   CustomSnackBar.error(message: res.data.t),
            // );
            debugPrint('work herre: ${res.statusCode}');
          }
        });
    // } on DioException catch (e) {
    //   debugPrint('catch login : $e');
    //   showTopSnackBar(
    //     Overlay.of(context),
    //     curve: Curves.ease,
    //     animationDuration: const Duration(milliseconds: 800),
    //     CustomSnackBar.error(message: e.toString()),
    //   );
    // }
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
