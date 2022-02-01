class UserEntity {
  final String username;
  final String userId;
  final String bio;
  UserEntity({
    required this.username,
    required this.userId,
    required this.bio,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.username == username &&
        other.userId == userId &&
        other.bio == bio;
  }

  @override
  int get hashCode => username.hashCode ^ userId.hashCode ^ bio.hashCode;

  @override
  String toString() =>
      'UserEntity(username: $username, userId: $userId, bio: $bio)';
}
