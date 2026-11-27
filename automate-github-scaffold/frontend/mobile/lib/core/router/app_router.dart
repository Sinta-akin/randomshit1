import 'package:flutter/material.dart';
import 'package:automate_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:automate_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:automate_mobile/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:automate_mobile/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:automate_mobile/features/auth/presentation/screens/role_selection_screen.dart';
import 'package:automate_mobile/features/auth/presentation/screens/welcome_back_screen.dart';
import 'package:automate_mobile/features/landing/presentation/screens/landing_screen.dart';
import 'package:automate_mobile/core/constants/app_constants.dart';

/// Application router using named routes.
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.landing:
        return MaterialPageRoute(
          builder: (_) => const LandingScreen(),
          settings: settings,
        );
      case AppConstants.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppConstants.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case AppConstants.emailVerification:
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationScreen(),
          settings: settings,
        );
      case AppConstants.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );
      case AppConstants.roleSelection:
        return MaterialPageRoute(
          builder: (_) => const RoleSelectionScreen(),
          settings: settings,
        );
      case AppConstants.welcomeBack:
        return MaterialPageRoute(
          builder: (_) => const WelcomeBackScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LandingScreen(),
          settings: settings,
        );
    }
  }
}
