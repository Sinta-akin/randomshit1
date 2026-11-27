import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/verification_config.dart';
import '../models/verification_document.dart';

/// Repository handling document upload, validation, and persistence for user verification.
class VerificationRepository {
  // In-memory simulation store mapped by userId
  final Map<String, VerificationDocument> _store = {};

  /// Fetches existing verification document for user.
  Future<VerificationDocument?> getVerification(String userId) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate network latency
    return _store[userId];
  }

  /// Validates file size and MIME/extension against document type configuration.
  void validateFile(VerificationDocumentType type, String fileName, int fileSizeBytes) {
    // Check file size limit
    if (fileSizeBytes > type.maxSizeBytes) {
      throw FormatException(VerificationConstants.errorFileSize);
    }

    // Check file extension / format
    final lowerName = fileName.toLowerCase();
    final isValidExtension = type.allowedExtensions.any((ext) => lowerName.endsWith(ext));
    if (!isValidExtension) {
      throw FormatException(VerificationConstants.errorInvalidFormat);
    }
  }

  /// Uploads document file (simulated with cloud storage delay and progress) and saves record.
  Future<VerificationDocument> uploadDocument({
    required String userId,
    required VerificationDocumentType documentType,
    required String fileName,
    required int fileSizeBytes,
    Uint8List? fileBytes,
  }) async {
    // Validate before upload
    validateFile(documentType, fileName, fileSizeBytes);

    await Future.delayed(const Duration(seconds: 2)); // Simulate secure cloud upload

    final now = DateTime.now();
    final doc = VerificationDocument(
      id: 'doc_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      documentType: documentType,
      fileName: fileName,
      fileUrl: 'https://storage.googleapis.com/automate-verification/${VerificationConstants.staticPath(userId, documentType.code)}/$fileName',
      fileSizeBytes: fileSizeBytes,
      status: VerificationStatus.pendingReview,
      uploadedAt: now,
      updatedAt: now,
    );

    _store[userId] = doc;
    return doc;
  }

  /// Updates status (e.g. submit for review).
  Future<VerificationDocument> updateStatus(String userId, VerificationStatus status, {String? rejectionReason}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final existing = _store[userId];
    if (existing == null) {
      throw Exception('No verification document found for user');
    }

    final updated = existing.copyWith(
      status: status,
      rejectionReason: rejectionReason,
      updatedAt: DateTime.now(),
    );
    _store[userId] = updated;
    return updated;
  }
}
