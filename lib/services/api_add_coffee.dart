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
    File imageFile,
  ) async {
    final url = Uri.parse('$baseUrl/addcoffee/');

    var request = http.MultipartRequest('POST', url);

    // add text fields
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['category'] = category;
    request.fields['price'] = price.toString();
    request.fields['aid'] = aid;

    // add image as file
    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    // send request
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(respStr);
    } else {
      throw Exception(
          "Failed to add coffee. Status: ${response.statusCode}. Body: $respStr");
    }
  }
}
