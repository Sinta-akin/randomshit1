import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/verification_config.dart';
import '../data/models/verification_document.dart';
import '../data/repositories/verification_repository.dart';

final verificationRepositoryProvider = Provider<VerificationRepository>((ref) => VerificationRepository());

final verificationNotifierProvider = StateNotifierProvider<VerificationNotifier, AsyncValue<VerificationDocument?>>(
  (ref) => VerificationNotifier(ref.read(verificationRepositoryProvider)),
);

/// State notifier managing user document verification state transitions and async operations.
class VerificationNotifier extends StateNotifier<AsyncValue<VerificationDocument?>> {
  final VerificationRepository _repository;

  VerificationNotifier(this._repository) : super(const AsyncValue.loading());

  /// Loads current verification record for user.
  Future<void> loadVerification(String userId) async {
    state = const AsyncValue.loading();
    try {
      final doc = await _repository.getVerification(userId);
      state = AsyncValue.data(doc);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Uploads verification document with validation.
  Future<void> uploadDocument({
    required String userId,
    required VerificationDocumentType documentType,
    required String fileName,
    required int fileSizeBytes,
    Uint8List? fileBytes,
  }) async {
    // Set uploading status or keep previous data while showing progress
    try {
      final uploaded = await _repository.uploadDocument(
        userId: userId,
        documentType: documentType,
        fileName: fileName,
        fileSizeBytes: fileSizeBytes,
        fileBytes: fileBytes,
      );
      state = AsyncValue.data(uploaded);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Submits document for final admin review.
  Future<void> submitForReview(String userId) async {
    final currentDoc = state.value;
    if (currentDoc == null) return;

    try {
      final updated = await _repository.updateStatus(userId, VerificationStatus.pendingReview);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
