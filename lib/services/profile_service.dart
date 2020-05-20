import 'dart:convert';
import 'package:musicomapp/models/profile.dart';
import 'package:musicomapp/services/backend_connection.dart';

class ProfileService {

  static Future<List<UserProfile>> fetchUserProfiles({Map<String, String> filters}) async {
    var conn = BackendService.getInstance();
    List<UserProfile> userProfiles;
    var response = await conn.get('/userProfiles', params: filters);
    if (response.statusCode == 200){
      userProfiles = UserProfile.listFromJson(jsonDecode(response.body));
    }

    return userProfiles;
  }

  static Future<UserProfile> fetchUserProfile(String id) async {
    var conn = BackendService.getInstance();
    UserProfile userProfile;
    var response = await conn.get('/userProfiles/'+id);
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
      profile = Profile.fromJson(jsonDecode(response.body));
    }
    return profile;
  }

  static Future<String> updateProfile(String profileId, Map<String, String> data) async {
    var conn = BackendService.getInstance();
    var response = await conn.put('/profile/$profileId', data);
    if (response.statusCode == 200) {
      return "Perfil actualizado correctamente";
    }
    return "Error al actualizar perfil";
  }

}