import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../models/dog_image.dart';

class ApiService {
  final String baseUrl = "https://pokeapi.co/api/v2";

  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=10'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((e) => Pokemon.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
  Future<DogImage> fetchRandomDogImage() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

    if (response.statusCode == 200) {
      return DogImage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load dog image');
    }
  }
}