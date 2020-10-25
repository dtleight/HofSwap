class Textbook
{
  String title;
  List<dynamic> authors;
  int edition;
  String ISBN;
  String condition;
  String price;

  Textbook(String title, List<dynamic> authors, int edition, String ISBN, String condition)
  {
    this.title = title;
    this.authors = authors;
    this.edition = edition;
    this.ISBN = ISBN;
    this.condition = condition;
  }
  Textbook.temporary(String title, List<dynamic> authors, String ISBN)
  {
    this.title = title;
    this.authors = authors;
    this.ISBN = ISBN;
  }
  ///
  /// Method that allows for textbooks to be directly instantiated from JSON objects.
  ///
  factory Textbook.fromJson(Map<String, dynamic> json)
  {
    try
    {
      return Textbook.temporary(json['volumeInfo']['title'],json['volumeInfo']['authors'],json['volumeInfo']['industryIdentifiers'][0]['identifier']);
    }
    catch(Exception)
  {

  }
  return Textbook.temporary(json['volumeInfo']['title'],json['volumeInfo']['authors'],"");
  }
}