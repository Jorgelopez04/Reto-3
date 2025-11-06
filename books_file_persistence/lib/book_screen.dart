import 'package:flutter/material.dart';
import 'package:books/book_card.dart';
import 'package:books/book_detail.dart';
import 'package:books/services/book_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/book.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  // -----------------------------
  // ESTADO DE LA PANTALLA
  // -----------------------------

  int? favoriteId;

  late final BookService _service;
  late Future<List<Book>> _futureBooks;

  // -----------------------------
  // CICLO DE VIDA
  // -----------------------------

  void retryBookList() {
    setState(() {
      _futureBooks = _service.getBooks();
    });
  }

  Future<void> saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteId == null) {
      await prefs.remove('favoriteBookId');
    } else {
      await prefs.setInt('favoriteBookId', favoriteId!);
    }
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favoriteId = prefs.getInt('favoriteBookId');
    });
  }

  @override
  void initState() {
    super.initState();

    // Sin URL, los libros se cargan de assets/data/books.json.
    // Para usar una API: BookService('https://dummyjson.com/c/<tu-id>')
    _service = BookService();
    _futureBooks = _service.getBooks();
    loadFavorite();
  }

  // -----------------------------
  // ESTRUCTURA GENERAL
  // -----------------------------

  void openBookDetail(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
    );
  }

  void toggleFavorite(int bookId) {
    setState(() {
      favoriteId = favoriteId == bookId ? null : bookId;
    });
    saveFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(title: const Text('Mis libros'), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  // -----------------------------
  // ESTADO -> INTERFAZ
  // -----------------------------

  Widget _buildBody() {
    return FutureBuilder<List<Book>>(
      future: _futureBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'No pudimos cargar los libros',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: retryBookList,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }

        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu_book_outlined, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Todavía no hay libros disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          // El encabezado se desplaza junto con las tarjetas.
          itemCount: books.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu próxima lectura',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${books.length} libros para explorar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toca una tarjeta para ver más o marca tu favorito con la estrella.',
                    ),
                  ],
                ),
              );
            }
            final book = books[index - 1];
            final bool isFavorite = book.id == favoriteId;

            return BookCard(
              book: book,
              onTap: () {
                openBookDetail(book);
              },
              isFavorite: isFavorite,
              onFavoriteTap: () {
                toggleFavorite(book.id);
              },
            );
          },
        );
      },
    );
  }
}
