class UserData {
  String? name;
  String? gender;
  String? phoneNumber;
  String? dateOfBirth;

  UserData({
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gender = json['gender'],
        phoneNumber = json['phoneNumber'],
        dateOfBirth = json['dateOfBirth'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'gender': gender,
    'phoneNumber': phoneNumber,
    'dateOfBirth': dateOfBirth,
  };

  @override
  String toString() {
    return "name: $name, phone number: $phoneNumber";
  }
}