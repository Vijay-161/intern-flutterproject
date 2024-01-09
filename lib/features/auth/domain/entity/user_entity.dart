import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String pin;
  final String confirmPassword;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.pin,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        password,
        pin,
        confirmPassword,
      ];
}
