import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/config/constants/api_endpoints.dart';
import 'package:land/core/failure/failure.dart';
import 'package:land/core/network/http_service.dart';

import '../../domain/entity/user_entity.dart';

final authDataSourceProvider = Provider(
  (ref) => AuthDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

String? token;

class AuthDataSource {
  final Dio dio;

  AuthDataSource({required this.dio});

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "name": user.name,
          "email": user.email,
          "phone_number": user.phone,
          "password": user.password,
          "pin": user.pin,
          "password_confirmation": user.confirmPassword,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        token = response.data["token"];
        // await userSharedPrefs.setUserToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, String>> userInfo() async {
    try {
      var response = await dio.get(
        ApiEndpoints.userInfo,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        // var user =
        //     AuthApiModel.fromJson(response.data.data['email']).toString();
        var user = response.data['data']['email'].toString();
        return Right(user);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
