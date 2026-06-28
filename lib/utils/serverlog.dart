part of catapiljaapp;

class ServerLog {
  // static final logMessage = {"LOG": ""};

  static void doServerLog(
    String logString, {
    bool alsoToFile = true,
    String logfileLocation = "",
    String logfileName = "",
    bool printLog = true,
  }) async {
    var timeStamp = DateUtils.getLogTimeStampEN_US();
    // var logMessage = "$timeStamp $logString";
    // print(logMessage);

    if (alsoToFile == false) {
      return;
    }

    if (logfileName.isEmpty) {
      DateTime dtNow = DateTime.now();
      logfileName = "LOGFILE_${dtNow.year}${dtNow.month}${dtNow.day}";
    }

    if (printLog == true) {
      print("$timeStamp $logString\n");
    }

    if (logfileLocation.isNotEmpty) {
      try {
        var logFile = File('$logfileLocation$logfileName.txt');
        var sink = logFile.openWrite(mode: FileMode.append);
        sink.write("$timeStamp $logString\n");
        await sink.flush();
        await sink.close();
      } catch (ex) {
        print(
          "Exception created when attempting to write to the container log file ${ex} \n",
        );
      }
    } else {
      try {
        var logFile = File('./logfile.txt');
        var sink = logFile.openWrite(mode: FileMode.append);
        sink.write("$timeStamp $logString\n");
        await sink.flush();
        await sink.close();
      } catch (lfex) {
        print(
          "Exception created when attempting to write to the local log file ${lfex} \n",
        );
      }
    }

    /* try {
      var logFile = File(logFileName);
      var sink = logFile.openWrite(mode: FileMode.append);
      sink.write("$logMessage\n");
      await sink.flush();
      await sink.close();
    } catch (ex) {
      print(
        "Exception created when attempting to write to the container log file ${ex} \n",
      );
    } */
  }
}
