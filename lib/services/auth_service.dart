import 'dart:convert';
import 'package:http/http.dart';
import 'package:musicomapp/models/user.dart';

class AuthService {

  static String _authUrl = "http://192.168.0.10:5000/v1/auth";
  static final headers = <String, String> {
  'Content-Type': 'application/json; charset=UTF-8'
  };
  static Future<Response> login(String email, String password) async {
    var response = await post(
      "$_authUrl/login",
      headers: headers,
      body: jsonEncode(<String, String> {
        'email': email,
        'password': password
      })
    );
    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      await User(
        id: body['id'],
        email: email,
        name: body['first_name'],
        lastName: body['last_name'],
        profileId: body['profile_id'],
        imgUrl: body['img_url'],
        token: body['token']
      ).saveData();
    }
    return response;
  }

  static Future<Response> signup(String email, String name, String lastName, String password) async {
    var response = await post(
      "$_authUrl/signup",
      headers: headers,
      body: jsonEncode(<String, String> {
        'email': email,
        'first_name': name,
        'last_name': lastName,
        'password': password
      })
    );
    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      print(body);
      await User(
          id: body['id'],
          email: email,
          name: name,
          lastName: lastName,
          profileId: body['profile_id'],
          token: body['token']
      ).saveData();
    }
    return response;
  }
}