import 'package:flutter/foundation.dart';
import 'verification_config.dart';

/// Model representing an uploaded user verification document.
@immutable
class VerificationDocument {
  final String id;
  final String userId;
  final VerificationDocumentType documentType;
  final String fileName;
  final String fileUrl;
  final int fileSizeBytes;
  final VerificationStatus status;
  final String? rejectionReason;
  final DateTime uploadedAt;
  final DateTime updatedAt;

  const VerificationDocument({
    required this.id,
    required this.userId,
    required this.documentType,
    required this.fileName,
    required this.fileUrl,
    required this.fileSizeBytes,
    required this.status,
    this.rejectionReason,
    required this.uploadedAt,
    required this.updatedAt,
  });

  VerificationDocument copyWith({
    String? id,
    String? userId,
    VerificationDocumentType? documentType,
    String? fileName,
    String? fileUrl,
    int? fileSizeBytes,
    VerificationStatus? status,
    String? rejectionReason,
    DateTime? uploadedAt,
    DateTime? updatedAt,
  }) {
    return VerificationDocument(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      documentType: documentType ?? this.documentType,
      fileName: fileName ?? this.fileName,
      fileUrl: fileUrl ?? this.fileUrl,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'documentType': documentType.code,
        'fileName': fileName,
        'fileUrl': fileUrl,
        'fileSizeBytes': fileSizeBytes,
        'status': status.code,
        'rejectionReason': rejectionReason,
        'uploadedAt': uploadedAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory VerificationDocument.fromJson(Map<String, dynamic> json) {
    return VerificationDocument(
      id: json['id'] as String,
      userId: json['userId'] as String,
      documentType: VerificationDocumentType.values.firstWhere(
        (e) => e.code == json['documentType'],
        orElse: () => VerificationDocumentType.driversLicense,
      ),
      fileName: json['fileName'] as String,
      fileUrl: json['fileUrl'] as String,
      fileSizeBytes: json['fileSizeBytes'] as int,
      status: VerificationStatus.values.firstWhere(
        (e) => e.code == json['status'],
        orElse: () => VerificationStatus.notUploaded,
      ),
      rejectionReason: json['rejectionReason'] as String?,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
