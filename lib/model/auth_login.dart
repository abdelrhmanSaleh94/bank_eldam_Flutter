class Login {
  int status;
  String msg;
  Data data;

  Login({this.status, this.msg, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String apiToken;
  Client client;

  Data({this.apiToken, this.client});

  Data.fromJson(Map<String, dynamic> json) {
    apiToken = json['api_token'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_token'] = this.apiToken;
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    return data;
  }
}

class Client {
  int id;
  String createdAt;
  String updatedAt;
  String name;
  String email;
  String birthDate;
  String cityId;
  String phone;
  String donationLastDate;
  String bloodTypeId;
  String isActive;
  String pinCode;
  Null rememberToken;
  bool canDonate;
  City city;
  BloodType bloodType;

  Client(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.email,
      this.birthDate,
      this.cityId,
      this.phone,
      this.donationLastDate,
      this.bloodTypeId,
      this.isActive,
      this.pinCode,
      this.rememberToken,
      this.canDonate,
      this.city,
      this.bloodType});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    email = json['email'];
    birthDate = json['birth_date'];
    cityId = json['city_id'];
    phone = json['phone'];
    donationLastDate = json['donation_last_date'];
    bloodTypeId = json['blood_type_id'];
    isActive = json['is_active'];
    pinCode = json['pin_code'];
    rememberToken = json['remember_token'];
    canDonate = json['can_donate'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    bloodType = json['blood_type'] != null
        ? new BloodType.fromJson(json['blood_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['birth_date'] = this.birthDate;
    data['city_id'] = this.cityId;
    data['phone'] = this.phone;
    data['donation_last_date'] = this.donationLastDate;
    data['blood_type_id'] = this.bloodTypeId;
    data['is_active'] = this.isActive;
    data['pin_code'] = this.pinCode;
    data['remember_token'] = this.rememberToken;
    data['can_donate'] = this.canDonate;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.bloodType != null) {
      data['blood_type'] = this.bloodType.toJson();
    }
    return data;
  }
}

class City {
  int id;
  Null createdAt;
  Null updatedAt;
  String name;
  String governorateId;
  Governorate governorate;

  City(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.governorateId,
      this.governorate});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    governorateId = json['governorate_id'];
    governorate = json['governorate'] != null
        ? new Governorate.fromJson(json['governorate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['governorate_id'] = this.governorateId;
    if (this.governorate != null) {
      data['governorate'] = this.governorate.toJson();
    }
    return data;
  }
}

class Governorate {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;

  Governorate({this.id, this.createdAt, this.updatedAt, this.name});

  Governorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}

class BloodType {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  BloodType.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}
