# Flutter mobile app

Create the Flutter application in this directory.

Suggested entry points:
- `lib/main.dart`
- `lib/app/app.dart`
- `lib/app/bootstrap.dart`

Organize code by feature. Keep shared routing, theme, networking, error handling and reusable widgets under `lib/core`. Each feature can contain `data/`, `domain/` and `presentation/` layers.

Suggested packages to evaluate as a team: `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`, `go_router`, a state-management package, and either `hive` or `sqflite` for local caching.
