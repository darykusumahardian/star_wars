import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:star_wars/model/peoples.dart';

class PeoplesClass {
  static Future<List<dynamic>?> connectToAPI(int page) async {
    try {
      String? apiURL = "https://swapi.dev/api/people/?page=${page.toString()}";
      Uri url = Uri.parse(apiURL.toString());
      var apiResult = await http.get(url);
      var jsonObject = json.decode(apiResult.body);
      List<dynamic> data = (jsonObject as Map<String, dynamic>)['results'];
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }

  }
}