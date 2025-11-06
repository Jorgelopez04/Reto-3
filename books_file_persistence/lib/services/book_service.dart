import 'dart:async';
import 'dart:convert';

import 'package:books/models/book.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class BookService {
  static const localPath = 'assets/data/books.json';

  // Sin URL, los libros se leen de assets/data/books.json.
  // Con URL (por ejemplo, un endpoint de dummyjson con el mismo JSON),
  // se consultan por HTTP como en el proyecto de películas.
  final String? baseUrl;

  BookService([this.baseUrl]);

  Future<List<Book>> getBooks() async {
    final url = baseUrl;
    if (url == null) {
      final content = await rootBundle.loadString(localPath);
      return _parseBooks(content);
    }

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return _parseBooks(response.body);
      }

      if (response.statusCode == 404) {
        throw const ApiException("Couldn't find books");
      }

      if (response.statusCode == 500) {
        throw const ApiException("Server does not exist");
      }
      throw ApiException('Error HTTP ${response.statusCode}');
    } on TimeoutException {
      throw const ApiException('The server took too much time to response');
    }
  }

  List<Book> _parseBooks(String body) {
    final List<dynamic> data = jsonDecode(body);
    return data.map((item) => Book.fromJson(item)).toList();
  }
}
