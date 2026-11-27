import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automate/core/theme/app_theme.dart';
import '../../data/models/verification_config.dart';
import '../../data/models/verification_document.dart';
import '../../state/verification_notifier.dart';

/// Screen allowing users to select identification document type, upload file, and track review status.
class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  VerificationDocumentType _selectedType = VerificationDocumentType.driversLicense;
  bool _isUploading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(verificationNotifierProvider.notifier).loadVerification(_currentUserId());
    });
  }

  String _currentUserId() {
    // Placeholder for authenticated user ID
    return 'user_arjun_123';
  }

  Future<void> _pickAndUploadFile() async {
    setState(() {
      _isUploading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // Simulate file picker selection (e.g. user selected sample driver_license.jpg of 2.4 MB)
      await Future.delayed(const Duration(seconds: 1));
      const sampleFileName = 'driver_license_front.jpg';
      const sampleFileSize = 2 * 1024 * 1024; // 2 MB

      await ref.read(verificationNotifierProvider.notifier).uploadDocument(
            userId: _currentUserId(),
            documentType: _selectedType,
            fileName: sampleFileName,
            fileSizeBytes: sampleFileSize,
          );

      if (mounted) {
        setState(() {
          _successMessage = VerificationConstants.successUploadMessage;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('FormatException: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Color _getStatusColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.approved:
        return AppTheme.successGreen;
      case VerificationStatus.pendingReview:
        return AppTheme.accentOrange;
      case VerificationStatus.rejected:
        return AppTheme.errorRed;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final verificationAsync = ref.watch(verificationNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: AppBar(
        title: const Text(VerificationConstants.screenTitle),
        backgroundColor: AppTheme.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              VerificationConstants.screenTitle,
              style: AppTheme.headline2,
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Text(
              VerificationConstants.screenSubtitle,
              style: AppTheme.bodyMedium,
            ),
            const SizedBox(height: AppTheme.spacingLg),

            // Current Status Banner if document exists
            verificationAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e', style: const TextStyle(color: AppTheme.errorRed)),
              data: (doc) {
                if (doc == null) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(color: _getStatusColor(doc.status), width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(VerificationConstants.statusCardTitle, style: AppTheme.sectionHeading),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(doc.status).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                            ),
                            child: Text(
                              doc.status.label,
                              style: TextStyle(
                                color: _getStatusColor(doc.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingSm),
                      Text('Document: ${doc.documentType.displayName} (${doc.fileName})', style: AppTheme.bodyMedium),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        doc.status == VerificationStatus.approved
                            ? VerificationConstants.approvedMessage
                            : doc.status == VerificationStatus.rejected
                                ? 'Reason: ${doc.rejectionReason ?? "Please re-upload clear image."}'
                                : VerificationConstants.pendingMessage,
                        style: AppTheme.bodyMedium?.copyWith(color: AppTheme.textPrimary),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: AppTheme.spacingLg),
            const Text(VerificationConstants.selectTypePrompt, style: AppTheme.sectionHeading),
            const SizedBox(height: AppTheme.spacingMd),

            // Document Type Selector Grid / List
            ...VerificationDocumentType.values.map((type) {
              final isSelected = _selectedType == type;
              return Container(
                margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryBlue : AppTheme.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: RadioListTile<VerificationDocumentType>(
                  title: Text(type.displayName, style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w600)),
                  subtitle: Text('Max size: ${type.maxSizeBytes ~/ (1024 * 1024)}MB • ${type.allowedExtensions.join(", ")}', style: AppTheme.labelMedium),
                  value: type,
                  groupValue: _selectedType,
                  activeColor: AppTheme.primaryBlue,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedType = val;
                      });
                    }
                  },
                ),
              );
            }),

            const SizedBox(height: AppTheme.spacingLg),

            // Upload Box / Instruction
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(color: AppTheme.border, style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  const Icon(Icons.cloud_upload_outlined, size: 48, color: AppTheme.primaryBlue),
                  const SizedBox(height: AppTheme.spacingMd),
                  const Text(VerificationConstants.uploadInstruction, textAlign: TextAlign.center, style: AppTheme.bodyMedium),
                  const SizedBox(height: AppTheme.spacingLg),
                  if (_isUploading)
                    const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: AppTheme.spacingMd),
                        Text('Uploading document securely...', style: TextStyle(color: AppTheme.textSecondary)),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: _pickAndUploadFile,
                        icon: const Icon(Icons.upload_file),
                        label: const Text(VerificationConstants.uploadButtonText),
                      ),
                    ),
                ],
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: AppTheme.spacingMd),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: BoxDecoration(
                  color: AppTheme.errorRed.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppTheme.errorRed),
                    const SizedBox(width: AppTheme.spacingSm),
                    Expanded(child: Text(_errorMessage!, style: const TextStyle(color: AppTheme.errorRed))),
                  ],
                ),
              ),
            ],

            if (_successMessage != null) ...[
              const SizedBox(height: AppTheme.spacingMd),
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, color: AppTheme.successGreen),
                    const SizedBox(width: AppTheme.spacingSm),
                    Expanded(child: Text(_successMessage!, style: const TextStyle(color: AppTheme.successGreen))),
                  ],
                ),
              ),
            ],

            const SizedBox(height: AppTheme.spacingXxl),
          ],
        ),
      ),
    );
  }
}
