class Ticket {
  int? id;
  String? invoice;
  int? roomId;
  int? categoryId;
  int? userId;
  String? phone;
  String? checkin;
  String? checkout;
  int? night;
  String? price;
  String? tax;
  String? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  Room? room;
  User? user;

  Ticket(
      {this.id,
      this.invoice,
      this.roomId,
      this.categoryId,
      this.userId,
      this.phone,
      this.checkin,
      this.checkout,
      this.night,
      this.price,
      this.tax,
      this.total,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.room,
      this.user});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice = json['invoice'];
    roomId = json['room_id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    phone = json['phone'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    night = json['night'];
    price = json['price'];
    tax = json['tax'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice'] = this.invoice;
    data['room_id'] = this.roomId;
    data['category_id'] = this.categoryId;
    data['user_id'] = this.userId;
    data['phone'] = this.phone;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['night'] = this.night;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Room {
  int? id;
  String? image;
  String? title;
  String? description;
  int? categoryId;
  String? status;
  int? count;
  String? createdAt;
  String? updatedAt;
  Category? category;
  List<Bookmar>? bookmar;

  Room(
      {this.id,
      this.image,
      this.title,
      this.description,
      this.categoryId,
      this.status,
      this.count,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.bookmar});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    categoryId = json['category_id'];
    status = json['status'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null ? new Category.fromJson(json['category']) : null;
    if (json['bookmar'] != null) {
      bookmar = <Bookmar>[];
      json['bookmar'].forEach((v) {
        bookmar!.add(new Bookmar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['count'] = this.count;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.bookmar != null) {
      data['bookmar'] = this.bookmar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? price;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.title, this.price, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Bookmar {
  int? id;
  int? userId;
  int? roomId;
  String? createdAt;
  String? updatedAt;

  Bookmar({this.id, this.userId, this.roomId, this.createdAt, this.updatedAt});

  Bookmar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['room_id'] = this.roomId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Profiles? profiles;

  User({this.id, this.name, this.email, this.emailVerifiedAt, this.createdAt, this.updatedAt, this.profiles});

  User.fromJson(Map<String, dynamic> json) {
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
  Null? nik;
  Null? address;
  Null? gender;
  Null? job;
  Null? phone;
  String? createdAt;
  String? updatedAt;

  Profiles(
      {this.id,
      this.userId,
      this.image,
      this.nik,
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
    nik = json['nik'];
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
    data['nik'] = this.nik;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['job'] = this.job;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
