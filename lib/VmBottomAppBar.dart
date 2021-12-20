import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class VmBottomAppBar extends Widget
{
  factory VmBottomAppBar() {
    return _singleton;
  }

  VmBottomAppBar._internal();

  int selectedIndex = 1;
  static final VmBottomAppBar _singleton = VmBottomAppBar._internal();

  BottomNavigationBar render(context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: this.selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time_outlined),
          label: "Приемы",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: "Профиль",
        ),
      ],
      onTap: (index){
        context.setState(() {
          selectedIndex = index;
        });
        switch(index){
          case 0:
            Navigator.pushNamed(context, "/info");
            break;
          case 1:
            Navigator.pushNamed(context, "/admission");
            break;
        }
      },
    );
  }

}

