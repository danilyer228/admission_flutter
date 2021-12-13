import 'package:vetmanager_admission_creator/db/database.dart';
import 'dart:async';

import 'Model/Db/Credentials.dart';

class Config implements BaseConfig {
  late String apiHost;
  late String apiToken ;

  Config(this.apiHost, this.apiToken);
}



class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();
  
  late BaseConfig config;

  setConfig(Config data) {
    config = data;
  }
}

abstract class BaseConfig {
  late String apiHost;
  late String apiToken;
}
