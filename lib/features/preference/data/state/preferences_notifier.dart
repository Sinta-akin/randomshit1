import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automate/features/preference/data/models/user_preference.dart';
import 'package:automate/features/preference/data/repositories/user_preferences_repository.dart';

final preferencesRepositoryProvider = Provider<UserPreferencesRepository>(
      (ref) => UserPreferencesRepository(),
);

final preferencesNotifierProvider =
StateNotifierProvider<PreferencesNotifier, AsyncValue<UserPreferences?>>(
      (ref) => PreferencesNotifier(ref.read(preferencesRepositoryProvider)),
);

class PreferencesNotifier extends StateNotifier<AsyncValue<UserPreferences?>> {
  final UserPreferencesRepository _repository;
  PreferencesNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> load(String userId) async {
    state = const AsyncValue.loading();
    try {
      final prefs = await _repository.getUserPreferences(userId);
      state = AsyncValue.data(prefs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> save(UserPreferences prefs) async {
    try {
      await _repository.saveUserPreferences(prefs);
      state = AsyncValue.data(prefs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}