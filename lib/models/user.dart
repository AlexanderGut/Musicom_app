

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {

  final String id;
  final String username;
  final String email;
  final String token;

  static User _instance;

  User({this.id, this.username, this.email, this.token}) {
    _instance = this;
  }

  static User getInstance() {
    if (_instance == null) {
      getData();
    }
    return _instance;
  }

  static getData() async {
    /*
     */
    final storage = new FlutterSecureStorage();

    Map<String, String> values = await storage.readAll();
    if (values != null){
      _instance = User(
          id: values['id'],
          username: values['username'],
          email: values['email'],
          token: values['token']
      );
    }
  }

  saveData() async {
    /*
     */
    final storage = new FlutterSecureStorage();

    await storage.write(key: 'id', value: id);
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'token', value: token);
  }

}
