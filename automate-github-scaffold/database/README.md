# Database and Firebase

The project plan specifies Firebase Authentication, Cloud Firestore and Firebase Storage.

- `firestore/firestore.rules` — Firestore access rules.
- `firestore/firestore.indexes.json` — composite indexes.
- `storage/storage.rules` — Storage access rules.
- `firebase/firebase.json` — Firebase CLI configuration.
- `seeds` — safe development/sample data only.
- `emulator` — local Firebase Emulator Suite configuration and notes.

The RAG vector index may be hosted in a separate vector database; document its provider and schema under `docs/ai/` and configure it through the AI service environment.
