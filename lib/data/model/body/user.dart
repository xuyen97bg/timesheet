import 'dart:convert';
import 'dart:ffi';

import '../../../helper/date_converter.dart';
class User {
  DateTime? createDate;
  String? createdBy;
  DateTime? modifyDate;
  String? modifiedBy;
  int? id;
  String? gender;
  String? username;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? active;
  bool? credentialsNonExpired;
  String? email;
  String? phone;
  bool? justCreated;
  int? lastLoginFailures;
  DateTime? lastLoginTime;
  int? totalLoginFailures;
  String? orgId;
  List<dynamic>? roles;
  List<dynamic>? authorities;
  String? jti;
  User(
      {this.createDate,
        this.createdBy,
        this.modifyDate,
        this.modifiedBy,
        this.id,
        this.gender,
        this.username,
        this.accountNonExpired,
        this.accountNonLocked,
        this.active,
        this.credentialsNonExpired,
        this.email,
        this.phone,
        this.justCreated,
        this.lastLoginFailures,
        this.lastLoginTime,
        this.totalLoginFailures,
        this.orgId,
        this.roles,
        this.authorities,
        this.jti});

  User.fromJson(Map<String, dynamic> json) {
    createDate = DateTime.tryParse(json['createDate']??'') ?? DateTime.now();
    createdBy =  json['createdBy'];
    modifyDate = DateTime.tryParse(json['modifyDate']??'') ?? DateTime.now();
    modifiedBy = json['modifiedBy'];
    id = json['id'];
    gender = json['gender'] ?? '';
    username = json['username'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    active = json['active'];
    credentialsNonExpired = json['credentialsNonExpired'] ;
    email = json['email'];
    phone = json['phone'] ?? '';
    justCreated = json['justCreated'];
    lastLoginFailures = json['lastLoginFailures'] ?? 0;
    lastLoginTime = DateTime.tryParse(json['lastLoginTime']?? '');
    totalLoginFailures = json['totalLoginFailures'] ?? 0;
    orgId = json['orgId'] ?? '';
    roles = json['roles'] ?? [];
    authorities = json['authorities'] ?? [];
    jti = json['jti']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = DateConverter.localDateToString(createDate);
    data['createdBy'] = createdBy;
    data['modifyDate'] = DateConverter.localDateToString(modifyDate) ;
    data['modifiedBy'] = modifiedBy;
    data['id'] = id;
    data['gender'] = gender;
    data['username'] = username;
    data['accountNonExpired'] = accountNonExpired;
    data['accountNonLocked'] = accountNonLocked;
    data['active'] = active;
    data['credentialsNonExpired'] = credentialsNonExpired;
    data['email'] = email;
    data['phone'] = phone;
    data['justCreated'] = justCreated;
    data['lastLoginFailures'] = lastLoginFailures;
    data['lastLoginTime'] = DateConverter.localDateToString(lastLoginTime);
    data['totalLoginFailures'] = totalLoginFailures;
    data['orgId'] = orgId;
    data['roles'] = roles;
    data['authorities'] = authorities;
    data['jti'] = jti;
    return data;
  }
}