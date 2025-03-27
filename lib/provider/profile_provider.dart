import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfirebase/models/user_firestore.dart';
import 'package:riverpod/riverpod.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<UserFirestore?>> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileNotifier(
    this._firestore,
    this._auth,
  ) : super(const AsyncValue.loading()) {
    _auth.authStateChanges().listen(
      (user) {
        if (user != null) {
          _fetchUserProfile();
        } else {
          state = const AsyncValue.data(null);
        }
      },
    );
  }

  Future<void> _fetchUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final userFirestore = UserFirestore.fromMap(doc.data()!);

        state = AsyncValue.data(userFirestore);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<UserFirestore?>>(
  (ref) => ProfileNotifier(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  ),
);
