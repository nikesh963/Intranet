class ApiResponse {
  String message;

  bool error;

  ApiResponse({
    required this.message,
    required this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        message: json["message"] ?? "",
        error: json["error"],
      );

  get data => null;

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
      };
}
