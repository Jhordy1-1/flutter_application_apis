import 'package:flutter/material.dart';
import '../models/dog_image.dart';
import '../services/api_service.dart';

class DogImageProvider with ChangeNotifier {
  DogImage? _dogImage;
  bool _isLoading = false;

  DogImage? get dogImage => _dogImage;
  bool get isLoading => _isLoading;

  Future<void> fetchRandomDogImage() async {
    _isLoading = true;
    notifyListeners();

    try {
      _dogImage = await ApiService().fetchRandomDogImage();
    } catch (error) {
      _dogImage = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
