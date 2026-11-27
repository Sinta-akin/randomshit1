import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  final String userId;
  final List<String> vehicleTypes;
  final String transmission;
  final String fuelType;
  final double budgetMin;
  final double budgetMax;
  final String primaryUseCase;
  final List<String> mustHaveFeatures;
  final DateTime updatedAt;

  UserPreferences({
    required this.userId,
    required this.vehicleTypes,
    required this.transmission,
    required this.fuelType,
    required this.budgetMin,
    required this.budgetMax,
    required this.primaryUseCase,
    required this.mustHaveFeatures,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'vehicleTypes': vehicleTypes,
    'transmission': transmission,
    'fuelType': fuelType,
    'budgetMin': budgetMin,
    'budgetMax': budgetMax,
    'primaryUseCase': primaryUseCase,
    'mustHaveFeatures': mustHaveFeatures,
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      UserPreferences(
        userId: json['userId'] ?? '',
        vehicleTypes: List<String>.from(json['vehicleTypes'] ?? []),
        transmission: json['transmission'] ?? 'Automatic',
        fuelType: json['fuelType'] ?? 'Any',
        budgetMin: (json['budgetMin'] ?? 0).toDouble(),
        budgetMax: (json['budgetMax'] ?? 100000).toDouble(),
        primaryUseCase: json['primaryUseCase'] ?? 'Daily commute',
        mustHaveFeatures: List<String>.from(json['mustHaveFeatures'] ?? []),
        updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  factory UserPreferences.empty(String userId) => UserPreferences(
        userId: userId,
        vehicleTypes: [],
        transmission: 'Automatic',
        fuelType: 'Any',
        budgetMin: 5000,
        budgetMax: 75000,
        primaryUseCase: 'Daily commute',
        mustHaveFeatures: [],
        updatedAt: DateTime.now(),
      );

  UserPreferences copyWith({
    List<String>? vehicleTypes,
    String? transmission,
    String? fuelType,
    double? budgetMin,
    double? budgetMax,
    String? primaryUseCase,
    List<String>? mustHaveFeatures,
  }) {
    return UserPreferences(
      userId: userId,
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      transmission: transmission ?? this.transmission,
      fuelType: fuelType ?? this.fuelType,
      budgetMin: budgetMin ?? this.budgetMin,
      budgetMax: budgetMax ?? this.budgetMax,
      primaryUseCase: primaryUseCase ?? this.primaryUseCase,
      mustHaveFeatures: mustHaveFeatures ?? this.mustHaveFeatures,
      updatedAt: DateTime.now(),
    );
  }
}
