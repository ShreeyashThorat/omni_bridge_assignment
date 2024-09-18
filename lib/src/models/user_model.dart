class UserModel {
  String? uid;
  String? email;
  String? password;
  String? name;
  String? contact;
  String? profile;

  UserModel(
      {this.uid,
      this.email,
      this.password,
      this.name,
      this.contact,
      this.profile});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    contact = json['contact'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['contact'] = contact;
    data['profile'] = profile;
    return data;
  }
}
