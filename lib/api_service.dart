import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio; // Dio instance to perform HTTP requests.

  // ApiService({required Dio dio}) : _dio = dio;
  ApiService({required Dio dio}) {
    _dio = Dio(BaseOptions(
      //baseUrl: "https://dummyjson.com/products/",
      // connectTimeout: const Duration(seconds:5),
      // receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json,
    ))
      ..interceptors.addAll([
        // LoggerInterceptor(), //custom logger interceptor.
      ]);
  }

  Future<Map<String, dynamic>> getPhotos(int page, String search) async {
    try {
      // Make a GET request to the API endpoint to fetch product data.
      final response = await _dio.get(
          "https://pixabay.com/api/?key=35457470-ba2fadec934c3233f2e9afacc&q=$search&image_type=photo&pretty=true&page=$page");

      // Check if the response status code is 200 (OK).
      if (response.statusCode == 200) {
        return response
            .data; // If successful, return the response data (Map of dynamic).
      } else {
        // If the response status code is not 200, throw an exception with an error message.
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // If any exception occurs during the API call, throw an exception with the error message.
      throw Exception('An error occurred: $e');
    }
  }
}
