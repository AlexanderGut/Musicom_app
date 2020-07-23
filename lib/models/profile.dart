import 'package:musicomapp/models/comment.dart';

class Profile {

    final String id;
    final String name;
    final String lastName;
    final String status;
    final String bio;
    final String imageUrl;
    final String principalInstrument;
    final List<String> secondaryInstruments;
    final List<String> styles;
    final String youtubeLink; // evaluar
    final String email;
    final List<Comment> comments;

    Profile({
      this.id,
      this.name,
      this.lastName,
      this.status,
      this.bio,
      this.imageUrl,
      this.youtubeLink,
      this.principalInstrument,
      this.secondaryInstruments,
      this.styles,
      this.email,
      this.comments
    });


  static Profile fromJson(Map<String, dynamic> profile) {

    var cJsonList = profile['comments'] as List;

    return Profile(
      id: profile['id'],
      name: profile['name'],
      lastName: profile['last_name'],
      status: profile['status'],
      bio: profile['bio'],
      imageUrl: profile['image_url'],
      youtubeLink: profile['youtube_link'],
      principalInstrument: profile['principal_instrument'],
      secondaryInstruments: List<String>.from(profile['secondary_instrument']),
      styles: List<String>.from(profile['music_styles']),
      email: profile["email"],
      comments: Comment.listFromJson(cJsonList)
    );
  }

}

class UserProfile {
  /*
  Esta clase es una verisón resumida del perfil de los usuarios, con el fin
  de obtener solo los datos necesarios en el listado de usuarios, comentarios
  y anuncios.
  */
  final String profileId;
  final String name;
  final String imageUrl;
  final String status;
  final String instrument;

  UserProfile({
    this.profileId,
    this.name,
    this.imageUrl,
    this.status,
    this.instrument
  });

  factory UserProfile.fromJson(Map<String, dynamic> userProfile) {
    return UserProfile(
      profileId: userProfile['id'],
      name: userProfile['name'],
      imageUrl: userProfile['min_image_url'],
      status: userProfile['status'],
      instrument: userProfile['instrument']
    );
  }
  
  static List<UserProfile> listFromJson(List<dynamic> upList) {
    return upList.map((u) => UserProfile.fromJson(u)).toList();
  }
}