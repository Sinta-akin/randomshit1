import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automate/core/theme/app_theme.dart';
import 'package:automate/core/constants/app_constants.dart';
import 'package:automate/features/preferences/state/preferences_notifier.dart';
import 'package:automate/features/preferences/data/models/user_preferences.dart';

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  static const _vehicleTypes = ['SUV', 'Sedan', 'EV', 'Hatchback'];
  static const _transmissions = ['Automatic', 'Manual'];
  static const _fuelTypes = ['Any', 'Petrol', 'Diesel', 'Electric', 'Hybrid'];
  static const _useCases = ['Daily commute', 'Family', 'Road trips', 'Luxury'];
  static const _mustHaveFeatures = ['AWD', 'Apple CarPlay', 'Child seat', 'Sunroof'];

  final _selectedVehicleTypes = <String>{};
  final _selectedMustHaveFeatures = <String>{};

  String? _transmission;
  String? _fuelType;
  String? _primaryUseCase;
  double _budgetMin = 5000;
  double _budgetMax = 75000;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = _currentUserId();
      ref.read(preferencesNotifierProvider.notifier).load(userId);
    });
  }

  String _currentUserId() {
    // Wire up Firebase Auth later; placeholder for now.
    return 'current_user';
  }

  void _prefill(UserPreferences? prefs) {
    if (prefs == null) return;
    _selectedVehicleTypes.addAll(prefs.vehicleTypes);
    _transmission = prefs.transmission;
    _fuelType = prefs.fuelType;
    _budgetMin = prefs.budgetMin;
    _budgetMax = prefs.budgetMax;
    _primaryUseCase = prefs.primaryUseCase;
    _selectedMustHaveFeatures.addAll(prefs.mustHaveFeatures);
  }

  Future<void> _save() async {
    final userId = _currentUserId();
    final prefs = UserPreferences(
      userId: userId,
      vehicleTypes: _selectedVehicleTypes.toList(),
      transmission: _transmission ?? 'Automatic',
      fuelType: _fuelType ?? 'Any',
      budgetMin: _budgetMin,
      budgetMax: _budgetMax,
      primaryUseCase: _primaryUseCase ?? 'Daily commute',
      mustHaveFeatures: _selectedMustHaveFeatures.toList(),
      updatedAt: DateTime.now(),
    );
    await ref.read(preferencesNotifierProvider.notifier).save(prefs);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences saved.')),
      );
    }
  }

  Widget _section(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppTheme.spacingLg),
        Text(title, style: AppTheme.sectionHeading),
        const SizedBox(height: AppTheme.spacingXs),
        Text(subtitle, style: AppTheme.bodyMedium),
        const SizedBox(height: AppTheme.spacingMd),
      ],
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label, style: const TextStyle(fontSize: 14)),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppTheme.primaryBlue,
      backgroundColor: AppTheme.surface,
      labelStyle: const TextStyle(color: AppTheme.textPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        side: const BorderSide(color: AppTheme.border),
      ),
    );
  }

  Widget _featureCheckbox(String label, bool selected, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(label, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
      value: selected,
      onChanged: onChanged,
      activeColor: AppTheme.primaryBlue,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final asyncPrefs = ref.watch(preferencesNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Preferences'),
        backgroundColor: AppTheme.scaffoldBackground,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: asyncPrefs.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading preferences', style: const TextStyle(color: AppTheme.errorRed))),
        data: (prefs) {
          if (prefs != null && _selectedVehicleTypes.isEmpty) {
            _prefill(prefs);
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _section('Vehicle Types', 'What kind of vehicles do you prefer?'),
                Wrap(
                  spacing: AppTheme.spacingSm,
                  runSpacing: AppTheme.spacingSm,
                  children: _vehicleTypes.map((v) => _chip(v, _selectedVehicleTypes.contains(v), () {
                    setState(() {
                      if (_selectedVehicleTypes.contains(v)) _selectedVehicleTypes.remove(v);
                      else _selectedVehicleTypes.add(v);
                    });
                  })).toList(),
                ),
                _section('Transmission', 'Automatic or Manual?'),
                Row(
                  children: _transmissions.map((t) => Expanded(
                    child: _chip(t, _transmission == t, () => setState(() => _transmission = t)),
                  )).toList(),
                ),
                _section('Fuel Type', 'Preferred fuel type?'),
                Wrap(
                  spacing: AppTheme.spacingSm,
                  runSpacing: AppTheme.spacingSm,
                  children: _fuelTypes.map((f) => _chip(f, _fuelType == f, () => setState(() => _fuelType = f))).toList(),
                ),
                _section('Budget Range', 'Minimum and maximum budget'),
                RangeSlider(
                  values: RangeValues(_budgetMin, _budgetMax),
                  min: 0,
                  max: 150000,
                  divisions: 30,
                  labels: RangeLabels('\$${_budgetMin.round()}', '\$${_budgetMax.round()}'),
                  onChanged: (values) => setState(() {
                    _budgetMin = values.start;
                    _budgetMax = values.end;
                  }),
                ),
                _section('Primary Use Case', 'How will you use the vehicle?'),
                Wrap(
                  spacing: AppTheme.spacingSm,
                  runSpacing: AppTheme.spacingSm,
                  children: _useCases.map((u) => _chip(u, _primaryUseCase == u, () => setState(() => _primaryUseCase = u))).toList(),
                ),
                _section('Must-Have Features', 'Features you can\'t live without'),
                Column(
                  children: _mustHaveFeatures.map((f) => _featureCheckbox(
                    f, _selectedMustHaveFeatures.contains(f), (v) => setState(() {
                      if (v == true) _selectedMustHaveFeatures.add(f);
                      else _selectedMustHaveFeatures.remove(f);
                    }),
                  )).toList(),
                ),
                const SizedBox(height: AppTheme.spacingXxl),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppConstants.verification),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.surface, side: const BorderSide(color: AppTheme.primaryBlue)),
                    child: const Text('Go to User Verification'),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _save,
                    child: const Text('Save Preferences'),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingMd),
              ],
            ),
          );
        },
      ),
    );
  }
}
