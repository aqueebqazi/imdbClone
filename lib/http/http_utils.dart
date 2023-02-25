import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

getApi(String baseUrl, headers, String unecodedPath, {dynamic parms}) async {
  Uri uri = Uri.https(baseUrl, unecodedPath, parms);
  var response = await http.get(uri, headers: headers);
  var result = await jsonDecode(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return result;
  } else {
    return null;
  }
}
