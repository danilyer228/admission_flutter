import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'Model/Db/Credentials.dart';
import 'db/database.dart';
import 'pages/CompleteScreen.dart';
import 'pages/AdmissionScreen.dart';
import 'pages/EnterScreen.dart';
import 'pages/InfoScreen.dart';
import 'package:flutter/material.dart';

import 'creds.dart';


void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: {
      '/enter': (context) => EnterScreen(),
      '/info': (context) => InfoScreen(),
      '/admission': (context) => AdmissionScreen(),
      '/complete': (context) => CompleteScreen()
    },
    home: EnterScreen(),
  ));
}



