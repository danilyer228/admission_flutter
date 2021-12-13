import 'dart:convert';

import 'Model.dart';

PetResponse petResponseFromJson(String str) => PetResponse.fromJson(json.decode(str));

String petResponseToJson(PetResponse data) => json.encode(data.toJson());

class PetResponse implements Model {
  PetResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory PetResponse.fromJson(Map<String, dynamic> json) => PetResponse(
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
    required this.pet,
  });

  String totalCount;
  List<Pet> pet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalCount: json["totalCount"],
    pet: List<Pet>.from(json["pet"].map((x) => Pet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "pet": List<dynamic>.from(pet.map((x) => x.toJson())),
  };
}

class Pet implements Model {
  Pet({
    required this.id,
    required this.ownerId,
    required this.typeId,
    required this.alias,
    required this.sex,
    required this.dateRegister,
    required this.birthday,
    required this.note,
    required this.breedId,
    required this.oldId,
    required this.colorId,
    required this.deathnote,
    required this.deathdate,
    required this.chipNumber,
    required this.labNumber,
    required this.status,
    required this.picture,
    required this.weight,
    required this.owner,
    required this.type,
    required this.breed,
  });

  String id;
  String ownerId;
  String typeId;
  String alias;
  String sex;
  DateTime dateRegister;
  dynamic birthday;
  String note;
  String breedId;
  dynamic oldId;
  String colorId;
  dynamic deathnote;
  dynamic deathdate;
  String chipNumber;
  String labNumber;
  String status;
  dynamic picture;
  String weight;
  Owner owner;
  Type type;
  Breed breed;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json["id"],
    ownerId: json["owner_id"],
    typeId: json["type_id"],
    alias: json["alias"],
    sex: json["sex"],
    dateRegister: DateTime.parse(json["date_register"]),
    birthday: json["birthday"],
    note: json["note"],
    breedId: json["breed_id"],
    oldId: json["old_id"],
    colorId: json["color_id"],
    deathnote: json["deathnote"],
    deathdate: json["deathdate"],
    chipNumber: json["chip_number"],
    labNumber: json["lab_number"],
    status: json["status"],
    picture: json["picture"],
    weight: json["weight"],
    owner: Owner.fromJson(json["owner"]),
    type: Type.fromJson(json["type"]),
    breed: Breed.fromJson(json["breed"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner_id": ownerId,
    "type_id": typeId,
    "alias": alias,
    "sex": sex,
    "date_register": dateRegister.toIso8601String(),
    "birthday": birthday,
    "note": note,
    "breed_id": breedId,
    "old_id": oldId,
    "color_id": colorId,
    "deathnote": deathnote,
    "deathdate": deathdate,
    "chip_number": chipNumber,
    "lab_number": labNumber,
    "status": status,
    "picture": picture,
    "weight": weight,
    "owner": owner.toJson(),
    "type": type.toJson(),
    "breed": breed.toJson(),
  };
}

class Breed implements Model {
  Breed({
    required this.id,
    required this.title,
    required this.petTypeId,
  });

  String id;
  String title;
  String petTypeId;

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    id: json["id"],
    title: json["title"],
    petTypeId: json["pet_type_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "pet_type_id": petTypeId,
  };
}

class Owner implements Model {
  Owner({
    required this.id,
    required this.address,
    required this.homePhone,
    required this.workPhone,
    required this.note,
    required this.typeId,
    required this.howFind,
    required this.balance,
    required this.email,
    required this.city,
    required this.cityId,
    required this.dateRegister,
    required this.cellPhone,
    required this.zip,
    required this.registrationIndex,
    required this.vip,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.status,
    required this.discount,
    required this.passportSeries,
    required this.labNumber,
    required this.streetId,
    required this.apartment,
    required this.unsubscribe,
    required this.inBlacklist,
    required this.lastVisitDate,
    required this.numberOfJournal,
    required this.phonePrefix,
  });

  String id;
  String address;
  String homePhone;
  String workPhone;
  String note;
  dynamic typeId;
  dynamic howFind;
  String balance;
  String email;
  String city;
  String cityId;
  DateTime dateRegister;
  String cellPhone;
  String zip;
  dynamic registrationIndex;
  String vip;
  String lastName;
  String firstName;
  String middleName;
  String status;
  String discount;
  String passportSeries;
  String labNumber;
  String streetId;
  String apartment;
  String unsubscribe;
  String inBlacklist;
  String lastVisitDate;
  String numberOfJournal;
  String phonePrefix;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    address: json["address"],
    homePhone: json["home_phone"],
    workPhone: json["work_phone"],
    note: json["note"],
    typeId: json["type_id"],
    howFind: json["how_find"],
    balance: json["balance"],
    email: json["email"],
    city: json["city"],
    cityId: json["city_id"],
    dateRegister: DateTime.parse(json["date_register"]),
    cellPhone: json["cell_phone"],
    zip: json["zip"],
    registrationIndex: json["registration_index"],
    vip: json["vip"],
    lastName: json["last_name"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    status: json["status"],
    discount: json["discount"],
    passportSeries: json["passport_series"],
    labNumber: json["lab_number"],
    streetId: json["street_id"],
    apartment: json["apartment"],
    unsubscribe: json["unsubscribe"],
    inBlacklist: json["in_blacklist"],
    lastVisitDate: json["last_visit_date"],
    numberOfJournal: json["number_of_journal"],
    phonePrefix: json["phone_prefix"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "home_phone": homePhone,
    "work_phone": workPhone,
    "note": note,
    "type_id": typeId,
    "how_find": howFind,
    "balance": balance,
    "email": email,
    "city": city,
    "city_id": cityId,
    "date_register": dateRegister.toIso8601String(),
    "cell_phone": cellPhone,
    "zip": zip,
    "registration_index": registrationIndex,
    "vip": vip,
    "last_name": lastName,
    "first_name": firstName,
    "middle_name": middleName,
    "status": status,
    "discount": discount,
    "passport_series": passportSeries,
    "lab_number": labNumber,
    "street_id": streetId,
    "apartment": apartment,
    "unsubscribe": unsubscribe,
    "in_blacklist": inBlacklist,
    "last_visit_date": lastVisitDate,
    "number_of_journal": numberOfJournal,
    "phone_prefix": phonePrefix,
  };
}

class Type implements Model {
  Type({
    required this.id,
    required this.title,
    required this.picture,
    required this.type,
  });

  String id;
  String title;
  String picture;
  String type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    title: json["title"],
    picture: json["picture"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "picture": picture,
    "type": type,
  };
}
