import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

getApi(String baseUrl, headers, String unecodedPath,
    {Map<String, dynamic>? parms}) async {
  try {
    Uri uri = Uri.https(baseUrl, unecodedPath, parms);
    var response = await http.get(uri, headers: headers);
    var result = await jsonDecode(response.body);
    log("GetApiResponse" + result.toString());
    switch (response.statusCode) {
      case 200:
        return result;
        break;
      case 404:
        return null;
      case 500:
        return null;
      default:
    }
  } catch (e) {
    return null;
  }
}
