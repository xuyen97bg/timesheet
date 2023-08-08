import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:timesheet/data/model/body/project.dart';
import 'package:timesheet/data/model/response/projects_response.dart';
import 'package:timesheet/data/model/response/trackings_response.dart';
import 'package:timesheet/data/repository/home_repo.dart';

import '../data/model/body/tasks.dart';
import '../data/model/body/tracking.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin
    implements GetxService {
  final HomeRepo repo;

  HomeController({required this.repo});

  late bool _loading;

  bool get loading => _loading;

  late List<Map<String, TextEditingController>> listTaskController = [];
  late TrackingsResponse trackingResponse = TrackingsResponse();
  late List<Project> projects = [];
  late Tracking tracking = Tracking();
  late TabController tabController ;
  late int month = DateTime.now().month;
  late int year = DateTime.now().year;
  late int pageIndex = 1;
  late bool isEdit;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 0, vsync: this);
  }

  void onNextMonth() {
    if (month == 12) {
      month = 1;
      year++;
    } else {
      month++;
    }
    pageIndex = 1;
    getTrackings();
  }

  void onPreMonth() {
    if (month == 1) {
      month = 12;
      year--;
    } else {
      month--;
    }
    pageIndex = 1;
    getTrackings();
  }

  void onNextIndex() {
    if (pageIndex != 4) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    getTrackings();
  }

  void onPreIndex() {
    if (pageIndex != 1) {
      pageIndex--;
    } else {
      pageIndex = 4;
    }
    getTrackings();
  }

  Future getTrackings() async {
    _loading = true;
    Response response =
        await repo.getTracks(pageIndex, DateTime(year, month, 1));
    _loading = false;
    if (response.isOk) {
      trackingResponse = TrackingsResponse.fromJson(response.body);
    }
    update();
  }

  Future getProjects() async {
    _loading = true;
    Response response = await repo.getProjects();
    _loading = false;
    if (response.isOk) {
      projects = ProjectsResponse.fromJson(response.body).data?.content ?? [];
    }
    update();
  }

  Future<bool> saveTracking() async {
    _loading = true;
    if (tracking.dayOff == true) {
      tracking.tasks = [];
    } else {
      for (int i = 0; i < listTaskController.length; i++) {
        tracking.tasks?[i].overtimeHour =
            int.tryParse(getOvertimeHourController(index: i).text);
        tracking.tasks?[i].officeHour =
            int.tryParse(getOfficeHourController(index: i).text);
        tracking.tasks?[i].taskOffice = getTaskOfficeController(index: i).text;
        tracking.tasks?[i].taskOverTime =
            getTaskOverTimeController(index: i).text;
      }
    }
    Response response;
    if (isEdit) {
      response = await repo.putTracking(tracking);
    } else {
      response = await repo.postTracking(tracking);
    }
    _loading = false;
    return response.isOk;
  }

  void initTaskController({required Tracking mTracking}) {
    tracking = mTracking;
    isEdit = mTracking.tasks != null;
    listTaskController.clear();
    tracking.tasks = tracking.tasks??[];
    if (mTracking.tasks?.isEmpty ?? true) {
      tracking.tasks!.add(
          Tasks(overtimeHour: 0, officeHour: 0, taskOverTime: '', taskOffice: ''));
    }
    tracking.tasks?.forEach((e) => createTaskController(task: e));
    tabController =
        TabController(length: listTaskController.length, vsync: this);
    update();
  }

  void createTaskController({Tasks? task}) {
    Map<String, TextEditingController> mapTask = {
      "officeHour":
          TextEditingController(text: task?.officeHour.toString() ?? '0'),
      "overtimeHour":
          TextEditingController(text: task?.overtimeHour.toString() ?? '0'),
      "taskOffice": TextEditingController(text: task?.taskOffice.toString()),
      "taskOverTime":
          TextEditingController(text: task?.taskOverTime.toString()),
    };
    listTaskController.add(mapTask);
  }

  void deleteTask({required int index}) {
    listTaskController.removeAt(index);
    tracking.tasks?.removeAt(index);
    tabController =
        TabController(length: listTaskController.length, vsync: this);
    update();
  }

  void addTask() {
    tracking.tasks!.add(Tasks(
        overtimeHour: 0, officeHour: 0, taskOverTime: '', taskOffice: ''));
    createTaskController();
    tabController = TabController(
        length: listTaskController.length,
        vsync: this,
        initialIndex: (tracking.tasks!.length - 1));
    update();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  TextEditingController getOfficeHourController({required int index}) =>
      listTaskController[index]['officeHour']!;

  TextEditingController getOvertimeHourController({required int index}) =>
      listTaskController[index]['overtimeHour']!;

  TextEditingController getTaskOfficeController({required int index}) =>
      listTaskController[index]['taskOffice']!;

  TextEditingController getTaskOverTimeController({required int index}) =>
      listTaskController[index]['taskOverTime']!;
}
