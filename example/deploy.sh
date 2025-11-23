rm -rf build/web
flutter build web --wasm --release
firebase deploy --only hosting
