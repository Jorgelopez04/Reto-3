class Book {
  final int id;
  String title;
  String author;
  double price;
  bool watched;
  String description;
  String imagepath;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.watched,
    required this.description,
    required this.imagepath,
  });
}
