import 'package:bank_eldam/screen/artical_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screen/articalDetils_screen.dart';

class PostItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  final String date;
  final String catogryName;

  const PostItem(
      {@required this.title,
      @required this.id,
      @required this.imageUrl,
      @required this.date,
      @required this.catogryName});
  void _onSelected(String id, BuildContext context) {
    Navigator.pushNamed(context, ArticalDetils.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onSelected(id, context),
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Hero(
                  tag: id,
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  color: Colors.black54,
                  child: Hero(
                    tag: id + title,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontFamily: 'Raleway',
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 6,
                    ),
                    Text(date)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.layerGroup),
                    SizedBox(
                      width: 6,
                    ),
                    Text(catogryName)
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
