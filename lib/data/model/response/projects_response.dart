import '../body/project.dart';

class ProjectsResponse {
  DateTime? timestamp;
  int? code;
  String? message;
  Data? data;
  int? total;

  ProjectsResponse(
      {this.timestamp, this.code, this.message, this.data, this.total});

  ProjectsResponse.fromJson(Map<String, dynamic> json) {
    timestamp = DateTime.tryParse(json['timestamp']??'');;
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Data {
  List<Project>? content;

  Data({this.content});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Project>[];
      json['content'].forEach((v) {
        content!.add(Project.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}