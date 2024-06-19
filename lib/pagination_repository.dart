import 'api_service.dart';

class PaginationRepository {
  final ApiService
      apiService; // Instance of the ApiService class to perform API requests.

  PaginationRepository({required this.apiService});

  Future<Map<String, dynamic>> getPhotos(String query, int page) async {
    try {
      // Call the ApiService's getPhotos method to fetch photos from the API
      return await apiService.getPhotos(page, query);
    } catch (e) {
      // If an exception occurs during the API call, throw an exception with an error message.
      throw Exception('Failed to fetch products');
    }
  }
}
