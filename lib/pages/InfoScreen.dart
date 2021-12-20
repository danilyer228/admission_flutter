import 'dart:convert';
import 'dart:ffi';
import 'package:vetmanager_admission_creator/Model/Rest/PhoneNumber.dart';
import 'package:vetmanager_admission_creator/VmBottomAppBar.dart';
import 'package:vetmanager_admission_creator/VmRequest.dart';

import '../Model/Rest/Client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../creds.dart';


class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late PhoneNumber phoneNumber;
  late Future<ClientResponse> clientResponse;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    phoneNumber = settings.arguments as PhoneNumber;
    clientResponse = getClientData(phoneNumber.asString());
    return Scaffold(
        bottomNavigationBar: VmBottomAppBar().render(context),
        appBar: AppBar(
            centerTitle: true,
            title: FutureBuilder<ClientResponse>(
                future: clientResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.data.client.first.firstName,
                      style: TextStyle(fontSize: 15),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ' + snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                })
        ),
        body: FutureBuilder<ClientResponse>(
            future: clientResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Center(
                        child: SafeArea(
                          child: Padding(
                              padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _clientFIO(snapshot),
                                Divider(),
                                _phoneNumber(snapshot),
                                Divider(),
                                _balance(snapshot),
                                Divider(),
                                _petsList(snapshot),
                              ],
                            ),
                          )
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/admission',
                                  arguments: snapshot.data!.data.client.first
                              );
                            },
                            child: Text("Записаться на прием", style: TextStyle(fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ' + snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }
        )
    );
  }

  Column _clientFIO(AsyncSnapshot<ClientResponse> snapshot)
  {
    return Column(
      children: [
        Row(
          children: [
            Text("ФИО:"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(" " + snapshot.data!.data.client.first.lastName
                + " " + snapshot.data!.data.client.first.firstName
                + " " + snapshot.data!.data.client.first.middleName,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ],
    );
  }

  Column _phoneNumber(AsyncSnapshot<ClientResponse> snapshot)
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Номер телефона:"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(" " + snapshot.data!.data.client.first.cellPhone,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ],
    );
  }

  Column _balance(AsyncSnapshot<ClientResponse> snapshot)
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Баланс:"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(" " + snapshot.data!.data.client.first.balance,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ],
    );
  }

  Column _petsList(AsyncSnapshot<ClientResponse> snapshot)
  {
    return Column(
      children: [
        Row(
          children: [
            Text("Список питомцев:"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
              List.generate(snapshot.data!.data.client.first.pets.length, (int index) {
                int petIndex = snapshot.data!.data.client.first.pets.length - 1;
                Pet currentPet = snapshot.data!.data.client.first.pets[petIndex];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(" " + currentPet.alias
                      + ", " + currentPet.petTypeTitle
                      + ", " + currentPet.sex
                      + ", " + currentPet.breed,
                        style: TextStyle(fontSize: 24))
                  ],
                );
              })
            ,
          ),
        ),
      ],
    );
  }




  Future<ClientResponse> getClientData(String searchQuery) async {
    VmRequest request = new VmRequest(
      apiHost: Environment().config.apiHost,
      apiToken: Environment().config.apiToken
    );
    String query = "client/ClientsSearchData?search_query="+ searchQuery;
    return request.get(query).then((value) {
      return ClientResponse.fromJson(json.decode(value));
    });
  }
  
}
