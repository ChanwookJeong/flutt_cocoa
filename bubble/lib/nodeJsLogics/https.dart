import 'package:bubble/model/sailroom.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Https {
  final url = 'http://10.0.2.2:3000';
  final sailrooms = 'saleroom/';
  final users = 'users/';
  final headers = {'Content-Type': 'application/json'};
  final encoding = Encoding.getByName('utf-8');

  Https();

  Future<List<Sailroom>> makeGetSaleroomsRequest() async {
    var temp = Uri.parse('$url' + "/" + '$sailrooms');
    http.Response response = await http.get(temp);
    List<Sailroom> result = List<Sailroom>.from(
        jsonDecode(response.body).map((json) => Sailroom.fromJson(json)));
    result.sort((a, b) => a.subjects.compareTo(b.subjects));
    return result;
  }

  makeUserPostRequest(Sailroom sailroom) async {
    String body = json.encode(sailroom.toJason());
    http.Response response = await http.post(
        Uri.parse('$url$sailrooms${sailroom.room_root_id}'),
        headers: headers,
        body: body,
        encoding: encoding);
    print(response.body);
    print('status code= ${response.statusCode}');
  }

  makeUserPutRequest(Sailroom sailroom) async {
    String body = json.encode(sailroom.toJason());
    http.Response response = await http.put(
        Uri.parse('$url$users${sailroom.room_root_id}'),
        headers: headers,
        body: body,
        encoding: encoding);
    print(response.body);
    print('status code= ${response.statusCode}');
  }

  makeUserDeleteRequest(Sailroom sailroom) async {
    http.Response response = await http.delete(
        Uri.parse('$url$users${sailroom.room_root_id}'),
        headers: headers);
    print(response.body);
    print('status code= ${response.statusCode}');
  }
}
