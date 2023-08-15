class UserData {
  String? name;
  String? gender;
  String? phoneNumber;
  String? dateOfBirth;
  String? uID;

  UserData({
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.uID
  });

  UserData.fromJson(Map<String, dynamic>? json)
      : name = json?['name'],
        gender = json?['gender'],
        phoneNumber = json?['phoneNumber'],
        dateOfBirth = json?['dateOfBirth'],
        uID = json?['uID'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'gender': gender,
    'phoneNumber': phoneNumber,
    'dateOfBirth': dateOfBirth,
    'uID': uID,
  };

  @override
  String toString() {
    return "uid: $uID, name: $name, gender: $gender, phone number: $phoneNumber, date of birth: $dateOfBirth";
  }
}