# Document Upload Feature Summary (AutoMate)

## Overview
The **User Verification Document Upload** feature enables users of AutoMate (such as renters, vehicle owners, and workshop service providers) to securely upload government-issued identification documents (e.g., Driver's License, National ID, Passport, Tax ID) for identity verification and compliance.

---

## 1. File Structure & Component Breakdown

### Core & Configuration (`lib/features/verification/data/models/verification_config.dart`)
- **`VerificationDocumentType` enum**: Defines supported document types (`driversLicense`, `nationalId`, `passport`, `taxId`), each bundling its display name, short code, maximum allowed file size (e.g., 5MB–8MB), and permitted file extensions (`.jpg`, `.jpeg`, `.png`, `.pdf`).
- **`VerificationStatus` enum**: Tracks the review lifecycle state (`notUploaded`, `uploading`, `pendingReview`, `approved`, `rejected`).
- **`VerificationConstants` class**: Centralizes all user-facing strings, error messages, success messages, and storage path formatters (`users/{userId}/verification/{docCode}`). Ensures zero hardcoded magic strings or numbers across UI and business logic.

### Data Model (`lib/features/verification/data/models/verification_document.dart`)
- **`VerificationDocument` class**: Immutable data model representing a user's uploaded document record, containing fields for `id`, `userId`, `documentType`, `fileName`, `fileUrl`, `fileSizeBytes`, `status`, `rejectionReason`, `uploadedAt`, and `updatedAt`. Includes `toJson()` / `fromJson()` support for backend synchronization.

### Repository Layer (`lib/features/verification/data/repositories/verification_repository.dart`)
- **`VerificationRepository` class**: Manages persistence and validation logic:
  - `validateFile(...)`: Enforces maximum size and extension checks before initiating upload.
  - `uploadDocument(...)`: Simulates secure cloud storage upload (with progress / delay) and saves the verification record.
  - `updateStatus(...)`: Updates review status and handles admin rejection reasons.

### State Management (`lib/features/verification/state/verification_notifier.dart`)
- **`VerificationNotifier` class**: A Riverpod `StateNotifier` managing `AsyncValue<VerificationDocument?>` state. Exposes methods to load verification status, validate and upload documents, and submit records for compliance review.

### Presentation Layer (`lib/features/verification/presentation/screens/verification_screen.dart`)
- **`VerificationScreen` widget**: A responsive UI screen featuring:
  - Real-time status banner reflecting approval, rejection feedback, or pending review status.
  - Interactive document type selector radio list.
  - Secure file upload dropzone with size & format guidelines.
  - Inline error handling and success notifications.

---

## 2. Architectural & Technical Decisions

1. **Centralized Config & Enums**: All validation rules (file size caps, MIME extensions) and status labels are strictly encapsulated in `verification_config.dart`. This prevents duplication and makes adding new document types trivial.
2. **Riverpod State Management**: Built using `StateNotifier` and `AsyncValue`, providing robust handling of loading states, error boundaries, and asynchronous upload lifecycle events without boilerplate.
3. **Immutability & Safety**: Data models are immutable (`@immutable`) with `copyWith` and JSON serialization helpers, ensuring predictable state transitions.
4. **Design System Integration**: Fully adheres to AutoMate's dark mode design system (`AppTheme`), utilizing consistent color tokens (`successGreen`, `errorRed`, `primaryBlue`, `surface`) and typography.

---

## 3. Pros and Cons (Trade-offs)

### Pros
- **Robust Validation**: Client-side pre-validation prevents invalid uploads and oversized files from hitting storage.
- **Extensible Architecture**: Adding passport or other document types requires only updating the enum definition.
- **Clean Separation of Concerns**: Models, repositories, state notifiers, and presentation screens are strictly separated.

### Cons & Future Enhancements
- **In-Memory Mock Store**: Currently uses an in-memory repository map for standalone demonstration; requires integration with Firebase Storage and Cloud Firestore for production persistence.
- **Local File Picker Integration**: Uses simulated file selection; in a full deployment, `file_picker` or `image_picker` package should be wired up to access device storage or camera.
