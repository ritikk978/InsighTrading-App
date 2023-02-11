import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../components/z_image_display.dart';
import '../../models/post.dart';

class PostDetailsPage extends StatefulWidget {
  PostDetailsPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.post.id,
                    child: ZImageDisplay(
                        image: widget.post.image,
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.post.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 16),
                  HtmlWidget(
                    widget.post.body,
                    textStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
