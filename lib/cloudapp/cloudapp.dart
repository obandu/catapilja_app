part of catapiljaapp;

class CloudApp {
  final Router router;
  final String applicationName;
  String? registrationURL;
  static bool _isRegistered = false;

  CloudApp({
    required this.router,
    required this.applicationName,
    this.registrationURL,
  });

  Future<void> start(InternetAddress address, int port) async {
    var server = await HttpServer.bind(address, port);
    ServerLog.doServerLog(
      "At $applicationName.cloudapp.start(): server started and waiting for requests",
    );
    if (registrationURL != null) {
      runRegistrationRequest();
    }
    await for (var request in server) {
      router.route(request);
    }
  }

  static void setIsRegistered(bool value) {
    _isRegistered = value;
  }

  void runRegistrationRequest() {
    // add a polling function here that calls another server every 1 minute
    String _myname = Platform.environment['MYNAME'].toString();
    String _applicationPort = Platform.environment['APPLICATIONPORT']
        .toString();
    Map<String, String> headers = const {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (_isRegistered) {
        ServerLog.doServerLog(
          "At $_myname.cloudapp.runRegistrationRequest(): No further registration calls needed.",
        );
        timer.cancel();
        return;
      }
      ServerLog.doServerLog(
        "At $_myname.cloudapp.runRegistrationRequest(): $timer.tick",
      );
      ServerLog.doServerLog(
        "At $_myname.cloudapp.runRegistrationRequest(): FROM $applicationName: Another call to register the server. Registration status is $_isRegistered",
      );
      try {
        final response = await httpClient.post(
          Uri.parse(registrationURL!.toString()),
          body: {
            "action": "registerme",
            "application_name": _myname,
            "application_port": _applicationPort,
            "access_protocol": "HTTP_POST",
            "registration_url": _myname,
            "application_url": _myname,
            "registrationapi_path": "handshake",
          },
          headers: headers,
        );
        ServerLog.doServerLog(
          "At $_myname.cloudapp.runRegistrationRequest(): $applicationName: registration response: ${response.body}",
        );
      } catch (e) {
        ServerLog.doServerLog(
          "At $_myname.cloudapp.runRegistrationRequest(): $applicationName:Error during call for application registration: $e",
        );
      }
    });
  }
}
