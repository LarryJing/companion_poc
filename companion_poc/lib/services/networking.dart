import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:companion_poc/constants/constants.dart' as constants;

class Network {
  var token;
  Network(this.token);

  Future getSpaces(var url) async {
    http.Response response = await http.get(Uri.parse(url), headers: {
      'x-api-key': '${constants.apiKey}',
      'Authorization': 'Bearer $token'
    });

    print(response);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future bookSpace(var url, String displayName, String workspaceEmail) async {
    http.Response response = await http.post(
        Uri.parse(
            '$url?displayName=$displayName&workspaceEmail=$workspaceEmail'),
        headers: {
          'x-api-key': '${constants.apiKey}',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
