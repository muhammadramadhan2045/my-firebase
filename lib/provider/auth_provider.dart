import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthNotifier(this._auth, this._firestore)
      : super(const AsyncValue.loading()) {
    _auth.authStateChanges().listen((User? user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> registerUser(
    String username,
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
          {
            'email': email,
            'username': username,
            'uid': cred.user!.uid,
          },
        );

        state = AsyncValue.data(cred.user);
      } else {
        throw Exception('All fields must be filled');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
          break;
      }
      state = AsyncValue.error(errorMessage, StackTrace.current);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> loginUser(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        state = AsyncValue.data(userCredential.user);
      } else {
        throw Exception('All fields must be filled');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          errorMessage = 'This user has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
          break;
      }
      state = AsyncValue.error(errorMessage, StackTrace.current);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void logout() async {
    await _auth.signOut();
    state = const AsyncValue.data(null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>(
  (ref) => AuthNotifier(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  ),
);
