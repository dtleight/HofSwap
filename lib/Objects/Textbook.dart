class Textbook
{
  String title;
  List<dynamic> authors;
  int edition;
  String ISBN;
  String imageSRC;
  DateTime publishDate;
  String estoreLink;

  Textbook(String title, List<dynamic> authors, int edition, String ISBN, String imageSRC, DateTime publishDate, String estoreLink)
  {
    this.title = title;
    this.authors = authors;
    this.edition = edition;
    this.ISBN = ISBN;
    this.imageSRC = imageSRC;
    this.publishDate = publishDate;
    this.estoreLink = estoreLink;
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
    List<dynamic> identifiers = json['volumeInfo']['industryIdentifiers'] as List<dynamic>;
    String str = "";
    try{
      print(identifiers[0]);
      String str = identifiers[0].toString();
      str = str.substring(str.length-14,str.length-1);
      print(str);
    }
    catch(Exception)
  {

  }


    return Textbook.temporary(json['volumeInfo']['title'],json['volumeInfo']['authors'],str);
  }
}