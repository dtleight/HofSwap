class Textbook
{
  String title;
  List<String> authors;
  int edition;
  String ISBN;
  String imageSRC;
  DateTime publishDate;
  String estoreLink;

  Textbook(String title)
  {
    this.title = title;
  }
  ///
  /// Method that allows for textbooks to be directly instantiated from JSON objects.
  ///
  factory Textbook.fromJson(Map<String, dynamic> json)
  {
    return Textbook(json['volumeInfo']['title']);
  }
}