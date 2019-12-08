import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostItems {
  final String id;
  final String tittle;
  final String content;
  final String imageFullPath;
  final String publishDate;
  final Category category;
  bool isfav;

  PostItems(
      {@required this.id,
      @required this.tittle,
      @required this.content,
      @required this.imageFullPath,
      @required this.publishDate,
      @required this.category,
      this.isfav = false});
}

class Category {
  final String id;
  final String name;
  Category({@required this.id, @required this.name});
}

class PostsProvider with ChangeNotifier {
  List<PostItems> _postItems = [];
  int lastPage;
  List<PostItems> get postsItems {
    return [..._postItems];
  }

  int get finalPage {
    return this.lastPage;
  }

  PostItems findById(String id) {
    return _postItems.firstWhere((post) => post.id == id);
  }

  Future<void> fetchPosts(int page) async {
    var url =
        'http://ipda3.com/blood-bank/api/v1/posts?api_token=Zz9HuAjCY4kw2Ma2XaA6x7T5O3UODws1UakXI9vgFVSoY3xUXYOarHX2VH27&page=$page';
    try {
      final response = await http.get(url);
      final List<PostItems> loadPosts = [];
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if (extractData['status'] != 1) {
        return;
      }
      lastPage = extractData['data']['last_page'];
      print(lastPage);
      List data = extractData['data']['data'];
      print(data.length);
      for (var i = 0; i < data.length; i++) {
        loadPosts.add(PostItems(
            id: data[i]['id'].toString(),
            tittle: data[i]['title'],
            content: data[i]['content'],
            imageFullPath: data[i]['thumbnail_full_path'],
            publishDate: data[i]['publish_date'],
            category: Category(
                id: data[i]['category']['id'].toString(),
                name: data[i]['category']['name'])));
      }
      _postItems.addAll(loadPosts);
      print(_postItems);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
