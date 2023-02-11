import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insigh/constants/images.dart';
import 'package:insigh/pages/user/announcements_screen.dart';
import 'package:insigh/pages/user/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:insigh/components/z_text_form_field_calendar.dart';
import 'package:insigh/models/app_control_links.dart';
import 'package:insigh/pages/user/subscription_page.dart';
import 'package:insigh/pages/user/support_page.dart';

import '../../components/z_card.dart';
import '../../constants/app_colors.dart';
import '../../models/auth_user.dart';
import '../../models_providers/app_provider.dart';
import '../../models_providers/auth_provider.dart';
import '../../models_providers/theme_provider.dart';
import '../../models_services/firebase_auth_service.dart';
import '../../utils/z_launch_url.dart';
import '../app/account_delete_page.dart';
import 'disclaimer_page.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final AuthUser? authUser = authProvider.authUser;
    final notifications = appProvider.notifications;
    final announcements = appProvider.announcements;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Account'),
          centerTitle: false,
          /*------------------------------------------Delete Account Option ----------------------------------------*/
          // actions: [
          //   if (authUser?.isAnonymous == false)
          //     IconButton(
          //       onPressed: () => Get.to(AccountDeletePage()),
          //       icon: Icon(Icons.more_vert_outlined),
          //     ),
          // ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 16),
            if (authUser?.isAnonymous == false)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: Text(authUser?.email ?? ''), margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                  SizedBox(height: 8),
                ],
              ),
            // ZCard(
            //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            //     padding: EdgeInsets.zero,
            //     color: Colors.transparent,
            //     // onTap: () => Get.to(() => SubscriptionPage(), fullscreenDialog: true),
            //     child: Row(
            //       children: [
            //         SvgPicture.asset('assets/svg/money.svg', color: appColorBlue, height: 20, width: 20),
            //         SizedBox(width: 16),
            //         Text('My Subscription', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            //         Spacer(),
            //         Icon(Icons.arrow_forward_ios, size: 16),
            //       ],
            //     )),
            Divider(height: 10),
            ZCard(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                onTap: () => Get.to(() => SupportPage(), fullscreenDialog: true),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/support.svg', color: appColorPink, height: 20, width: 20),
                    SizedBox(width: 16),
                    Text('Support', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                )),
            Divider(height: 6),
            ZCard(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                onTap: () => Get.to(() => DisclaimerPage(), fullscreenDialog: true),
                child: Row(
                  children: [
                    Image.asset(Images.disclaimerIcon, height: 22, width: 22),
                    SizedBox(width: 16),
                    Text('Disclaimer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                )),
            Divider(height: 6),
            ZCard(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 16, top: 0, bottom: 0),
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/notification.svg', color: appColorYellow, height: 20, width: 20),
                    SizedBox(width: 16),
                    Text('Enable notifications', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Switch(
                        value: authUser?.isNotificationsEnabled ?? true,
                        activeColor: appColorBlue,
                        onChanged: (v) {
                          FirebaseAuthService.toggleNotifications(value: v);
                        })
                  ],
                )),
            // Divider(height: 6),
            // ZCard(
            //     color: Colors.transparent,
            //     margin: EdgeInsets.only(left: 16, top: 0, bottom: 0),
            //     padding: EdgeInsets.zero,
            //     child: Row(
            //       children: [
            //         SvgPicture.asset('assets/svg/exchange.svg', color: getIconColor(1), height: 20, width: 20),
            //         SizedBox(width: 16),
            //         Text('Enable dark mode', style: TextStyle(fontWeight: FontWeight.w600)),
            //         Spacer(),
            //         Switch(
            //             value: themeProvider.themeMode == ThemeMode.dark,
            //             activeColor: appColorBlue,
            //             onChanged: (v) {
            //               if (themeProvider.themeMode == ThemeMode.dark) {
            //                 themeProvider.themeMode = ThemeMode.light;
            //               } else {
            //                 themeProvider.themeMode = ThemeMode.dark;
            //               }
            //             })
            //       ],
            //     )),
            Divider(height: 6),
            ZCard(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                onTap: () => Get.to(() => NotificationDisplay(notifications: notifications), fullscreenDialog: true),
                child: Row(
                  children: [
                    Icon(Icons.notifications_active, size: 22, color: appColorRed,),
                    SizedBox(width: 16),
                    Text('Notifications', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                )),
            Divider(height: 6),
            ZCard(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.zero,
                color: Colors.transparent,
                onTap: () => Get.to(() => AnnouncementDisplay(announcements: announcements), fullscreenDialog: true),
                child: Row(
                  children: [
                    Icon(Icons.announcement, size: 22, color: appColorBlue,),
                    SizedBox(width: 16),
                    Text('Announcements', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                )),
            Divider(height: 6),
            if (authUser?.isAnonymous == false)
              Column(
                children: [
                  ZCard(
                      color: Colors.transparent,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: EdgeInsets.zero,
                      onTap: () async {
                        Provider.of<AppProvider>(context, listen: false).cancleAllStreams();
                        await Provider.of<AuthProvider>(context, listen: false).signOut();
                        await Provider.of<AuthProvider>(context, listen: false).initReload();
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/notification.svg', color: appColorError, height: 20, width: 20),
                          SizedBox(width: 16),
                          Text('Sign out', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      )),
                  Divider(height: 20),
                ],
              ),
            _buildSignIn(),
            // FollowUs(),
            SizedBox(height: 8),
            // TermsPrivacy(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  _buildSignIn() {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.authUser?.isAnonymous == false) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(),
        SizedBox(height: 16),
        Container(margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16), child: Text('Want to sync between devices?')),
        if (Platform.isIOS)
          ZCard(
              onTap: () async {
                try {
                  await FirebaseAuthService.signInWithApple();
                  Provider.of<AppProvider>(context, listen: false).cancleAllStreams();
                  await Provider.of<AuthProvider>(context, listen: false).initReload();
                } catch (e) {
                  print(e);
                }
              },
              margin: EdgeInsets.symmetric(horizontal: 16),
              color: isLight ? Colors.grey.shade300 : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/apple.png', width: 20, height: 20),
                  SizedBox(width: 4),
                  Text('Sign in with Apple', style: TextStyle(color: Colors.black, fontSize: 13))
                ],
              )),
        SizedBox(height: 16),
        ZCard(
            onTap: () async {
              try {
                await FirebaseAuthService.signInWithGoogle();
                Provider.of<AppProvider>(context, listen: false).cancleAllStreams();
                await Provider.of<AuthProvider>(context, listen: false).initReload();
              } catch (e) {
                print(e);
              }
            },
            margin: EdgeInsets.symmetric(horizontal: 16),
            color: isLight ? Colors.grey.shade300 : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/google.png', width: 20, height: 20),
                SizedBox(width: 4),
                Text('Sign in with Google', style: TextStyle(color: Colors.black, fontSize: 13))
              ],
            )),
      ],
    );
  }

  Color getIconColor(int index) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    Color color = isLightTheme ? Colors.black54 : Colors.white60;
    return color;
  }
}

class FollowUs extends StatelessWidget {
  const FollowUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final AppControlLinks appControlLinks = appProvider.appControlLinks;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Container(margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('Follow us:')),
        if (appControlLinks.instagram != '')
          ZSocialMedia(
            text: 'Instagram',
            color: appColorPink,
            icon: AntDesign.instagram,
            onTap: () => ZLaunchUrl.launchUrl(appControlLinks.instagram),
          ),
        if (appControlLinks.telegram != '')
          ZSocialMedia(
            text: 'Telegram',
            color: appColorBlue,
            icon: AntDesign.message1,
            onTap: () => ZLaunchUrl.launchUrl(appControlLinks.telegram),
          ),
        if (appControlLinks.youtube != '')
          ZSocialMedia(
            text: 'Youtube',
            color: appColorRed,
            icon: AntDesign.youtube,
            onTap: () => ZLaunchUrl.launchUrl(appControlLinks.youtube),
          ),
        if (appControlLinks.twitter != '')
          ZSocialMedia(
            text: 'Twitter',
            color: appColorBlue,
            icon: AntDesign.twitter,
            onTap: () => ZLaunchUrl.launchUrl(appControlLinks.twitter),
          ),
      ],
    );
  }
}

class TermsPrivacy extends StatelessWidget {
  const TermsPrivacy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final AppControlLinks appControlLinks = appProvider.appControlLinks;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Container(margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Text('Terms & Privacy:')),
        if (appControlLinks.terms != '')
          ZSocialMedia(
            text: 'Terms',
            color: Colors.grey.shade400,
            icon: AntDesign.infocirlce,
            onTap: () => ZLaunchUrl.launchUrl(appControlLinks.terms),
          ),
        if (appControlLinks.privacy != '')
          ZSocialMedia(
            text: 'Privacy',
            color: Colors.grey.shade400,
            icon: AntDesign.infocirlce,
            onTap: () => ZLaunchUrl.launchUrl((appControlLinks.privacy)),
          ),
      ],
    );
  }
}

class ZSocialMedia extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Function() onTap;

  ZSocialMedia({Key? key, required this.icon, required this.text, required this.color, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [Icon(icon), SizedBox(width: 8), Text(text)],
        ),
      ),
    );
  }
}
