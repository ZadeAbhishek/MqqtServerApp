import 'dart:async';

import 'package:flutest/mqtt%20/model%20/mqtt_model.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert';

MqttServerClient client =
    MqttServerClient.withPort('195.201.42.47', 'flutter_client', 1883);
Future<MqttServerClient> connect() async {
  client.logging(on: true);
  client.onConnected = onConnected;
  //client.onDisconnected = onDisconnected;
  //client.onUnsubscribed = onUnsubscribed;

  //client.onSubscribed = onSubscribed;
  client.onSubscribeFail = onSubscribeFail;
  client.pongCallback = pong;

  /*final connMessage = MqttConnectMessage()
      .authenticateAs('username', 'password')
      .keepAliveFor(60)
      .withWillTopic('willtopic')
      .withWillMessage('Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMessage;*/
  try {
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }
  return client;
}

// connection succeeded
void onConnected() {
  print('Connected to IP');
  print('SUBSCIRPBITNG');
  client.subscribe('IOITMeter', MqttQos.atLeastOnce);
  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttPublishMessage message = c[0].payload;
    final payload =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    Future<Welcome> Model_call() async {
      var IoitMeter_Model = null;
      print('Received message:$payload from topic: ${c[0].topic}>');
      print(
          "------------------------------------------------------------------");
      //coverting JSON in map
      var map = json.decode(payload);
      IoitMeter_Model = Welcome.fromJson(map);
      //Have to add try catch method
      return IoitMeter_Model;
    }
  });
}

// unconnected
void onDisconnected() {
  print('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {}

// subscribe to topic failed
void onSubscribeFail(String topic) {
  print('Failed to subscribe $topic');
}

// unsubscribe succeeded
void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  print('Ping response client callback invoked');
}
