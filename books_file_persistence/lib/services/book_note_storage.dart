import 'dart:convert';
import 'dart:io';

import 'package:books/models/book_note.dart';
import 'package:path_provider/path_provider.dart';

class BookNoteStorage {
  static const _fileName = 'book_notes.json';

  // Obtiene el archivo donde se guardan las notas.
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<BookNote>> _readAll() async {
    final file = await _getFile();
    if (!await file.exists()) return [];

    final content = await file.readAsString();
    if (content.isEmpty) return [];

    final List<dynamic> data = jsonDecode(content);
    return data.map((item) => BookNote.fromJson(item)).toList();
  }

  Future<void> _writeAll(List<BookNote> notes) async {
    final file = await _getFile();
    final jsonString = jsonEncode(notes.map((note) => note.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<BookNote?> getNoteForBook(int bookId) async {
    final notes = await _readAll();
    return notes.where((n) => n.bookId == bookId).firstOrNull;
  }
}
