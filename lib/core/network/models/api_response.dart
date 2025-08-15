class ApiResponse {
  final int statusCode;
  final dynamic data;
  final String? message;

  const ApiResponse({required this.statusCode, this.data, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'] ?? 200,
      data: json['data'],
      message: json['message'] ?? "No message for this response.",
    );
  }
}
