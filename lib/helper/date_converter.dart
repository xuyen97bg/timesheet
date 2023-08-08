import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateConverter {
  static DateFormat formatter = DateFormat('yyyy-MM-dd');
  static String lastDayOfMonth(DateTime dateTime){
    return formatter.format(DateTime(dateTime.year, dateTime.month + 1, 0));
  }

  static String firstDayOfMonth(DateTime dateTime){
    return formatter.format(DateTime(dateTime.year, dateTime.month, 1));
  }

  static String? formatDateWorking(DateTime? dateTime) {
    return dateTime == null ? null : formatter.format(dateTime);
  }

  static String formatDateItemTracking(DateTime dateTime){
    dynamic dayData =
        '{ "1" : "T2", "2" : "T3", "3" : "T4", "4" : "T5", "5" : "T6", "6" : "T7", "7" : "CN" }';
    //dd/MM EE
    return DateFormat('dd/MM ').format(dateTime) + json.decode(dayData)['${dateTime.weekday}'];
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String? localDateToString(DateTime? dateTime) {
    return dateTime == null ? null: DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static bool isAvailable(String start, String end, {required DateTime time}) {
    DateTime _currentTime;
    if(time != null) {
      _currentTime = time;
    }else {
      // _currentTime = Get.find<SplashController>().currentTime;
      _currentTime = DateTime(2033);
    }
    DateTime _start = start != null ? DateFormat('HH:mm').parse(start) : DateTime(_currentTime.year);
    DateTime _end = end != null ? DateFormat('HH:mm').parse(end) : DateTime(_currentTime.year, _currentTime.month, _currentTime.day, 23, 59, 59);
    DateTime _startTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _start.hour, _start.minute, _start.second);
    DateTime _endTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _end.hour, _end.minute, _end.second);
    if(_endTime.isBefore(_startTime)) {
      if(_currentTime.isBefore(_startTime) && _currentTime.isBefore(_endTime)){
        _startTime = _startTime.add(Duration(days: -1));
      }else {
        _endTime = _endTime.add(Duration(days: 1));
      }
    }
    return _currentTime.isAfter(_startTime) && _currentTime.isBefore(_endTime);
  }

  static String _timeFormatter() {
    return
      // Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' :
      'hh:mm a';
  }

  static String convertFromMinute(int minMinute, int maxMinute) {
    int _firstValue = minMinute;
    int _secondValue = maxMinute;
    String _type = 'min';
    if(minMinute >= 525600) {
      _firstValue = (minMinute / 525600).floor();
      _secondValue = (maxMinute / 525600).floor();
      _type = 'year';
    }else if(minMinute >= 43200) {
      _firstValue = (minMinute / 43200).floor();
      _secondValue = (maxMinute / 43200).floor();
      _type = 'month';
    }else if(minMinute >= 10080) {
      _firstValue = (minMinute / 10080).floor();
      _secondValue = (maxMinute / 10080).floor();
      _type = 'week';
    }else if(minMinute >= 1440) {
      _firstValue = (minMinute / 1440).floor();
      _secondValue = (maxMinute / 1440).floor();
      _type = 'day';
    }else if(minMinute >= 60) {
      _firstValue = (minMinute / 60).floor();
      _secondValue = (maxMinute / 60).floor();
      _type = 'hour';
    }
    return '$_firstValue-$_secondValue ${_type.tr}';
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('h:mm a | d-MMM-yyyy ').format(dateTime.toLocal());
  }

}
