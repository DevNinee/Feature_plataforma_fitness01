class RegisterRequest {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? userType;
  String? phoneNumber;
  String? gender;
  UserProfile? userProfile;

  RegisterRequest(
      {this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.password,
        this.userType,
        this.phoneNumber,
        this.gender,
        this.userProfile});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    userType = json['user_type'];
    phoneNumber = json['phone_number'];
    gender = json['gender'];
    userProfile = json['user_profile'] != null
        ? UserProfile.fromJson(json['user_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['user_type'] = userType;
    data['phone_number'] = phoneNumber;
    data['gender'] = gender;
    if (userProfile != null) {
      data['user_profile'] = userProfile!.toJson();
    }
    return data;
  }
}

class UserProfile {
  int? age;
  String? weight;
  String? weightUnit;
  String? height;
  String? heightUnit;
  String? address;

  UserProfile(
      {this.age,
        this.weight,
        this.weightUnit,
        this.height,
        this.heightUnit,
        this.address});

  UserProfile.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    height = json['height'];
    heightUnit = json['height_unit'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['weight'] = weight;
    data['weight_unit'] = weightUnit;
    data['height'] = height;
    data['height_unit'] = heightUnit;
    data['address'] = address;
    return data;
  }
}
