import 'package:flutter/material.dart';

import '../../components/z_card.dart';
import '../../components/z_image_display.dart';
import '../../constants/app_colors.dart';
import '../../models/announcement.dart';
import '../../utils/z_format.dart';

class AnnouncementDisplay extends StatefulWidget {
  const AnnouncementDisplay({Key? key, required this.announcements})
      : super(key: key);

  final List<Announcement> announcements;

  @override
  State<AnnouncementDisplay> createState() => _AnnouncementDisplayState();
}

class _AnnouncementDisplayState extends State<AnnouncementDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.transparent, title: Text('Announcements')),
        body: widget.announcements.length > 0
            ? ListView.builder(
                itemCount: widget.announcements.length,
                itemBuilder: ((context, index) => Column(
                      children: [
                        if (index == 0) SizedBox(height: 8),
                        _buildAnnouncementCard(widget.announcements[index]),
                        if (index == widget.announcements.length - 1)
                          SizedBox(height: 16),
                      ],
                    )),
              )
            : Center(
                child: Text(
                'No announcements',
                style: TextStyle(
                    color: Theme.of(context).textTheme.caption!.color,
                    fontSize: 11),
              )));
  }

  _buildAnnouncementCard(Announcement announcement) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ZCard(
        borderRadiusColor:
            isLightTheme ? appColorCardBorderLight : appColorCardBorderDark,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ZFormat.dateFormatSignal(announcement.timestampCreated)}',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.caption!.color,
                        fontSize: 11),
                  ),
                  SizedBox(height: 8),
                  Text(announcement.title),
                  SizedBox(height: 4),
                  Text(
                    announcement.body,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.caption!.color),
                  ),
                ],
              ),
            ),
            if (announcement.image != '')
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZImageDisplay(
                      image: announcement.image,
                      width: MediaQuery.of(context).size.width * .2,
                      height: MediaQuery.of(context).size.width * .2,
                      borderRadius: BorderRadius.circular(8),
                    )
                  ],
                ),
              ),
          ],
        ));
  }
}
