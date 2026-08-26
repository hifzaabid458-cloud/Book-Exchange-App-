class Book {
  String title;
  String author;
  String category;
  String condition;
  String location;
  String imageUrl;
  String description;
  bool isSaved;

  Book({
    required this.title,
    required this.author,
    required this.category,
    required this.condition,
    required this.location,
    required this.imageUrl,
    this.description = '',
    this.isSaved = false,
  });

  // Convert Book object into JSON-compatible data
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'category': category,
      'condition': condition,
      'location': location,
      'imageUrl': imageUrl,
      'description': description,
      'isSaved': isSaved,
    };
  }

  // Create a Book object from saved JSON data
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      condition: json['condition'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      isSaved: json['isSaved'] ?? false,
    );
  }
}