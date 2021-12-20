import 'dart:convert';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetmanager_admission_creator/Model/Db/Credentials.dart';
import 'package:vetmanager_admission_creator/Model/Rest/Creds.dart';
import 'package:vetmanager_admission_creator/Model/Rest/PhoneNumber.dart';
import 'package:vetmanager_admission_creator/VmAppBar.dart';
import 'package:vetmanager_admission_creator/db/database.dart';
import 'package:http/http.dart' as http;

import '../VmRequest.dart';
import '../creds.dart';


class EnterScreen extends StatefulWidget {
  @override
  _EnterScreenState createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  final _phoneFocus = FocusNode();
  final _phoneController = TextEditingController();
  String _referrerDetails = '';
  late String phoneNumber;

  @override
  void initState() {
    initReferrerDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VmAppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  focusNode: _phoneFocus,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Номер телефона *',
                    hintText: 'Кто вы?',
                    helperText: 'Формат номера: (XXX)XXX-XXXX',
                    prefixIcon: Icon(Icons.call),
                    suffixIcon: GestureDetector(
                      onLongPress: () {
                        _phoneController.clear();
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                        allow: true),
                  ],
                  validator: (value) => _validatePhoneNumber(value!)
                      ? null
                      : 'Phone number must be entered as (###)###-####',
                  onSaved: (value) => phoneNumber = value!,
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  child: Text('Войти'),
                  onPressed: (){
                    Navigator.pushNamed(
                        context,
                        '/info',
                        arguments: PhoneNumber(_phoneController.text)
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _phoneExp.hasMatch(input);
  }

  Future<void> initReferrerDetails() async {
    String referrerToken;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ReferrerDetails? referrerDetails = await AndroidPlayInstallReferrer.installReferrer;
      referrerToken = referrerDetails!.installReferrer.toString();
      print("AAAAA " + referrerToken);
      getCreds(referrerToken).then((value) async {
        Creds creds = Creds.fromJson(json.decode(value));
        Credentials credentials = Credentials(1, creds.data.url, creds.data.apiToken);
        Config config = Config(creds.data.url, creds.data.apiToken);
        Environment().setConfig(config);
        List<Credentials> result = await DBProvider.db.getCredentials();
        if(result.isEmpty) {
          DBProvider.db.insertCredentials(credentials);
        } else {
          DBProvider.db.updateCredentials(credentials);
        }
      });
    } catch (e) {
      referrerToken = 'Failed to get referrer details: $e';
    }
    print(referrerToken);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _referrerDetails = referrerToken;
    });
  }

  Future<String> getCreds(String referrerToken) async {
    String url = "https://vmmobilka.herokuapp.com/creds.php?token=" + referrerToken;
    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }



}

