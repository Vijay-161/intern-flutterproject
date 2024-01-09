import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/core/failure/failure.dart';
import 'package:land/features/auth/data/repository/auth_repo.dart';
import 'package:land/features/auth/domain/entity/user_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  // return ref.read(authLocalRepositoryProvider);
  // Check for the internet
  // final internetStatus = ref.watch(connectivityStatusProvider);

  // if (ConnectivityStatus.isConnected == internetStatus) {
  //   // If internet is available then return remote repo
  //   return ref.watch(authRemoteRepositoryProvider);
  // } else {
  //   // If internet is not available then return local repo
  //   return ref.watch(authLocalRepositoryProvider);
  // }
  return ref.watch(authRepositoryImplProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String email, String password);
  Future<Either<Failure, String>> userInfo();
  // Future<Either<Failure, String>> uploadProfilePicture(File file);
  // Future<Either<Failure, bool>> checkUser(String username);
  // Future<Either<Failure, UserEntity>> getUser(String username);
}
