class BookNote {
  final int bookId;
  final String note;
  final int rating;
  final DateTime updatedAt;

  const BookNote({
    required this.bookId,
    required this.note,
    required this.rating,
    required this.updatedAt,
  });

  factory BookNote.fromJson(Map<String, dynamic> json) {
    return BookNote(
      bookId: json['book_id'] as int,
      note: json['note'],
      rating: json['rating'] as int,
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'book_id': bookId,
    'note': note,
    'rating': rating,
    'updated_at': updatedAt.toIso8601String(),
  };
}
