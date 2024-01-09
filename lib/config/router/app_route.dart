import 'package:land/features/auth/presentation/view/dashboard_view.dart';
import 'package:land/features/auth/presentation/view/login_view.dart';
import 'package:land/features/auth/presentation/view/register_view.dart';

import '../../features/auth/presentation/view/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String registerRoute = '/register';
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String profileRoute = '/profile';

  // static const String batchStudentRoute = '/batchStudent';
  // static const String googleMapRoute = '/googleMap';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      registerRoute: (context) => const RegisterView(),
      loginRoute: (context) => const LoginView(),
      dashboardRoute: (context) => const DashboardView(),
      // randomRoute: (context) => const RandomQuotes(),
      // authorInfoRoute: (context) => const AuthorInfo(),
      // batchStudentRoute: (context) => const BatchStudentView(null),
      // googleMapRoute: (context) => const GoogleMapView(),
    };
  }
}
