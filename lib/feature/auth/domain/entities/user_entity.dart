class UserEntity {
  final int id;
  final String authId;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? deletionRequestedAt;

  const UserEntity({
    required this.id,
    required this.authId,
    required this.isActive,
    this.createdAt,
    this.deletionRequestedAt,
  });
}
// EMAIL и отп 
