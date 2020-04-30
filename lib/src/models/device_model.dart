// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
    int id;
    String name;
    String ip;
    String port;
    String password;

    DeviceModel({
        this.id,
        this.name,
        this.ip,
        this.port,
        this.password,
    });

    factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json["id"],
        name: json["name"],
        ip: json["ip"],
        port: json["port"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ip": ip,
        "port": port,
        "password": password,
    };
}
