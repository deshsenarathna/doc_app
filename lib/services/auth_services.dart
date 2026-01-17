import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Signup
  Future<UserModel?> signup({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save extra info in Firestore
      await _db.collection('users').doc(cred.user!.uid).set({
        'email': email,
        'role': role,
      });

      return UserModel(email: email, phone: '', role: role, uid: cred.user!.uid);
    } catch (e) {
      print('Signup error: $e');
      return null;
    }
  }

  // Login
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _db.collection('users').doc(cred.user!.uid).get();
      return UserModel(
        email: doc['email'],
        phone: '', // optional
        role: doc['role'],
        uid: cred.user!.uid,
      );
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
