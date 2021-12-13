import 'package:flutter/material.dart';
import 'package:vetmanager_admission_creator/Model/Rest/Admission.dart';
import 'package:vetmanager_admission_creator/VmAppBar.dart';

class CompleteScreen extends StatefulWidget {
  @override
  _CompleteScreenState createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  late Future<AdmissionResponse> futureAdmission;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    futureAdmission = settings.arguments as Future<AdmissionResponse>;

    return Scaffold(
        appBar: VmAppBar(),
        body: FutureBuilder<AdmissionResponse>(
            future: futureAdmission,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.success) {
                  return Center(
                      child: Container(
                        child: Text("Вы успешно записались на прием"),
                      )
                  );
                } else {
                  return Center(
                      child: Container(
                        child: Text(snapshot.data!.message),
                      )
                  );
                }
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Что-то пошло не так... Возможно вы пытаетесь записаться уже назначенное время",),
                    )
                );
              }
              return Center(child: CircularProgressIndicator());
            }
        )
    );
  }
}

