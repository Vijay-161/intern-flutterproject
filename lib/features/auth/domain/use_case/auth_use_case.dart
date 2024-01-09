import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/core/failure/failure.dart';
import 'package:land/features/auth/domain/entity/user_entity.dart';
import 'package:land/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider(
  (ref) => AuthUseCase(
    ref.read(authRepositoryProvider),
  ),
);

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    return await _authRepository.registerUser(user);
  }

  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    return await _authRepository.loginUser(email, password);
  }

  Future<Either<Failure, String>> userInfo() async {
    return await _authRepository.userInfo();
  }
}