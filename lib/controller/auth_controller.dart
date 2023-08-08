import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:timesheet/data/model/body/user.dart';
import 'package:timesheet/data/model/response/token_resposive.dart';
import 'package:timesheet/data/repository/auth_repo.dart';


class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;

  AuthController({required this.repo});

  bool _loading = false;

  bool get loading => _loading;

  Rx<List<User>> users = Rx(List.empty());

  Future<int> login(String username, String password) async {
    _loading = true;
    Response response =
        await repo.login(username: username, password: password);
    _loading = false;

    if (response.statusCode == 200) {
      print('response1 ${response.body.toString()}');
      TokenResponsive tokeBody = TokenResponsive.fromJson(response.body);
      print('response2 ${response.body.toString()}');
      print('accessToken: ${tokeBody.accessToken!}');
      repo.saveUserToken(tokeBody.accessToken!);
    }
    _loading = false;
    return response.statusCode!;
  }

  Future<bool> checkToken() async {
    _loading = true;
    Response response = await repo.checkToken();
    _loading = false;
    return response.isOk;
  }
}


