/// Centralized app constants extracted from the Figma design and requirements.
abstract class AppConstants {
  // MARK: - Navigation routes

  static const String landing = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String emailVerification = '/email-verification';
  static const String forgotPassword = '/forgot-password';
  static const String roleSelection = '/role-selection';
  static const String welcomeBack = '/welcome-back';
  static const String preferences = '/preferences';
  static const String verification = '/verification';

  // MARK: - Asset paths

  static const String logo = 'assets/images/logo.png';
  static const String landingHeroImage = 'assets/images/landing_hero.png';
  static const String serviceHeroImage = 'assets/images/service_hero.png';
  static const String customerIcon = 'assets/icons/customer.png';
  static const String vehicleOwnerIcon = 'assets/icons/vehicle_owner.png';
  static const String workshopIcon = 'assets/icons/workshop.png';

  // MARK: - Validation messages

  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordMismatch = 'Passwords do not match';

  // MARK: - Simulated credentials

  static const String simulatedEmail = 'arjun.kumar@example.com';
  static const String simulatedPassword = 'password123';
}
