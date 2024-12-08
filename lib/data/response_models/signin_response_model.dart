class SignInResponseModel {
  final String status;
  final User user;

  SignInResponseModel({
    required this.status,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'user': user.toJson(),
    };
  }

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      status: json['status'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  /// Converts a `User` instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  /// Creates a `User` instance from a JSON map.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
