import 'package:flutter/material.dart';
import 'movie.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // Estado de la pantalla.
  // Durante la clase analizaremos qué representa cada variable
  // y cuándo debe cambiar.
  bool isLoading = false;
  List<Movie> movies = [];
  String errorMessage = '';

  // Simula una operación asíncrona, como consultar una API.
  Future<List<Movie>> loadMovies() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    return [
      Movie(
        title: 'Dune',
        genre: 'Sci-Fi',
        watched: false,
      ),
      Movie(
        title: 'Coco',
        genre: 'Animation',
        watched: true,
      ),
      Movie(
        title: 'Interstellar',
        genre: 'Sci-Fi',
        watched: true,
      ),
    ];
  }

  // Esta función se construirá progresivamente durante la clase.
  Future<void> fetchMovies() async {
    // CHECKPOINTS DE LA CLASE:
    // 1. Activar el estado de carga.
    // 2. Esperar los datos.
    // 3. Guardar las películas.
    // 4. Finalizar la carga.
    // 5. Manejar un posible error.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Empezamos con una interfaz mínima que ya funciona.
    // Este método evolucionará durante los checkpoints.
    return Center(
      child: ElevatedButton(
        onPressed: fetchMovies,
        child: const Text('Cargar películas'),
      ),
    );
  }
}
