class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class News {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] as String,
      description: json['description'] ?? '', // Handle potential missing data
      url: json['url'] as String,
      urlToImage: json['urlToImage'] ?? '', // Handle potential missing image
      publishedAt: json['publishedAt'] as String,
    );
  }
}
