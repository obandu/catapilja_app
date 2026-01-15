part of catapiljaapp;

class DateUtils {
  static String getLogTimeStampEN_US() {
    var tmStamp = timeStamp();
    return "${tmStamp['year']}-${tmStamp['month']}-${tmStamp['day']} ${tmStamp['hour']}:${tmStamp['minute']}:${tmStamp['second']}";
  }

  static String getLogTimeStampEN_EU() {
    var tmStamp = timeStamp();
    return "${tmStamp['day']}-${tmStamp['month']}-${tmStamp['year']} ${tmStamp['hour']}:${tmStamp['minute']}:${tmStamp['second']}";
  }

  static dynamic timeStamp() {
    DateTime dtNow = DateTime.now();

    var day = "${dtNow.day}";
    if (dtNow.day < 10) {
      day = "0${dtNow.day}";
    }

    var month = "${dtNow.month}";
    if (dtNow.month < 10) {
      month = "0${dtNow.month}";
    }

    var hour = "${dtNow.hour}";
    if (dtNow.hour < 10) {
      hour = "0${dtNow.hour}";
    }
    var minute = "${dtNow.minute}";
    if (dtNow.minute < 10) {
      minute = "0${dtNow.minute}";
    }
    var second = "${dtNow.second}";
    if (dtNow.second < 10) {
      second = "0${dtNow.second}";
    }

    return {
      "day": day,
      "month": month,
      "year": dtNow.year,
      "hour": hour,
      "minute": minute,
      "second": second,
    };
  }
}
