import 'package:timesheet/data/model/body/user.dart';

import '../../../helper/date_converter.dart';

class Member {
  DateTime? createDate;
  String? createdBy;
  DateTime? modifyDate;
  String? modifiedBy;
  String? id;
  String? name;
  String? code;
  String? gender;
  String? type;
  String? email;
  String? position;
  String? level;
  String? status;
  DateTime? dateJoin;
  String? team;
  User? user;

  Member(
      {createDate,
        createdBy,
        modifyDate,
        modifiedBy,
        id,
        name,
        code,
        gender,
        type,
        email,
        position,
        level,
        status,
        dateJoin,
        team,
        user});

  Member.fromJson(Map<String, dynamic> json) {
    createDate = DateTime.tryParse(json['createDate']??'');
    createdBy = json['createdBy'] ?? '';
    modifyDate = DateTime.tryParse(json['modifyDate']?? '');
    modifiedBy = json['modifiedBy'] ?? '';
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    code = json['code'];
    gender = json['gender'] ?? '';
    type = json['type'];
    email = json['email'];
    position = json['position'];
    level = json['level'] ?? '';
    status = json['status'];
    dateJoin = DateTime.tryParse(json['dateJoin']??'');
    team = json['team'] ?? '';
    user = json['user'] != null ? User.fromJson(json['user']) : User();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = DateConverter.localDateToString(createDate);
    data['createdBy'] = createdBy;
    data['modifyDate'] = DateConverter.localDateToString(modifyDate);
    data['modifiedBy'] = modifiedBy;
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['gender'] = gender;
    data['type'] = type;
    data['email'] = email;
    data['position'] = position;
    data['level'] = level;
    data['status'] = status;
    data['dateJoin'] = DateConverter.localDateToString(dateJoin);
    
    if(team != null){
      data['team'] = team;
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}