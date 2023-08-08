import 'dart:ffi';

import 'package:timesheet/data/model/body/project.dart';

import '../../../helper/date_converter.dart';

class Tasks {
  DateTime? createDate;
  String? createdBy;
  DateTime? modifyDate;
  String? modifiedBy;
  String? id;
  int? overtimeHour;
  int? officeHour;
  String? taskOffice;
  String? taskOverTime;
  Project? project;

  Tasks(
      {this.createDate,
        this.createdBy,
        this.modifyDate,
        this.modifiedBy,
        this.id,
        this.overtimeHour,
        this.officeHour,
        this.taskOffice,
        this.taskOverTime,
        this.project});

  Tasks.fromJson(Map<String, dynamic> json) {
    createDate = DateTime.tryParse(json['createDate']??'');
    createdBy = json['createdBy'];
    modifyDate = DateTime.tryParse(json['modifyDate']??'');
    modifiedBy = json['modifiedBy'];
    id = json['id'];
    overtimeHour = json['overtimeHour']?.toInt()??0;
    officeHour = json['officeHour']?.toInt()??0;
    taskOffice = json['taskOffice'];
    taskOverTime = json['taskOverTime'];
    project =
    json['project'] != null ? Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = DateConverter.localDateToString(createDate);
    data['createdBy'] = createdBy??'';
    data['modifyDate'] = DateConverter.localDateToString(modifyDate);
    data['modifiedBy'] = modifiedBy??'';
    data['id'] = id;
    data['overtimeHour'] = overtimeHour;
    data['officeHour'] = officeHour;
    data['taskOffice'] = taskOffice;
    data['taskOverTime'] = taskOverTime;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
  }
}