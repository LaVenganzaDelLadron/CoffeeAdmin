import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiAddCoffee {
  static const String baseUrl = "http://192.168.1.14:8080";

  static Future<Map<String, dynamic>> addCoffee(
  String name,
  String description,
  String category,
  double price,
  String aid,
  String imagePath,
) async {
  final url = Uri.parse('$baseUrl/addcoffee/');

  var request = http.MultipartRequest('POST', url);

  request.fields['name'] = name;
  request.fields['description'] = description;
  request.fields['category'] = category;
  request.fields['price'] = price.toString();
  request.fields['aid'] = aid;

  request.files.add(await http.MultipartFile.fromPath('file', imagePath));

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
      'Failed to add coffee. Status: ${response.statusCode}. Body: ${response.body}',
    );
  }
}

}
