import 'package:flutter/material.dart';
import 'package:books/models/book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final BookNoteStorage _storage = BookNoteStorage();
  final TextEditingController _noteController = TextEditingController();
  int _rating =0;

  @override
  void initState() {
    _loadLocalNote();
    super.initState();    
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
  Future<void> _saveLocalNote () async {
    final Note = BookNote(
      bookId: widget.book.id,
      note: _noteController.text,
      rating: _rating,
      updatedAt: DateTime.now(),
    );
    await _storage.saveNoteBook(Note);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La nota se ha guardado correctamente.'),
      ),
    );
  }
  Future<void> _loadLocalNote() async {
    final saved = await _storage.getNoteBook(widget.book.id);
    if (!mounted || saved == null) return;
    setState(() {
      _noteController.text = saved.note;
      _rating = saved.rating;
    });
  }
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle del libro'),
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
                  // Una portada vertical, centrada y con bordes redondeados.
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
                            widget.book.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: colors.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    Icons.menu_book_outlined,
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
                    widget.book.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.book.author,
                    style: TextStyle(
                      fontSize: 18,
                      color: colors.onSurfaceVariant,
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
                          Icons.auto_stories_outlined,
                          size: 18,
                        ),
                        label: Text(widget.book.genre),
                        side: BorderSide.none,
                        backgroundColor: colors.secondaryContainer,
                      ),
                      Chip(
                        avatar: Icon(
                          widget.book.read
                              ? Icons.check_circle_outline
                              : Icons.schedule,
                          size: 18,
                        ),
                        label: Text(
                          widget.book.read ? 'Leído' : 'Pendiente por leer',
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
                    widget.book.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(                      ,
                      border: OutlineInputBorder(),
                      labelText: 'comentarios',
                    ),
                    maxLines: 4,
                  )
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: List.generate(5, (index) {
                      final value = index + 1;
                      return ChoiceChip(
                        label: Text('$value'),
                        selected: _rating == value,
                        onSelected: (_) {
                          setState(() {
                            _rating = value;
                          });
                         }
                    }),)
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _saveLocalNote,
                      child: const Text('nota guardada '),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
