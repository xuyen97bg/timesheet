import 'tracking.dart';

class Data {
  List<Tracking>? tracks;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Data({this.tracks,this.totalElements,this.totalPages,this.number,this.size});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      tracks = <Tracking>[];
      json['content'].forEach((v) {
        tracks!.add(Tracking.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tracks != null) {
      data['content'] = tracks!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['size'] = size;
    data['number'] = number;
    return data;
  }
}