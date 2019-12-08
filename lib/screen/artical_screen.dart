import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/post_provider.dart';
import '../widget/post_item.dart';

class ArticalScreen extends StatefulWidget {
  @override
  _ArticalScreenState createState() => _ArticalScreenState();
}

class _ArticalScreenState extends State<ArticalScreen> {
  Future _futur;
  ScrollController controller;
  int page = 1;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);

    _futur =
        Provider.of<PostsProvider>(context, listen: false).fetchPosts(page);
    super.initState();
  }

  void _scrollListener() {
    var props = Provider.of<PostsProvider>(context, listen: false);
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      print("Reached end");
      if (props.lastPage > page) {
        page++;
        print("UI page: $page");
        props.fetchPosts(page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futur,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Error Data'),
              );
            } else {
              return Consumer<PostsProvider>(
                  builder: (ctx, post, child) => ListView.builder(
                        controller: controller,
                        itemCount: post.postsItems.length,
                        itemBuilder: (ctx, i) => PostItem(
                          id: post.postsItems[i].id.toString(),
                          title: post.postsItems[i].tittle,
                          date: post.postsItems[i].publishDate,
                          imageUrl: post.postsItems[i].imageFullPath,
                          catogryName: post.postsItems[i].category.name,
                        ),
                      ));
            }
          }
        });
  }
}
