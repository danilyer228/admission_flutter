import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

AppBar VmAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text('Vetmanager', style: TextStyle(fontSize: 15),),
    actions: [
      PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Дать разработчику на кофе"),
              value: 1,
            ),
          ],
        onSelected: (result) {
          if (result == 1) {
            _launchURL();
          }
        },
      )
    ],
  );
}

_launchURL() async {
  const url = 'https://donatello.to/danilyer';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

