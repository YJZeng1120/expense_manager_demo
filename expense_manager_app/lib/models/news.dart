class News {
  News({
    required this.id,
    required this.reporter,
    required this.title,
    required this.content,
    required this.date,
  });

  final String id;
  final String reporter;
  final String title;
  final String content;
  final DateTime date;

  factory News.fromJson(dynamic news) {
    return News(
      id: news["id"],
      reporter: news["reporter"],
      title: news["title"],
      content: news["content"],
      date: DateTime.parse(news["date"]),
    );
  }

  factory News.empty() {
    return News(
      id: '',
      reporter: "",
      title: "",
      content: "",
      date: DateTime.now(),
    );
  }
}
