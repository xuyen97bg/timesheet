import 'package:get/get.dart';
import 'package:timesheet/data/model/response/config_response.dart';
import 'package:timesheet/data/repository/splash_repo.dart';
import 'package:timesheet/utils/app_constants.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo repo;

  SplashController({required this.repo});

  bool _hasConnection = true;

  bool get hasConnection => _hasConnection;

  String _version = "";

  String get version => _version;


}
