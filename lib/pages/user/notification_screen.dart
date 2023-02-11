import 'package:flutter/material.dart' hide Notification;

import '../../components/z_card.dart';
import '../../constants/app_colors.dart';

import '../../models/notification.dart';
import '../../utils/z_format.dart';

class NotificationDisplay extends StatefulWidget {
  const NotificationDisplay({Key? key, required this.notifications})
      : super(key: key);

  final List<Notification> notifications;

  @override
  State<NotificationDisplay> createState() => _NotificationDisplayState();
}

class _NotificationDisplayState extends State<NotificationDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.transparent, title: Text('Notifications')),
      body: widget.notifications.length > 0
          ? ListView.builder(
              itemCount: widget.notifications.length,
              itemBuilder: ((context, index) => Column(
                    children: [
                      if (index == 0) SizedBox(height: 8),
                      _buildAnnouncementCard(widget.notifications[index]),
                      if (index == widget.notifications.length - 1)
                        SizedBox(height: 16),
                    ],
                  )),
            )
          : Center(
              child: Text(
              'No notifications',
              style: TextStyle(
                  color: Theme.of(context).textTheme.caption!.color,
                  fontSize: 11),
            )),
    );
  }

  _buildAnnouncementCard(Notification notification) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return ZCard(
        borderRadiusColor:
            isLightTheme ? appColorCardBorderLight : appColorCardBorderDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(),
            Text(
              '${ZFormat.dateFormatSignal(notification.timestampCreated)}',
              style: TextStyle(
                  color: Theme.of(context).textTheme.caption!.color,
                  fontSize: 11),
            ),
            SizedBox(height: 8),
            Text(notification.title),
            SizedBox(height: 4),
            Text(
              notification.body,
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.caption!.color),
            ),
          ],
        ));
  }
}
