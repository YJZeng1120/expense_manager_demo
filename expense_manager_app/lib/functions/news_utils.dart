String formattedArticle(
  String article,
) {
  final String formattedArticle =
      article.replaceAll('. ', '.\n').replaceAll('.', '.\n');
  return formattedArticle;
}
