

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {

  final String id;
  final String name;
  final String lastName;
  final String email;
  final String profileId;
  final String token;

  static User _instance;

  User({this.id, this.name, this.lastName, this.email, this.profileId, this.token}) {
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
          name: values['name'],
          lastName: values['lastName'],
          email: values['email'],
          profileId: values['profileId'],
          token: values['token']
      );
    }
  }

  saveData() async {
    /*
     */
    final storage = new FlutterSecureStorage();

    await storage.write(key: 'id', value: id);
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'lastName', value: lastName);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'profileId', value: profileId);
    await storage.write(key: 'token', value: token);
  }

}
