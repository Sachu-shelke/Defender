import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFormExtension on DateTime {
  String get getDateFormat {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String get getDateSecondFormat {
    return DateFormat('yyy-MM-dd').format(this);
  }
}

extension SucessDateTime on String {
  String get getSuccessDateFormat {
    return DateFormat('dd MMM yyy').format(DateTime.parse(this));
  }

  String get getDateTime {
    return DateFormat('dd MMM yyy, hh:mm a ').format(DateTime.parse(this));
  }
  String get getDateTimeNew {
    return DateFormat('dd MMM yyy, hh:mm a ').format(DateTime.parse(this));
  }
}

extension GetTime on String {
  String get getTimeFormat {
    final str = DateFormat('hh:mm a').format(DateTime.parse(this));
    return str;
  }

  String get getTimeFormatOnly {
    final str = DateFormat('HH:mm').format(DateTime.parse(this));
    return str;
  }
}

extension GetTrackingTime on String {
  String get getTrackingTimeFormat {
    final str = DateFormat('EEE, dd MMM yyy').format(DateTime.parse(this));
    return str;
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

extension AmountExtension on int {
  toAmount() {
    String formattedAmount = NumberFormat("#,##0").format(this);
    return formattedAmount;
  }
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
