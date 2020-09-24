class Textbook
{
  String title;
  List<dynamic> authors;
  int edition;
  String ISBN;
  String imageSRC;
  DateTime publishDate;
  String estoreLink;

  Textbook(String title, List<dynamic> authors)
  {
    this.title = title;
    this.authors = authors;
  }
  ///
  /// Method that allows for textbooks to be directly instantiated from JSON objects.
  ///
  factory Textbook.fromJson(Map<String, dynamic> json)
  {
    return Textbook(json['volumeInfo']['title'],json['volumeInfo']['authors']);
  }
}