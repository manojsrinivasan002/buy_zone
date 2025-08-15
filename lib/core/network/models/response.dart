class Response {
  final int statusCode;
  final dynamic data;
  final String? message;

  const Response({required this.statusCode, this.data, this.message});
}
