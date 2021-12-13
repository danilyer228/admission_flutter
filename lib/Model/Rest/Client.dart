import 'dart:convert';

import 'package:vetmanager_admission_creator/Model/Rest/Model.dart';

ClientResponse clientResponseFromJson(String str) => ClientResponse.fromJson(json.decode(str));

String clientResponseToJson(ClientResponse data) => json.encode(data.toJson());

class ClientResponse implements Model {
  ClientResponse({
    required this.data,
    required this.success,
  });

  Data data;
  bool success;

  factory ClientResponse.fromJson(Map<String, dynamic> json) => ClientResponse(
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "success": success,
  };
}

class Data implements Model{
  Data({
    required this.client,
  });

  List<Client> client;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    client: List<Client>.from(json["client"].map((x) => Client.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "client": List<dynamic>.from(client.map((x) => x.toJson())),
  };
}

class Client implements Model{
  Client({
    required this.clientId,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.email,
    required this.address,
    required this.inBlacklist,
    required this.description,
    required this.balance,
    this.type,
    required this.cellPhone,
    required this.status,
    required this.apartment,
    required this.phonePrefix,
    required this.cityId,
    required this.cityTitle,
    required this.cityTypeId,
    this.streetId,
    this.streetTitle,
    this.streetType,
    required this.clinicPhonePrefix,
    required this.pets,
  });

  String clientId;
  String lastName;
  String firstName;
  String middleName;
  String email;
  String address;
  String inBlacklist;
  String description;
  String balance;
  dynamic type;
  String cellPhone;
  String status;
  String apartment;
  String phonePrefix;
  String cityId;
  String cityTitle;
  String cityTypeId;
  dynamic streetId;
  dynamic streetTitle;
  dynamic streetType;
  String clinicPhonePrefix;
  List<Pet> pets;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    clientId: json["client_id"],
    lastName: json["last_name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    email: json["email"],
    address: json["address"],
    inBlacklist: json["in_blacklist"],
    description: json["description"],
    balance: json["balance"],
    type: json["type"],
    cellPhone: json["cell_phone"],
    status: json["status"],
    apartment: json["apartment"],
    phonePrefix: json["phone_prefix"],
    cityId: json["city_id"],
    cityTitle: json["city_title"],
    cityTypeId: json["city_type_id"],
    streetId: json["street_id"],
    streetTitle: json["street_title"],
    streetType: json["street_type"],
    clinicPhonePrefix: json["clinic_phone_prefix"],
    pets: List<Pet>.from(json["pets"].map((x) => Pet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "last_name": lastName,
    "first_name": firstName,
    "middle_name": middleName,
    "email": email,
    "address": address,
    "in_blacklist": inBlacklist,
    "description": description,
    "balance": balance,
    "type": type,
    "cell_phone": cellPhone,
    "status": status,
    "apartment": apartment,
    "phone_prefix": phonePrefix,
    "city_id": cityId,
    "city_title": cityTitle,
    "city_type_id": cityTypeId,
    "street_id": streetId,
    "street_title": streetTitle,
    "street_type": streetType,
    "clinic_phone_prefix": clinicPhonePrefix,
    "pets": List<dynamic>.from(pets.map((x) => x.toJson())),
  };
}

class Pet implements Model {
  Pet({
    required this.petId,
    required this.alias,
    required this.sex,
    required this.birthday,
    required this.ownerId,
    required this.petType,
    required this.breed,
    required this.petTypeTitle,
    required this.petTypeId,
  });

  String petId;
  String alias;
  String sex;
  dynamic birthday;
  String ownerId;
  String petType;
  String breed;
  String petTypeTitle;
  String petTypeId;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    petId: json["pet_id"],
    alias: json["alias"],
    sex: json["sex"],
    birthday: json["birthday"],
    ownerId: json["owner_id"],
    petType: json["pet_type"],
    breed: json["breed"],
    petTypeTitle: json["pet_type_title"],
    petTypeId: json["pet_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "pet_id": petId,
    "alias": alias,
    "sex": sex,
    "birthday": birthday,
    "owner_id": ownerId,
    "pet_type": petType,
    "breed": breed,
    "pet_type_title": petTypeTitle,
    "pet_type_id": petTypeId,
  };
}

