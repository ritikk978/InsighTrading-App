import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinkService {
  Future<Uri> createDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://insightrading-frontend.vercel.app/landing"),
      longDynamicLink: Uri.parse(
        'https://insightrading.page.link?link=https://insightrading-frontend.vercel.app/landing&apn=com.trading.insigh',
      ),
      uriPrefix: "https://insightrading.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.trading.insigh",
        minimumVersion: 21,
      ),
      // iosParameters: const IOSParameters(
      //   bundleId: "com.univest.capp",
      //   appStoreId: "6443753518",
      //   minimumVersion: "10",
      // ),
    );
    final dynamicLink =
    await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    print(
        "uri is $dynamicLink  ${dynamicLink.previewLink} ${dynamicLink.shortUrl}");
    return dynamicLink.shortUrl;
  }





  // void handleDeepLink(Map<String, dynamic>? deepLink, BuildContext context) {
  //   if (deepLink == null) {
  //     return;
  //   }
  //   String action = deepLink!['action'].toString();
  //   String pageName = deepLink['page_name'].toString();
  //   String tradeCardId = deepLink["streamMessageId"].toString();
  //   if (action == "referral") {
  //     referAndEarnBottomSheet(context);
  //   }
  //   if (action == DynamicLinksActionEnums.groupInvite.name) {
  //     handleGroupInvite(deepLink, context);
  //   }
  //
  //   if (action == DynamicLinksActionEnums.redirectToPage.name) {
  //     switch (pageName) {
  //       case "chat_page":
  //         {
  //           context.read<BottomNavCubit>().updateIndexWithTabSwitch(2, 1);
  //         }
  //         break;
  //
  //       case "portfolio_home":
  //         {
  //           context.read<BottomNavCubit>().updateIndex(3);
  //         }
  //         break;
  //
  //       case "trade_board":
  //         {
  //           if (tradeCardId.isNotEmpty) {
  //
  //             var index = 0;
  //             String tradeCardFilter =
  //             deepLink["trade_board_filter"].toString();
  //             String tradeCardType =
  //             deepLink["trade_card_type"].toString().toUpperCase();
  //             if(tradeCardType == "SHORT"){
  //               index = 1;
  //             }else if(tradeCardType == "MEDIUM"){
  //               index = 2;
  //             }else if(tradeCardType == "LONG"){
  //               index = 3;
  //             }
  //             context.read<BottomNavCubit>().updateIndexWithTabSwitch(2, index,
  //                 streamMessageId: tradeCardId,
  //                 tradeCardFilter: tradeCardFilter);
  //           } else {
  //             context.read<BottomNavCubit>().updateIndexWithTabSwitch(2, 0);
  //           }
  //         }
  //         break;
  //
  //       case "broker_open":
  //         {
  //           getIt<SmallCaseRepository>()
  //               .openBrokerAccount(pageName: 'homepage');
  //         }
  //         break;
  //
  //       case "search_page":
  //         {
  //           context.read<BottomNavCubit>().updateIndex(1);
  //         }
  //         break;
  //
  //     // case "screener_page":
  //     //   {
  //     //     Navigator.of(context)
  //     //         .pushNamed(RouteName.webViewScreen, arguments: {
  //     //       "code": null,
  //     //       "isStockDetails": false,
  //     //       "url":
  //     //           "${StringConstants.webBaseUrl}screeners/${deepLink['screener_code']}"
  //     //     }).then((value) {
  //     //       if (value == "search") {
  //     //         context.read<BottomNavCubit>().updateIndex(1);
  //     //       }
  //     //     });
  //     //   }
  //     //   break;
  //
  //       case "screener_page":
  //         {
  //           if (deepLink['screener_code'] == null) {
  //             Navigator.of(context)
  //                 .pushNamed(RouteName.screenersHome)
  //                 .then((value) {
  //               if (value == "search") {
  //                 context.read<BottomNavCubit>().updateIndex(1);
  //               }
  //             });
  //           } else {
  //             context
  //                 .read<ScreenersHomeCubit>()
  //                 .updateIndex(deepLink['screener_code'], context);
  //           }
  //         }
  //         break;
  //
  //       case "news_page":
  //         {
  //           Navigator.of(context).pushNamed(RouteName.newsScreen);
  //         }
  //         break;
  //
  //       case "watchlist":
  //         {
  //           context.read<BottomNavCubit>().updateIndex(4);
  //         }
  //         break;
  //
  //       case "profile":
  //         {
  //           Navigator.of(context).pushNamed(RouteName.profileSettings);
  //         }
  //         break;
  //
  //       case "results":
  //         {
  //           Navigator.of(context)
  //               .pushNamed(RouteName.webViewScreen, arguments: {
  //             "code": null,
  //             "isStockDetails": false,
  //             "url": StringConstants.webBaseUrl + deepLink['url'].toString()
  //           }).then((value) {
  //             if (value == "search") {
  //               context.read<BottomNavCubit>().updateIndex(1);
  //             }
  //           });
  //         }
  //         break;
  //
  //       case "product_tour":
  //         {
  //           Navigator.of(context).pushNamed(
  //             RouteName.productTourScreen,
  //           );
  //         }
  //         break;
  //
  //       case "external":
  //         {
  //           print("PrintingResults ${deepLink['url'].toString()}");
  //           Navigator.of(context)
  //               .pushNamed(RouteName.webViewScreen, arguments: {
  //             "code": null,
  //             "isStockDetails": false,
  //             "url": deepLink['url'].toString(),
  //             "isExternal": true,
  //             // "isNewsScreen" : true
  //           }).then((value) {
  //             if (value == "search") {
  //               context.read<BottomNavCubit>().updateIndex(1);
  //             }
  //           });
  //         }
  //         break;
  //
  //       default:
  //         {
  //           //statements;
  //         }
  //         break;
  //     }
  //   }
  // }

}
