import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class MovieDetailPage extends StatefulWidget {
final Movie movie;
const MovieDetailPage({super.key, required this.movie});
@override
State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle de la película'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Un póster vertical, centrado y con bordes redondeados.
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 260),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image.asset(
                            widget.movie.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: colors.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    Icons.movie_outlined,
                                    size: 72,
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                   widget.movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Wrap permite que las etiquetas bajen en pantallas pequeñas.
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(
                          Icons.local_movies_outlined,
                          size: 18,
                        ),
                        label: Text(widget.movie.genre),
                        side: BorderSide.none,
                        backgroundColor: colors.secondaryContainer,
                      ),
                      Chip(
                        avatar: Icon(
                          widget.movie.watched
                              ? Icons.check_circle_outline
                              : Icons.schedule,
                          size: 18,
                        ),
                        label: Text(
                          widget.movie.watched ? 'Vista' : 'Pendiente por ver',
                        ),
                        side: BorderSide.none,
                        backgroundColor: colors.surfaceContainerHighest,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Sinopsis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.movie.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 
  
