import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/config/router/app_route.dart';
import 'package:land/core/common/snackbar/snackbar.dart';
import 'package:land/features/auth/domain/entity/user_entity.dart';
import 'package:land/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:land/features/auth/presentation/widget/register_widget.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  var gap = const SizedBox(
    height: 10,
  );
  var _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromRGBO(151, 166, 179, 1),
        centerTitle: true,
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            gap,
            createFormFields(
                "Name", _nameController, false, Icons.person_2_outlined,
                (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Name';
              }
              return null;
            }),
            gap,
            createFormFields("Email", _emailController, false, Icons.email,
                (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Email';
              }
              return null;
            }),
            gap,
            createFormFields("Phone", _phoneController, false, Icons.phone,
                (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Fullname';
              }
              return null;
            }),
            gap,
            // createFormFields(
            //     "Password", _passwordController, true, Icons.password_outlined,
            //     (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Enter Password';
            //   }
            //   return null;
            // }),
            TextFormField(
              controller: _passwordController,
              obscureText: _isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password),
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Password';
                }
                return null;
              },
            ),
            gap,
            createFormFields("Confirm Password", _confirmPasswordController,
                true, Icons.password_outlined, (value) {
              if (value == null || value.isEmpty) {
                return 'Re-enter Password';
              }
              return null;
            }),
            gap,
            createFormFields("Pin", _pinController, true, Icons.pin, (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Pin';
              }
              return null;
            }),
            gap,
            gap,
            SizedBox(
              width: width / 2,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 104, 134, 161), // Change the color here
                ),
                onPressed: () {
                  if (key.currentState!.validate()) {
                    var user = UserEntity(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      password: _passwordController.text,
                      pin: _pinController.text,
                      confirmPassword: _confirmPasswordController.text,
                    );

                    ref.read(authViewModelProvider.notifier).registerUser(user);

                    if (authState.error != null) {
                      showSnackBar(
                        message: authState.error.toString(),
                        context: context,
                        color: Colors.red,
                      );
                    } else {
                      showSnackBar(
                          message: 'Registered successfully',
                          context: context,
                          color: Colors.green);
                    }
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            gap,
            RichText(
              text: TextSpan(
                  text: 'Already Registered!',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                        text: '  Sign in',
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, AppRoute.loginRoute);
                          }),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
