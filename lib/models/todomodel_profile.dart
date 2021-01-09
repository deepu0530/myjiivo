import 'dart:convert';

Profile profileFromMap(String str) => Profile.fromMap(json.decode(str));

String profileToMap(Profile data) => json.encode(data.toMap());

class Profile {
  Profile({
    this.status,
    this.photo,
    this.name,
    this.location,
    this.email,
    this.mobile,
  });

  bool status;
  String photo;
  String name;
  String location;
  String email;
  String mobile;

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    status: json["status"] == null ? null : json["status"],
    photo: json["photo"] == null ? null : json["photo"],
    name: json["name"] == null ? null : json["name"],
    location: json["location"] == null ? null : json["location"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "photo": photo == null ? null : photo,
    "name": name == null ? null : name,
    "location": location == null ? null : location,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
  };
}