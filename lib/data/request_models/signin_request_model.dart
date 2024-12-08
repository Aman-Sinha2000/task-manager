class SignInRequestModel {
  final String email;
  final String password;

  SignInRequestModel({
    required this.email,
    required this.password,
  });

  /// Converts a `SignInRequestModel` instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  /// Creates a `SignInRequestModel` instance from a JSON map.
  factory SignInRequestModel.fromJson(Map<String, dynamic> json) {
    return SignInRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  @override
  String toString() {
    return 'SignInRequestModel(email: $email, password: $password)';
  }
}
