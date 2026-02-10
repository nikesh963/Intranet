class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}

class LoginResponseModel {
  String accessToken;
  String expiresAt;
  String refreshToken; // Add this field


  LoginResponseModel({
    required this.accessToken,
    required this.expiresAt,
    required this.refreshToken, // Add this parameter
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    accessToken: json["accessToken"] ?? json["access_token"] ?? "",
    expiresAt: json["expiresAt"] ?? json["expires_at"] ?? "",
    refreshToken: json["refreshToken"] ?? json["refresh_token"] ?? "", // Add this
  );
}