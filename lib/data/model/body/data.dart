import 'tracking.dart';

class Data {
  List<Tracking>? content;

  Data({this.content});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Tracking>[];
      json['content'].forEach((v) {
        content!.add(Tracking.fromJson(v));
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