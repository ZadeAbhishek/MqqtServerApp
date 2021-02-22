// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.clientId,
    this.modbusId,
    this.startReg,
    this.ts,
    this.d,
    this.data,
  });

  String clientId;
  String modbusId;
  String startReg;
  String ts;
  String d;
  List<double> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        clientId: json["ClientID"],
        modbusId: json["ModbusID"],
        startReg: json["StartReg"],
        ts: json["TS"],
        d: json["D"],
        data: List<double>.from(json["data"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "ClientID": clientId,
        "ModbusID": modbusId,
        "StartReg": startReg,
        "TS": ts,
        "D": d,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
