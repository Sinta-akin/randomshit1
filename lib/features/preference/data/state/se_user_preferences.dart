import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_preference.dart';
import '../state/preferences_notifier.dart';

UserPreferences? useUserPreferences(WidgetRef ref) {
  final async = ref.watch(preferencesNotifierProvider);
  return async.value;
}