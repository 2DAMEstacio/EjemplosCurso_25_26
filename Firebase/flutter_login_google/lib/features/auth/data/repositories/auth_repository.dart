import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> authChanges() => _auth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async {
    final provider = GoogleAuthProvider();
    provider.setCustomParameters({'prompt': 'select_account'});
    return kIsWeb
        ? await _auth.signInWithPopup(provider)
        : await _auth.signInWithProvider(provider);
  }

  Future<void> signOut() async {
    _auth.signOut();
  }

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<String?> idToken({bool refresh = false}) async {
    final user = _auth.currentUser;
    return user?.getIdToken(refresh);
  }

  Future<String> fetchUserRole(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data()?['role'] != null) {
      return doc['role'] as String;
    }
    await _firestore.collection('users').doc(uid).set({'role': 'user'});
    return 'user';
  }

  // Añade estos métodos al repo

  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set({'role': 'user'}, SetOptions(merge: true));
    return cred;
  }

  // Opcional: recuperar contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }
}
