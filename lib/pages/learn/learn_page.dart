import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:insigh/pages/learn/post_details_page.dart';

import '../../components/z_card.dart';
import '../../components/z_image_display.dart';
import '../../constants/app_colors.dart';
import '../../models/post.dart';
import '../../models/video_lesson.dart';
import '../../models_providers/app_provider.dart';
import '../../utils/z_format.dart';
import '../../utils/z_launch_url.dart';

class LearnPage extends StatefulWidget {
  LearnPage({Key? key}) : super(key: key);

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final posts = appProvider.posts;
    final videoLessons = appProvider.videoLessons;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: appColorYellow,
          labelColor: appColorYellow,
          tabs: [
            Tab(text: 'Blogs'),
            Tab(text: 'Videos'),
          ],
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        posts.length > 0
            ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: ((context, index) => Column(
                      children: [
                        if (index == 0) SizedBox(height: 8),
                        PostCard(post: posts[index]),
                        if (index == videoLessons.length - 1)
                          SizedBox(height: 16),
                      ],
                    )),
              )
            : Center(
                child: Text(
                'No blogs',
                style: TextStyle(
                    color: Theme.of(context).textTheme.caption!.color,
                    fontSize: 11),
              )),
        videoLessons.length > 0
            ? ListView.builder(
                itemCount: videoLessons.length,
                itemBuilder: ((context, index) => Column(
                      children: [
                        if (index == 0) SizedBox(height: 8),
                        VideoCard(videoLesson: videoLessons[index]),
                        if (index == videoLessons.length - 1)
                          SizedBox(height: 16)
                      ],
                    )),
              )
            : Center(
                child: Text(
                'No videos',
                style: TextStyle(
                    color: Theme.of(context).textTheme.caption!.color,
                    fontSize: 11),
              ))
      ]),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ZCard(
      borderRadiusColor:
          isLightTheme ? appColorCardBorderLight : appColorCardBorderDark,
      onTap: () => Get.to(() => PostDetailsPage(post: post),
          transition: Transition.cupertino, fullscreenDialog: true),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          Hero(
            tag: post.id,
            child: ZImageDisplay(
              image: post.image,
              height: MediaQuery.of(context).size.width * .4,
              width: MediaQuery.of(context).size.width,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text(post.title),
          ),
          SizedBox(height: 4),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text(ZFormat.dateFormatSignal(post.postDate)),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, required this.videoLesson}) : super(key: key);
  final VideoLesson videoLesson;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ZCard(
      onTap: () => ZLaunchUrl.launchUrl(videoLesson.link),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.symmetric(),
      borderRadiusColor:
          isLightTheme ? appColorCardBorderLight : appColorCardBorderDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          ZImageDisplay(
            image: videoLesson.image,
            height: MediaQuery.of(context).size.width * .4,
            width: MediaQuery.of(context).size.width,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          SizedBox(height: 8),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text(videoLesson.title),
          ),
          SizedBox(height: 4),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text(ZFormat.dateFormatSignal(videoLesson.timestampCreated)),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
