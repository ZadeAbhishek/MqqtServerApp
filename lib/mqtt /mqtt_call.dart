import 'mqtt_connect.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/cupertino.dart';

Future<MqttServerClient> client() {
  debugPrint("connecting the client");
  var mqttserverclient = connect();
  return mqttserverclient;
}
