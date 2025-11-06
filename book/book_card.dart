import 'package:flutter/material.dart';
import 'book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(
          book.watched ? Icons.check_circle : Icons.radio_button_unchecked,
        ),
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: Text('\$${book.price.toStringAsFixed(2)}'),
        onTap: onTap,
      ),
    );
  }
}
