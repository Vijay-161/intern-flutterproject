import 'package:json_annotation/json_annotation.dart';
import 'package:land/features/auth/domain/entity/user_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String email;
  @JsonKey(name: 'phone_number')
  final String phone;
  final String password;
  final String pin;
  @JsonKey(name: 'password_confirmation')
  final String confirmPassword;

  AuthApiModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.pin,
    required this.confirmPassword,
  });

  AuthApiModel.empty()
      : this(
          id: '',
          name: '',
          email: '',
          phone: '',
          password: '',
          pin: '',
          confirmPassword: '',
        );

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        password: password,
        pin: pin,
        confirmPassword: confirmPassword,
      );

  AuthApiModel toApiModel(UserEntity entity) => AuthApiModel(
        id: id ?? '',
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        password: entity.password,
        pin: entity.pin,
        confirmPassword: entity.confirmPassword,
      );

  List<AuthApiModel> toApiModelList(List<UserEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<UserEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //From Json
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  @override
  String toString() {
    return 'id: $id, name: $name, email: $email, phone: $phone';
  }
}
