import 'package:flutter/material.dart';
import 'package:hofswap/Objects/Textbook.dart';
import 'package:hofswap/Pages/FocusedStoreView.dart';
import 'package:hofswap/Singeltons/DatabaseRouting.dart';
import 'package:hofswap/Utilities/TextbookBuilder.dart';
import 'package:hofswap/Widgets/TextbookCard.dart';

class SearchHandler extends SearchDelegate
{
  List<Textbook> searchResults;
  List<Textbook> data;

  SearchHandler()
  {
    data = DatabaseRouting().textbooks;
    searchResults = data.sublist(1,4);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
// this will show clear query button
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
// adding a back button to close the search
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }



  @override
  Widget buildResults(BuildContext context) {
    //clear the old search list
    searchResults.clear();

    ///Replace with a better search Query - JSON based
    searchResults = data.where((element) => element.title.startsWith(query)).toList();

    //Format results
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        return TextbookCard(
            searchResults[i], (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new FocusedStoreView(searchResults[i])));});
      },
      itemCount: searchResults.length,
    );
    /**
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          scrollDirection: Axis.vertical,
          children: List.generate(searchResults.length, (index) {
            var item = searchResults[index];
            return Card(
              color: Colors.white,
              child: Container(padding: EdgeInsets.all(16), child: Text(item.title)),
            );
          })),
    );
        **/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//clear the old search list
    searchResults.clear();

//find the elements that starts with the same query letters.
// allNames is a list that contains all your data ( you can replace it here by an http request or a query from your database )
    searchResults = data.where((element) => element.title.startsWith(query)).toList();

// view a list view with the search result
    return ListView.builder(
      itemBuilder: (BuildContext context, int i) {
        return TextbookCard(
            searchResults[i], (){ Navigator.push(context, new MaterialPageRoute(builder: (ctxt) => new FocusedStoreView(searchResults[i])));});
      },
      itemCount: searchResults.length,
    );
   /** return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          scrollDirection: Axis.vertical,
          children: List.generate(searchResults.length, (index) {
            var item = searchResults[index];
            return Card(
              color: Colors.white,
              child: Container(padding: EdgeInsets.all(16), child: Text(item.title)),
            );
          })),
    );
       **/
  }
}