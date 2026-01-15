part of catapiljaapp;

class ServerLog {
  // static final logMessage = {"LOG": ""};

  static void doServerLog(
    String logString, {
    bool alsoToFile = false,
    String logFileName = "",
  }) async {
    var timeStamp = DateUtils.getLogTimeStampEN_EU();
    var logMessage = "$timeStamp $logString";
    print(logMessage);

    if (!alsoToFile) {
      return;
    }

    if (logFileName.isEmpty) return;

    try {
      var logFile = File(logFileName);
      var sink = logFile.openWrite(mode: FileMode.append);
      sink.write("$logMessage\n");
      await sink.flush();
      await sink.close();
    } catch (ex) {
      print(
        "Exception created when attempting to write to the container log file ${ex} \n",
      );
    }
  }
}
