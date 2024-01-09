import 'package:land/features/auth/domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final UserEntity? currentUser;
  final String email;

  AuthState({
    required this.isLoading,
    this.error,
    this.currentUser,
    required this.email,
  });

  factory AuthState.initial() {
    return AuthState(
        isLoading: false, error: null, currentUser: null, email: 'dkfjldd');
  }

  AuthState copyWith(
      {bool? isLoading,
      String? error,
      UserEntity? currentUser,
      String? email}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentUser: currentUser ?? this.currentUser,
      email: email ?? this.email,
    );
  }

  @override
  String toString() =>
      'AuthState(isLoading: $isLoading, error: $error,  currentUser: $currentUser)';
}
