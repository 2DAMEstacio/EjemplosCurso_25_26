import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String role;
  final String? idToken;

  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.role,
    this.idToken,
  });

  factory AppUser.fromFirebase(
    User user, {
    required String role,
    String? idToken,
  }) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      role: role,
      idToken: idToken,
    );
  }

  bool get isAdmin => role == 'admin';
}
