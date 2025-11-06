class Book {
  final int id;
  final String title;
  final String author;
  final String genre;
  final bool read;
  final String description;
  final String imagePath;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.read,
    required this.description,
    required this.imagePath,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      read: json['read'],
      description: json['description'],
      imagePath: json['imagePath'],
    );
  }
}
