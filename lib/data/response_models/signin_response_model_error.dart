class SigninResponseModelError {
  final String status;
  final String message;

  SigninResponseModelError({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory SigninResponseModelError.fromJson(Map<String, dynamic> json) {
    return SigninResponseModelError(
      status: json['status'] as String,
      message: json['message'] as String,
    );
  }
}
