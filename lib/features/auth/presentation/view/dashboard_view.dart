import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:land/features/auth/presentation/viewmodel/auth_view_model.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(authViewModelProvider);
    return Scaffold(
      body: Center(
        child: Text(userState.email),
      ),
    );
  }
}
