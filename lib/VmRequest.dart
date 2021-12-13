import 'package:http/http.dart' as http;

class VmRequest
{
  late String apiHost;
  late String apiToken;

  VmRequest({
    required this.apiHost,
    required this.apiToken
  });

  Future<String> get(String query) async {
    String url = apiHost + "/rest/api/" + query;
    print(apiHost + "+" + apiToken + "+" + url);
    final response = await http.get(Uri.parse(url), headers: {
      "X-USER-TOKEN": apiToken,
      "X-APP-NAME": "vmmobilka",
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

  Future<String> post(String query, Object body) async {
    String url = apiHost + "/rest/api/" + query;
    final response = await http.post(Uri.parse(url), headers: {
      "X-USER-TOKEN": apiToken,
      "X-APP-NAME": "vmmobilka",
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    }, body: body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

}