import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:vetmanager_admission_creator/Model/Rest/Admission.dart' as Admission;
import 'package:vetmanager_admission_creator/Model/Rest/Client.dart' as Client;
import 'package:vetmanager_admission_creator/Model/Rest/Doctor.dart';
import 'package:vetmanager_admission_creator/VmAppBar.dart';

import '../VmRequest.dart';
import '../creds.dart';


class AdmissionScreen extends StatefulWidget {
  @override
  _AdmissionScreenState createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  late Client.Client clientData;
  late DateTime selectedDatetime;
  late Future<DoctorResponse> doctorResponse;
  PetElement petValue = PetElement(id: '0', alias: 'Не выбрано');
  DoctorElement docValue = DoctorElement(id: '0', fio: 'Не выбрано');

  @override
  void initState() {
    selectedDatetime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    clientData = settings.arguments as Client.Client;
    doctorResponse = getDoctorsData();
    return Scaffold(
      appBar: VmAppBar(),
      body: Center(
        child: Column(
          children: [
            _doctorSelect(),
            _petSelect(),
            _datePicker(),
            _selectedDoctor(),
            _selectedPet(),
            _admissionDate(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(

                    onPressed: () {
                      if (_isFormFilled()) {
                        Future<Admission.AdmissionResponse> futureAdmission = postAdmission();
                        Navigator.pushNamed(
                            context, '/complete',
                            arguments: futureAdmission
                        );
                      }
                    },
                    child: Text("Записаться на прием", style: TextStyle(fontSize: 18),),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  bool _isFormFilled()
  {
    return (docValue.id != '0' && petValue.id != '0');
  }

  Future<Admission.AdmissionResponse> postAdmission() async {
    VmRequest request = new VmRequest(
        apiHost: Environment().config.apiHost,
        apiToken: Environment().config.apiToken
    );
    String query = "Admission";
    return request.post(query, {
      "reception_write_channel": "vetmanager",
      "type_id": "4",
      "admission_date": selectedDatetime.toString(),
      "clinic_id": "1",
      "client_id": clientData.clientId,
      "patient_id": petValue.id,
      "description": "Создано через мобильное приложение",
      "admission_length": "00:15:00",
      "user_id": docValue.id
    }).then((value) {
      return Admission.AdmissionResponse.fromJson(json.decode(value));
    });
  }


  TextButton _datePicker()
  {
    return TextButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              theme: DatePickerTheme(backgroundColor: Colors.lightBlue),
              onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
                setState(() {
                  selectedDatetime = date;
                });
              }, onConfirm: (date) {
                setState(() {
                  selectedDatetime = date;
                });
                print('confirm $date');
              },
              currentTime: DateTime.now(),
              locale: LocaleType.ru);
        },
        child: Text(
          'Выбрать дату и время',
          style: TextStyle(color: Colors.blue),
        )
    );
  }


  DropdownButton _petSelect()
  {
    return DropdownButton<String>(
      value: petValue.id,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          petValue = _petsList().firstWhere((element) => element.id == newValue);
        });
      },
      items: _petsList().map((e) =>
          DropdownMenuItem<String>(
            value: e.id,
            child: Text(e.alias),
          )
      ).toList()
    );
  }

  FutureBuilder _doctorSelect()
  {
    return FutureBuilder<DoctorResponse>(
        future: doctorResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<String>(
              value: docValue.id,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  docValue = _doctorsList(snapshot).firstWhere((element) => element.id == newValue);
                });
              },
              items: _doctorsList(snapshot).map((e) =>
                  DropdownMenuItem<String>(
                    value: e.id,
                    child: Text(e.fio),
                  )
              ).toList()
            );
        } else if (snapshot.hasError) {
          return Text('Error: ' + snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }

  List<DoctorElement> _doctorsList(AsyncSnapshot<DoctorResponse> snapshot)
  {
    List<DoctorElement> result = [];
    for (int i = 0; i < int.parse(snapshot.data!.data.totalCount); i++) {
      var user = snapshot.data!.data.user[i];
      DoctorElement doctor = DoctorElement(
          id: user.id,
          fio: user.lastName + " " + user.firstName[0] + "."
      );
      result.add(doctor);
    }
    result.insert(0, DoctorElement(id: '0', fio: 'Не выбрано'));
    return result;
  }

  List<PetElement> _petsList()
  {
    List<PetElement> result = [];
    for (int i = 0; i < clientData.pets.length; i++) {
      var pet = clientData.pets[i];
      PetElement element = PetElement(
          id: pet.petId,
          alias: pet.alias
      );
      result.add(element);
    }
    result.insert(0, PetElement(id: '0', alias: 'Не выбрано'));
    print(result);
    return result;
  }


  Column _admissionDate()
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Дата посещения:"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('yyyy-MM-dd kk:mm').format(selectedDatetime),
                style: TextStyle(fontSize: 24)),
          ],
        )
      ],
    );
  }

  Column _selectedDoctor()
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Врач:"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(docValue.fio,
                style: TextStyle(fontSize: 24)),
          ],
        )
      ],
    );
  }

  Column _selectedPet()
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Пациент:"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(petValue.alias,
                style: TextStyle(fontSize: 24)),
          ],
        )
      ],
    );
  }

  Future<DoctorResponse> getDoctorsData() async {
    VmRequest request = new VmRequest(
      apiHost: Environment().config.apiHost,
      apiToken: Environment().config.apiToken
    );
    String query = "user?filter=[{'property':'role_id', 'value':'2'}]";
    return request.get(query).then((value) {
      return DoctorResponse.fromJson(json.decode(value));
    });
  }

}

class DoctorElement
{
  DoctorElement({required this.id, required this.fio});

  String id;
  String fio;
}

class PetElement
{
  PetElement({required this.id, required this.alias});

  String id;
  String alias;
}
