import 'package:flutter/foundation.dart';

/// Supported user verification document types with display labels and validation rules.
enum VerificationDocumentType {
  driversLicense('Driver\'s License', 'DL', 5 * 1024 * 1024, ['.jpg', '.jpeg', '.png', '.pdf']),
  nationalId('National ID', 'NID', 5 * 1024 * 1024, ['.jpg', '.jpeg', '.png', '.pdf']),
  passport('Passport', 'PASSPORT', 8 * 1024 * 1024, ['.jpg', '.jpeg', '.png', '.pdf']),
  taxId('Tax ID / PAN', 'TAX_ID', 5 * 1024 * 1024, ['.jpg', '.jpeg', '.png', '.pdf']);

  final String displayName;
  final String code;
  final int maxSizeBytes;
  final List<String> allowedExtensions;

  const VerificationDocumentType(
    this.displayName,
    this.code,
    this.maxSizeBytes,
    this.allowedExtensions,
  );
}

/// Verification document approval / review status.
enum VerificationStatus {
  notUploaded('Not Uploaded', 'PENDING_UPLOAD'),
  uploading('Uploading...', 'UPLOADING'),
  pendingReview('Pending Review', 'PENDING_REVIEW'),
  approved('Approved', 'APPROVED'),
  rejected('Rejected', 'REJECTED');

  final String label;
  final String code;

  const VerificationStatus(this.label, this.code);
}

/// Centralized configuration and string constants for verification document upload.
abstract class VerificationConstants {
  static const String screenTitle = 'User Verification';
  static const String screenSubtitle = 'Upload government-issued identification to unlock vehicle rentals and workshop services.';
  
  static const String selectTypePrompt = 'Select Document Type';
  static const String uploadInstruction = 'Upload clear photo or scanned copy (JPEG, PNG or PDF, max 5MB).';
  static const String uploadButtonText = 'Select & Upload Document';
  static const String replaceButtonText = 'Replace Document';
  static const String submitVerificationText = 'Submit For Verification';

  static const String statusCardTitle = 'Verification Status';
  static const String approvedMessage = 'Your identity has been verified successfully!';
  static const String pendingMessage = 'Your document is under review by our compliance team (typically 2-4 hours).';
  static const String rejectedMessage = 'Document was rejected. Please review feedback and re-upload.';

  static const String errorFileSize = 'File size exceeds maximum limit of 5MB.';
  static const String errorInvalidFormat = 'Invalid file format. Allowed formats: JPG, PNG, PDF.';
  static const String errorNoFile = 'Please select a document file to upload.';
  static const String successUploadMessage = 'Document uploaded successfully!';
  static const String successSubmitMessage = 'Verification submitted successfully!';

  /// Storage paths
  static staticPath(String userId, String docCode) => 'users/$userId/verification/$docCode';
}
