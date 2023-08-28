import 'package:get/get_connect/http/src/response/response.dart';
import 'package:timesheet/data/model/body/tracking.dart';
import 'package:timesheet/helper/date_converter.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class HomeRepo {
  final ApiClient apiClient;

  HomeRepo({required this.apiClient});
  Future<Response> getTracks(int pageIndex, DateTime dateTime, int pageSize) async {
    Map<String, dynamic> mapQuerys = Map();
    mapQuerys['startDate'] = DateConverter.firstDayOfMonth(dateTime);
    mapQuerys['endDate'] = DateConverter.lastDayOfMonth(dateTime);
    mapQuerys['pageIndex'] = '$pageIndex';
    mapQuerys['pageSize'] = '$pageSize';
    return await apiClient.getData(AppConstants.GET_CONTENTS,queryParameters: mapQuerys);
  }
  
  Future<Response> getProjects() async {
    Map<String, dynamic> mapQuerys = Map();
    mapQuerys['pageIndex'] = '0';
    mapQuerys['pageSize'] = '1000';
    mapQuerys['keyword'] = '';
    return await apiClient.getData(AppConstants.GET_PROJECTS,queryParameters: mapQuerys);
  }

  Future<Response> postTracking(Tracking tracking) async {
    return await apiClient.postData(path: AppConstants.POST_TRACKING,body: tracking.toJson());
  }

  Future<Response> putTracking(Tracking tracking) async {
    return await apiClient.putData(body: tracking.toJson(),path: '${AppConstants.POST_TRACKING}/${tracking.id}');
  }
}
