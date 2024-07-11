import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/pokemon_provider.dart';
import 'providers/dog_image_provider.dart';
import 'models/pokemon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
        ChangeNotifierProvider(create: (_) => DogImageProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter PokeAPI & Dog API Demo',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Demos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PokemonListScreen(),
          ),
          Divider(),
          Expanded(
            child: DogImageScreen(),
          ),
        ],
      ),
    );
  }
}

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: Consumer<PokemonProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.pokemonList.length,
            itemBuilder: (context, index) {
              Pokemon pokemon = provider.pokemonList[index];
              return ListTile(
                title: Text(pokemon.name),
                onTap: () {
                  // Puedes agregar una navegación a un detalle de Pokémon aquí
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PokemonProvider>(context, listen: false).fetchPokemon();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class DogImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dogImageProvider = Provider.of<DogImageProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (dogImageProvider.isLoading)
          CircularProgressIndicator()
        else if (dogImageProvider.dogImage != null)
          SizedBox(
            width: 400, // Ancho predeterminado
            height: 350, // Altura predeterminada
            child: Image.network(dogImageProvider.dogImage!.message, fit: BoxFit.cover),
          )
        else
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            dogImageProvider.fetchRandomDogImage();
          },
          child: Text('Genera un perro'),
        ),
      ],
    );
  }
}
