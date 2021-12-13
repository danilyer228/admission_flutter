import 'dart:convert';

AdmissionResponse admissionResponseFromJson(String str) => AdmissionResponse.fromJson(json.decode(str));

String admissionResponseToJson(AdmissionResponse data) => json.encode(data.toJson());

class AdmissionResponse {
  AdmissionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory AdmissionResponse.fromJson(Map<String, dynamic> json) => AdmissionResponse(
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

class Data {
  Data({
    required this.totalCount,
    required this.admission,
  });

  int totalCount;
  List<Admission> admission;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalCount: json["totalCount"],
    admission: List<Admission>.from(json["admission"].map((x) => Admission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "admission": List<dynamic>.from(admission.map((x) => x.toJson())),
  };
}

class Admission {
  Admission({
    required this.id,
    required this.admissionDate,
    required this.description,
    required this.clientId,
    required this.patientId,
    required this.userId,
    required this.typeId,
    required this.admissionLength,
    required this.status,
    required this.clinicId,
    required this.directDirection,
    required this.creatorId,
    required this.createDate,
    required this.escorterId,
    required this.receptionWriteChannel,
    required this.isAutoCreate,
    required this.pet,
    required this.client,
  });

  String id;
  DateTime admissionDate;
  String description;
  String clientId;
  String patientId;
  String userId;
  String typeId;
  String admissionLength;
  String status;
  String clinicId;
  String directDirection;
  String creatorId;
  DateTime createDate;
  String escorterId;
  String receptionWriteChannel;
  String isAutoCreate;
  Pet pet;
  Client client;

  factory Admission.fromJson(Map<String, dynamic> json) => Admission(
    id: json["id"],
    admissionDate: DateTime.parse(json["admission_date"]),
    description: json["description"],
    clientId: json["client_id"],
    patientId: json["patient_id"],
    userId: json["user_id"],
    typeId: json["type_id"],
    admissionLength: json["admission_length"],
    status: json["status"],
    clinicId: json["clinic_id"],
    directDirection: json["direct_direction"],
    creatorId: json["creator_id"],
    createDate: DateTime.parse(json["create_date"]),
    escorterId: json["escorter_id"],
    receptionWriteChannel: json["reception_write_channel"],
    isAutoCreate: json["is_auto_create"],
    pet: Pet.fromJson(json["pet"]),
    client: Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "admission_date": admissionDate.toIso8601String(),
    "description": description,
    "client_id": clientId,
    "patient_id": patientId,
    "user_id": userId,
    "type_id": typeId,
    "admission_length": admissionLength,
    "status": status,
    "clinic_id": clinicId,
    "direct_direction": directDirection,
    "creator_id": creatorId,
    "create_date": createDate.toIso8601String(),
    "escorter_id": escorterId,
    "reception_write_channel": receptionWriteChannel,
    "is_auto_create": isAutoCreate,
    "pet": pet.toJson(),
    "client": client.toJson(),
  };
}

class Client {
  Client({
    required this.id,
    required this.address,
    required this.homePhone,
    required this.workPhone,
    required this.note,
    this.typeId,
    this.howFind,
    required this.balance,
    required this.email,
    required this.city,
    required this.cityId,
    required this.dateRegister,
    required this.cellPhone,
    required this.zip,
    this.registrationIndex,
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

  factory Client.fromJson(Map<String, dynamic> json) => Client(
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

class Pet {
  Pet({
    required this.id,
    required this.ownerId,
    required this.typeId,
    required this.alias,
    required this.sex,
    required this.dateRegister,
    this.birthday,
    required  this.note,
    required this.breedId,
    this.oldId,
    required this.colorId,
    this.deathnote,
    this.deathdate,
    required this.chipNumber,
    required this.labNumber,
    required this.status,
    this.picture,
    required this.weight,
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
  };
}
