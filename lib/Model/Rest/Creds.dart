import 'dart:convert';

Creds credsFromJson(String str) => Creds.fromJson(json.decode(str));

String credsToJson(Creds data) => json.encode(data.toJson());

class Creds {
  Creds({
    required this.error,
    required this.errorMessage,
    required this.data,
  });

  bool error;
  String errorMessage;
  Data data;

  factory Creds.fromJson(Map<String, dynamic> json) => Creds(
    error: json["error"],
    errorMessage: json["errorMessage"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "errorMessage": errorMessage,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.apiToken,
    required this.url,
  });

  int id;
  String apiToken;
  String url;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    apiToken: json["api_token"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "api_token": apiToken,
    "url": url,
  };
}
