import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/core/failure/failure.dart';
import 'package:land/features/auth/data/data_source/auth_data_source.dart';
import 'package:land/features/auth/domain/entity/user_entity.dart';
import 'package:land/features/auth/domain/repository/auth_repository.dart';

final authRepositoryImplProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(
    ref.read(authDataSourceProvider),
  );
});

class AuthRepository implements IAuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepository(this._authDataSource);

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _authDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, String>> userInfo() {
    return _authDataSource.userInfo();
  }
}
