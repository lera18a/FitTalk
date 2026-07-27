class ProfileModel {
  final String id;
  final String? firstName;
  final String? username;
  final String? avatarUrl;
  final String? lastName;
  final String? bio;
  final DateTime? birthDate;
  final String? gender;
  final bool isCompleted;

  ProfileModel({
    required this.id,
    this.firstName,
    this.username,
    this.avatarUrl,
    this.lastName,
    this.bio,
    this.birthDate,
    this.gender,
    this.isCompleted = false,
  });

  static ProfileModel fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      firstName: json['first_name'],
      username: json['username'],
      avatarUrl: json['avatar_url'],
      lastName: json['last_name'],
      bio: json['bio'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      gender: json['gender'],
      isCompleted: json['is_completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'username': username,
      'avatar_url': avatarUrl,
      'last_name': lastName,
      'bio': bio,
      'birth_date': birthDate?.toIso8601String(),
      'gender': gender,
    };
  }

  ProfileModel copyWith({
    String? firstName,
    String? username,
    String? avatarUrl,
    String? lastName,
    String? bio,
    DateTime? birthDate,
    String? gender,
  }) {
    return ProfileModel(
      id: id,
      firstName: firstName ?? this.firstName,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastName: lastName ?? this.lastName,
      bio: bio ?? this.bio,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      isCompleted: isCompleted,
    );
  }
}
