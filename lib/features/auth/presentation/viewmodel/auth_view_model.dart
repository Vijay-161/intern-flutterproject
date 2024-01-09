import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/config/router/app_route.dart';
import 'package:land/core/common/snackbar/snackbar.dart';
import 'package:land/features/auth/domain/entity/user_entity.dart';
import 'package:land/features/auth/domain/use_case/auth_use_case.dart';
import 'package:land/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(ref.read(authUseCaseProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState.initial());

  Future<void> registerUser(UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.error,
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    // bool isLogin = false;
    var data = await _authUseCase.loginUser(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        userInfo();
        // checkUser(context, username);
        // getUser(context, username);
      },
    );
  }

  Future<void> userInfo() async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.userInfo();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        // showSnackBar(
        //   message: 'Invalid Credentials',
        //   context: context,
        //   color: Colors.red,
        // );
      },
      (success) {
        state = state.copyWith(isLoading: false, email: success, error: null);
      },
    );
  }
}
