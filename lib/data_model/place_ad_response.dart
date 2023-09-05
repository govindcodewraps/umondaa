// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

PAResponse PAResponseFromJson(String str) => PAResponse.fromJson(json.decode(str));

String PAResponseToJson(PAResponse data) => json.encode(data.toJson());

class PAResponse {
  PAResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory PAResponse.fromJson(Map<String, dynamic> json) => PAResponse(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}
