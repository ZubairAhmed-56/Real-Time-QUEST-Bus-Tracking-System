class UserModel {
  final String uId;
  final String username;
  final String email;
  final String phone;
  final String userImage;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final String street;
  final bool isDriver;
  final bool isActive;
  final dynamic createdOn;

  UserModel(
      {required this.uId,
      required this.username,
      required this.email,
      required this.phone,
      required this.userImage,
      required this.userDeviceToken,
      required this.country,
      required this.userAddress,
      required this.street,
      required this.isDriver,
      required this.isActive,
      required this.createdOn});

  //serialize the usermodel instance to a Json map

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'username': username,
      'email': email,
      'phone': phone,
      'userImage': userImage,
      'userDeviceToken': userDeviceToken,
      'country': country,
      'userAddress': userAddress,
      'street': street,
      'isDriver': isDriver,
      'isActive': isActive,
      'createdOn': createdOn,
    };
  }

// create a usermodel instance from a JSON map
  factory UserModel.formMap(Map<String, dynamic> json) {
    return UserModel(
        uId: json['uID'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        userImage: json['userImage'],
        userDeviceToken: json['userDeviceToken'],
        country: json['country'],
        userAddress: json['userAddress'],
        street: json['street'],
        isDriver: json['isDriver'],
        isActive: json['isActive'],
        createdOn: json['createdOn']);
  }
}
