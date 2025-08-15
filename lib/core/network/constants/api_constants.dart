class ApiConstants {
  static const baseUrl = "https://dummyjson.com";
  static const endPoint = "/products?limit=190";
  static const categoriesEndPoint = "/products/categories";

  // timeouts
  static const Duration connectTimeout = Duration(seconds: 3);
  static const Duration receiveTimeout = Duration(seconds: 3);

  // headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
