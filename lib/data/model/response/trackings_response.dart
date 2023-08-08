import '../body/data.dart';

class TrackingsResponse {
  DateTime? timestamp;
  int? code;
  String? message;
  Data? data;
  int? total;

  TrackingsResponse(
      {this.timestamp, this.code, this.message, this.data, this.total});

  TrackingsResponse.fromJson(Map<String, dynamic> json) {
    timestamp = DateTime.tryParse(json['timestamp']??'');
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}