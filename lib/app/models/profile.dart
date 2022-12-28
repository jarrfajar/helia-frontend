class Profile {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Profiles? profiles;

  Profile({this.id, this.name, this.email, this.emailVerifiedAt, this.createdAt, this.updatedAt, this.profiles});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profiles = json['profiles'] != null ? new Profiles.fromJson(json['profiles']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.toJson();
    }
    return data;
  }
}

class Profiles {
  int? id;
  int? userId;
  String? image;
  String? birthday;
  String? address;
  String? gender;
  String? job;
  String? phone;
  String? createdAt;
  String? updatedAt;

  Profiles(
      {this.id,
      this.userId,
      this.image,
      this.birthday,
      this.address,
      this.gender,
      this.job,
      this.phone,
      this.createdAt,
      this.updatedAt});

  Profiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    birthday = json['birthday'];
    address = json['address'];
    gender = json['gender'];
    job = json['job'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['birthday'] = this.birthday;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['job'] = this.job;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
