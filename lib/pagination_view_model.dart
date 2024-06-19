import 'package:dev_nc/pagination_repository.dart';
import 'package:flutter/material.dart';

import 'api_model.dart';

class PhotoProvider extends ChangeNotifier {
  final PaginationRepository userRepository;

  PhotoProvider({required this.userRepository});

  int _page = 1; // Initial page number for pagination
  String _search = 'nature'; // Initial search term for photos
  List<Hits> _photos = <Hits>[]; // List to store the fetched photos
  bool _isLoading = false; // Declare _isLoading as a private boolean variable

  String get search => _search; // Getter for the search term
  bool get isLoading => _isLoading; // Getter for the loading state

  set search(String value) {
    _search = value; // Setter for the search term
    notifyListeners();
  }

  int get page => _page; // Getter for the current page number

  set page(int value) {
    _page = value; // Setter for the current page number
    notifyListeners();
  }

  List<Hits> get photos => _photos; // Getter for the list of photos

  set photos(List<Hits> value) {
    _photos = value; // Setter for the list of photos
    notifyListeners();
  }

  Future<void> callPhotoApi() async {
    if (_isLoading) {
      return; // Return if a fetch request is already in progress
    }
    _isLoading = true; // Set _isLoading to true before making the API call
    userRepository.getPhotos(_search, _page).then((response) {
      _page = _page + 1; // Increment the page number for the next fetch
      addPhotosToList(
          PixelPay.fromJson(response).hits!); // Add fetched photos to the list
    });
  }

  void addPhotosToList(List<Hits> photoData) {
    /*_photos.addAll(photoData);
    _isLoading = false; // Set _isLoading to false after the data has been fetched
    notifyListeners();*/

    // Simulate delay of 3 seconds to show loading state
    Future.delayed(const Duration(seconds: 3), () {
      _photos.addAll(photoData); // Add fetched photos to the existing list
      _isLoading =
          false; // Set _isLoading to false after the data has been fetched
      notifyListeners();
    });
  }
}
