import 'dart:convert';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/services/backend_connection.dart';

class ProfileService {

  static Future<List<UserProfile>> fetchUserProfiles({Map<String, dynamic> filters}) async {
    var conn = BackendService.getInstance();
    List<UserProfile> userProfiles;
    var response = await conn.post('/profiles', filters);
    if (response.statusCode == 200){
      var body = jsonDecode(response.body);
      var list = body['users'] as List;
      print(body);
      userProfiles = UserProfile.listFromJson(list);
    }

    return userProfiles;
  }

  static Future<UserProfile> fetchUserProfile(String id) async {
    var conn = BackendService.getInstance();
    UserProfile userProfile;
    var response = await conn.get('/userProfiles/'+id);
    print(id);
    if (response.statusCode == 200) {
      userProfile = UserProfile.fromJson(jsonDecode(response.body));
    }
    return userProfile;
  }

  static Future<Profile> fetchProfile(String id) async {
    var conn = BackendService.getInstance();
    Profile profile;
    var response = await conn.get('/profiles/'+id);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      profile = Profile.fromJson(jsonDecode(response.body));
    }
    return profile;
  }

  static Future<Profile> updateProfile(String profileId, Map<String, dynamic> data) async {
    var conn = BackendService.getInstance();
    var response = await conn.put('/profiles/$profileId', data);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

}