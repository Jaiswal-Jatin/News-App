class NewsModel {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  NewsModel({this.status, this.totalResults, this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: json["articles"] == null
        ? []
        : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
  );
}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt: json["publishedAt"] == null
        ? null
        : DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );
}

class Source {
  final String? id;
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(id: json["id"], name: json["name"]);
}
