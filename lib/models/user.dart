class UserModel {
  const UserModel({
    required this.email,
    required this.name,
    required this.username,
  });

  final String email;
  final String username;
  final String name;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        name: json['name'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'username': username,
      };
}
