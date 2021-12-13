class Credentials {
  int? id;
  late String apiHost;
  late String apiToken;

  Credentials(this.id, this.apiHost, this.apiToken);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['apiHost'] = apiHost;
    map['apiToken'] = apiToken;
    return map;
  }

  Credentials.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    apiHost = map['apiHost'];
    apiToken = map['apiToken'];
  }
}
