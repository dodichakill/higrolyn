import 'package:flutter/foundation.dart';

@immutable
class RegisterUser {
  const RegisterUser({
    required this.address,
    required this.email,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.rolesId,
  });

  final String address;
  final String email;
  final String name;
  final String password;
  final String phoneNumber;
  final int rolesId;

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
      address: json['address'].toString(),
      email: json['email'].toString(),
      name: json['name'].toString(),
      password: json['password'].toString(),
      phoneNumber: json['phone_number'].toString(),
      rolesId: json['roles_id'] as int);

  Map<String, dynamic> toJson() => {
        'address': address,
        'email': email,
        'name': name,
        'password': password,
        'phone_number': phoneNumber,
        'roles_id': rolesId
      };

  RegisterUser clone() => RegisterUser(
      address: address,
      email: email,
      name: name,
      password: password,
      phoneNumber: phoneNumber,
      rolesId: rolesId);

  RegisterUser copyWith(
          {String? address,
          String? email,
          String? name,
          String? password,
          String? phoneNumber,
          int? rolesId}) =>
      RegisterUser(
        address: address ?? this.address,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        rolesId: rolesId ?? this.rolesId,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterUser &&
          address == other.address &&
          email == other.email &&
          name == other.name &&
          password == other.password &&
          phoneNumber == other.phoneNumber &&
          rolesId == other.rolesId;

  @override
  int get hashCode =>
      address.hashCode ^
      email.hashCode ^
      name.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      rolesId.hashCode;
}
