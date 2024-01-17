class ArticleModel {
  ArticleModel(
      this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content);

  String? author, description, urlToImage, content;
  String title, url, publishedAt;
  SourceModel source;

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'description': description,
      'urlToImage': urlToImage,
      'content': content,
      'title': title,
      'url': url,
      'publishedAt': publishedAt,
      'source': source.toJson(),
    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      SourceModel.fromJson(json['source'] as Map<String, dynamic>? ?? {}),
      json['author'] ?? '',
      json['title'] ?? '',
      json['description'] ?? '',
      json['url'] ?? '',
      json['urlToImage'] ?? '',
      json['publishedAt'] ?? '',
      json['content'] ?? '',
    );
  }
}

class SourceModel {
  SourceModel(this.id, this.name);

  String id, name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      SourceModel(json['id'] ?? '', json['name'] ?? '');
}
