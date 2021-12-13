import 'dart:convert';

import 'Model.dart';

DoctorResponse doctorResponseFromJson(String str) => DoctorResponse.fromJson(json.decode(str));

String doctorResponseToJson(DoctorResponse data) => json.encode(data.toJson());

class DoctorResponse implements Model {
  DoctorResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => DoctorResponse(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data implements Model {
  Data({
    required this.totalCount,
    required this.user,
  });

  String totalCount;
  List<User> user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalCount: json["totalCount"],
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class User implements Model {
  User({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.login,
    required this.passwd,
    required this.positionId,
    required this.email,
    required this.phone,
    required this.cellPhone,
    required this.address,
    required this.roleId,
    required this.isActive,
    required this.calcPercents,
    required this.nickname,
    required this.lastChangePwdDate,
    required this.isLimited,
    this.carrotquestId,
    required this.sipNumber,
    required this.userInn,
    required this.position,
    required this.role,
  });

  String id;
  String lastName;
  String firstName;
  String middleName;
  String login;
  String passwd;
  String positionId;
  String email;
  String phone;
  String cellPhone;
  String address;
  String roleId;
  String isActive;
  String calcPercents;
  String nickname;
  DateTime lastChangePwdDate;
  String isLimited;
  dynamic carrotquestId;
  String sipNumber;
  String userInn;
  Position position;
  Role role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    lastName: json["last_name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    login: json["login"],
    passwd: json["passwd"],
    positionId: json["position_id"],
    email: json["email"],
    phone: json["phone"],
    cellPhone: json["cell_phone"],
    address: json["address"],
    roleId: json["role_id"],
    isActive: json["is_active"],
    calcPercents: json["calc_percents"],
    nickname: json["nickname"],
    lastChangePwdDate: DateTime.parse(json["last_change_pwd_date"]),
    isLimited: json["is_limited"],
    carrotquestId: json["carrotquest_id"],
    sipNumber: json["sip_number"],
    userInn: json["user_inn"],
    position: Position.fromJson(json["position"]),
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_name": lastName,
    "first_name": firstName,
    "middle_name": middleName,
    "login": login,
    "passwd": passwd,
    "position_id": positionId,
    "email": email,
    "phone": phone,
    "cell_phone": cellPhone,
    "address": address,
    "role_id": roleId,
    "is_active": isActive,
    "calc_percents": calcPercents,
    "nickname": nickname,
    "last_change_pwd_date": "${lastChangePwdDate.year.toString().padLeft(4, '0')}-${lastChangePwdDate.month.toString().padLeft(2, '0')}-${lastChangePwdDate.day.toString().padLeft(2, '0')}",
    "is_limited": isLimited,
    "carrotquest_id": carrotquestId,
    "sip_number": sipNumber,
    "user_inn": userInn,
    "position": position.toJson(),
    "role": role.toJson(),
  };
}

class Position implements Model {
  Position({
    required this.id,
    required this.title,
    required this.admissionLength,
  });

  String id;
  String title;
  String admissionLength;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    id: json["id"],
    title: json["title"],
    admissionLength: json["admission_length"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "admission_length": admissionLength,
  };
}

class Role implements Model {
  Role({
    required this.id,
    required this.name,
    required this.roleSuper,
  });

  String id;
  String name;
  String roleSuper;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    roleSuper: json["super"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "super": roleSuper,
  };
}
