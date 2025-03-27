class UserFirestore {
  final String uid;
  final String email;
  final String username;

  UserFirestore({
    required this.uid,
    required this.email,
    required this.username,
  });

  factory UserFirestore.fromMap(Map<String, dynamic> data) {
    return UserFirestore(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      username: data['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}
