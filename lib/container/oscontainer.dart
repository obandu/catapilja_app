part of catapiljaapp;

class OSContainer {
  static String get environment {
    // get container environment
    String _environment = "UNKNOWN";

    // Get the operating system as a string.
    String os = Platform.operatingSystem;
    if (os.toString().toUpperCase() == "WINDOWS") {
      _environment = "WINDOWS";
    } else {
      _environment = os.toString().toUpperCase();
    }
    print(
      "Other platform notable things are ${Platform.environment.toString()}",
    );

    return _environment;
  }

  static String get website {
    // get container environment
    String _website = Platform.environment['WEBSITE'].toString();

    if (_website == "null") {
      _website = ".";
    }
    return _website;
  }

  static String get applicationName {
    String _applicationName = Platform.environment['MYNAME'].toString();
    if (_applicationName.toUpperCase() == "NULL") {
      return "NONAME";
    }

    return _applicationName;
  }
}
