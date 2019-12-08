import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/post_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../thems/app_theme.dart';

class ArticalDetils extends StatelessWidget {
  static final routeName = '/ArticalDetils';
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments as String;
    final postDetails = Provider.of<PostsProvider>(context).findById(postId);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text('بنك الدم'),
          pinned: true,
          expandedHeight: 220.0,
          flexibleSpace: FlexibleSpaceBar(
              background: Hero(
            tag: postDetails.id,
            child: Image.network(
              postDetails.imageFullPath,
              fit: BoxFit.cover,
            ),
          )),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: <Widget>[
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
                        Text(postDetails.publishDate)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.layerGroup),
                        SizedBox(
                          width: 6,
                        ),
                        Text(postDetails.category.name)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Hero(
                      tag: postDetails.id + postDetails.tittle,
                      child: Text(
                        postDetails.tittle,
                        style: AppTheme.headline,
                        softWrap: true,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق' +
                        'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق',
                    style: AppTheme.body1,
                    softWrap: true,
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        ]))
      ]),
    );
  }
}
