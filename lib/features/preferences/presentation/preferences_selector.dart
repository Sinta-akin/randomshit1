import '../data/models/user_preferences.dart';

Map<String, dynamic> toRecommendationFilters(UserPreferences prefs) {
  return {
    'vehicleTypes': prefs.vehicleTypes,
    'transmission': prefs.transmission,
    'fuelType': prefs.fuelType,
    'budgetMin': prefs.budgetMin,
    'budgetMax': prefs.budgetMax,
    'primaryUseCase': prefs.primaryUseCase,
    'mustHaveFeatures': prefs.mustHaveFeatures,
  };
}
