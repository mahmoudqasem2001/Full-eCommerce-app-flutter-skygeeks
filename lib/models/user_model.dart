import 'dart:convert';

class LinkedAccount {
  final String provider;
  final String imgLink;

  LinkedAccount({required this.provider, required this.imgLink});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'provider': provider,
      'imgLink': imgLink,
    };
  }

  factory LinkedAccount.fromMap(Map<String, dynamic> map) {
    return LinkedAccount(
      provider: map['provider'] as String,
      imgLink: map['imgLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkedAccount.fromJson(String source) =>
      LinkedAccount.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserModel {
  final String name;
  final String email;
  final String imgUrl;
  UserModel({
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'imgUrl': imgUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      imgUrl: map['imgUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

UserModel dummyUser = UserModel(
  name: "Mahmoud Qasem",
  email: "mahmoudqasem543@gmail.com",
  imgUrl:
      "https://media.licdn.com/dms/image/D4D03AQHvs3QYTfPVnQ/profile-displayphoto-shrink_800_800/0/1691757183421?e=1715212800&v=beta&t=1EMTZRqlJtdi9jWoU6s9zQd_cEzhRHJp9f_l73p9ixE",
);
