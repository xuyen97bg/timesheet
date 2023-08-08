import 'package:timesheet/data/model/body/tasks.dart';

import '../../../helper/date_converter.dart';
import 'member.dart';

class Tracking {
  DateTime? createDate;
  String? createdBy;
  DateTime? modifyDate;
  String? modifiedBy;
  String? id;
  bool? dayOff;
  DateTime? dateWorking;
  Member? member;
  List<Tasks>? tasks;

  Tracking(
      {this.createDate,
        this.createdBy,
        this.modifyDate,
        this.modifiedBy,
        this.id,
        this.dayOff,
        this.dateWorking,
        this.member,
        this.tasks});

  Tracking.fromJson(Map<String, dynamic> json) {
    createDate =DateTime.tryParse(json['createDate']??'');
    createdBy = json['createdBy'];
    modifyDate = DateTime.tryParse(json['modifyDate']??'');
    modifiedBy = json['modifiedBy'];
    id = json['id'];
    dayOff = json['dayOff']??false;
    dateWorking = DateTime.tryParse(json['dateWorking']??'');
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(createDate!=null){
      data['createDate'] = DateConverter.localDateToString(createDate);
    }
    if(createdBy!=null){
      data['createdBy'] = createdBy;
    }
    if(modifyDate!=null){
      data['modifyDate'] = DateConverter.localDateToString(modifyDate);
    }
    if(modifiedBy!=null){
      data['modifiedBy'] = modifiedBy;
    }
    if(id!=null){
      data['id'] = id;
    }
    if(dayOff!=null){
      data['dayOff'] = dayOff;
    }
    if(dateWorking!=null){
      data['dateWorking'] = DateConverter.formatDateWorking(dateWorking);
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}