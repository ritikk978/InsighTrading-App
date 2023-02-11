import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/z_card.dart';
import '../../components/z_image_display.dart';
import '../../models_providers/app_provider.dart';
import '../../utils/z_launch_url.dart';

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final announcements = appProvider.announcements;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.transparent, title: Text('Announcements')),
      body: ListView(
        children: [
          for (final announcement in announcements)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/announcement_bull.png', width: 50, height: 50),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          announcement.body,
                          style: TextStyle(color: Color(0xFFFDC413), fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (announcement.link != '')
                        ZCard(
                          onTap: () => ZLaunchUrl.launchUrl(announcement.link),
                          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                          width: MediaQuery.of(context).size.width * .7,
                          child: Text(
                            announcement.link,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      SizedBox(height: 10),
                      if (announcement.image != '')
                        ZImageDisplay(
                          image: announcement.image,
                          width: MediaQuery.of(context).size.width * .75,
                          height: MediaQuery.of(context).size.height * .15,
                          borderRadius: BorderRadius.circular(20),
                        )
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
