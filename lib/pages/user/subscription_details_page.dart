// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// // import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:insigh/components/z_button.dart';
//
// import '../../components/z_card.dart';
// import '../../models/app_control_links.dart';
// import '../../models_providers/app_provider.dart';
// import '../../models_providers/auth_provider.dart';
// import '../../utils/z_launch_url.dart';
//
// class SubscriptionDetailsPage extends StatefulWidget {
//   const SubscriptionDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   _SubscriptionDetailsPageState createState() => _SubscriptionDetailsPageState();
// }
//
// class _SubscriptionDetailsPageState extends State<SubscriptionDetailsPage> {
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     Future.microtask(() => Provider.of<AuthProvider>(context, listen: false).checkPurchasesStatus(getPackages: true));
//     super.initState();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       appBar: AppBar(
//         title: Text('Upgrade'),
//       ),
//       body: Stack(
//         children: [
//           _buildBody(),
//           if (isLoading)
//             GestureDetector(
//               onDoubleTap: () => setState(() => isLoading = false),
//               child: Container(
//                 color: Colors.black.withOpacity(0.1),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(),
//                     SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: Colors.orange)),
//                     SizedBox(height: Get.height * 0.225),
//                   ],
//                 ),
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   _buildBody() {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final entitlementInfos = authProvider.entitlementInfo;
//     final isLoadingEntitlementInfo = authProvider.isLoadingEntitlementInfo;
//     final packages = authProvider.packages;
//
//     if (isLoadingEntitlementInfo) return _buildLoading();
//     // if (null == null) return _buildNoSubscription(packages);
//     if (authProvider.authUser!.hasLifetime) return _buildSubscriptionLifetime();
//     if (entitlementInfos == null) return _buildNoSubscription(packages);
//     return _buildSubscription(packages);
//   }
//
//   Column _buildLoading() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(),
//         SizedBox(child: CircularProgressIndicator(color: Colors.white), height: 20, width: 20),
//         SizedBox(height: 8),
//         Text('loading...'),
//         SizedBox(height: 50),
//       ],
//     );
//   }
//
//   _buildNoSubscription(List<Package> packages) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     AppProvider appProvider = Provider.of<AppProvider>(context);
//     final AppControlLinks appControlLinks = appProvider.appControlLinks;
//     return Stack(
//       children: [
//         Scaffold(
//           body: ListView(
//             children: [
//               SizedBox(height: 32),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Get your first \nmonth for free', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
//                     SizedBox(height: 16),
//                     Text('Subscribe to one of our plans below and get instant \naccess to the latest sigals for the  Forex market.'),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 32),
//               for (var package in packages)
//                 ZCard(
//                   onTap: () => purchasePackage(package),
//                   borderRadiusColor: Color(0xFF2C2F38),
//                   color: Colors.transparent,
//                   child: Row(children: [
//                     Image.asset('assets/images/icon_subscription_thumbs_up.png', width: 40, height: 40),
//                     SizedBox(width: 16),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(package.storeProduct.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
//                         SizedBox(height: 4),
//                         Text(package.storeProduct.description, style: TextStyle(fontWeight: FontWeight.w300)),
//                       ],
//                     )
//                   ]),
//                 ),
//               SizedBox(height: 32),
//               if (!authProvider.authUser!.hasActiveSubscription)
//                 ZButton(
//                   margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
//                   isLoading: authProvider.isloadingRestorePurchases,
//                   text: 'Restore Purchases',
//                   onTap: () => authProvider.restorePurchases(),
//                 ),
//               ZCard(
//                 color: Colors.transparent,
//                 child: Column(
//                   children: [
//                     Text('Subscription details', style: TextStyle(color: Color(0xFFFDC413))),
//                     SizedBox(width: MediaQuery.of(context).size.width * .35, child: Divider(height: 1, thickness: 1, color: Color(0xFFFDC413)))
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ZCard(
//                     onTap: () {
//                       ZLaunchUrl.launchUrl(appControlLinks.privacy);
//                     },
//                     color: Colors.transparent,
//                     child: Text('Privacy Policy', style: TextStyle(color: Color(0xFFC1C1C1))),
//                   ),
//                   ZCard(
//                     onTap: () {
//                       ZLaunchUrl.launchUrl(appControlLinks.terms);
//                     },
//                     color: Colors.transparent,
//                     child: Text('Term of Use', style: TextStyle(color: Color(0xFFC1C1C1))),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   _buildSubscriptionLifetime() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(),
//         Image.asset('assets/images/success.png', height: 200),
//         SizedBox(height: 10),
//         Text('Congrats you have a lifetime subscription'),
//         SizedBox(height: 8),
//         Text('Continue using premium features!'),
//         SizedBox(height: Get.height * 0.1),
//         SizedBox(height: Get.height * 0.15),
//       ],
//     );
//   }
//
//   _buildSubscription(List<Package> packages) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final entitlementInfos = authProvider.entitlementInfo;
//     bool isEntitlementMonthly = entitlementInfos!.productIdentifier.contains('month') ? true : false;
//     String pricePeriod = isEntitlementMonthly ? 'monthly' : 'yearly';
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(),
//         Image.asset('assets/images/success.png', height: 200),
//         SizedBox(height: 10),
//         Text('Congrats you have an active ${pricePeriod} subscription'),
//         SizedBox(height: 8),
//         Text('Continue using premium features!'),
//         SizedBox(height: Get.height * 0.1),
//         //
//         if (isEntitlementMonthly)
//           Column(
//             children: [
//               Text('Upgrade to a yearly plan to save 17%!', style: TextStyle(fontWeight: FontWeight.bold)),
//               SizedBox(height: 8),
//             ],
//           ),
//         if (isEntitlementMonthly)
//           for (var package in packages)
//             if (package.storeProduct.identifier.contains('year'))
//               Stack(
//                 children: [
//                   ZCard(
//                       margin: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                       elevation: 1,
//                       onTap: () => purchasePackage(package),
//                       color: Colors.green,
//                       child: Column(
//                         children: [
//                           Row(),
//                           Text(getPricePeriod(package), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 5),
//                           Text('Upgrade to a yearly plan to save 17%', style: TextStyle(color: Colors.white)),
//                           SizedBox(height: 5),
//                         ],
//                       )),
//                   if (package.packageType != PackageType.monthly)
//                     Positioned(
//                         right: 40,
//                         top: 4,
//                         child: ZCard(
//                           color: Colors.orange,
//                           padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                           margin: EdgeInsets.symmetric(),
//                           child: Text('Save 17%'),
//                         ))
//                 ],
//               ),
//
//         SizedBox(height: Get.height * 0.15),
//       ],
//     );
//   }
//
//   checkIfStringContainsString(String string, String substring) {
//     return string.toLowerCase().contains(substring.toLowerCase());
//   }
//
//   void purchasePackage(Package package) async {
//     try {
//       isLoading = true;
//       setState(() => isLoading = true);
//       await Purchases.purchasePackage(package);
//       setState(() => isLoading = false);
//     } catch (e) {
//       setState(() => isLoading = false);
//       print(e);
//     }
//   }
//
//   getCardColor(Package package) {
//     if (package.packageType == PackageType.monthly) return Colors.lightBlue.shade300;
//     if (package.packageType == PackageType.annual) return Colors.purple.shade400;
//     return Colors.blue.shade400;
//   }
//
//   getPricePeriod(Package package) {
//     if (package.packageType == PackageType.monthly) return '${package.storeProduct.priceString}/m';
//     if (package.packageType == PackageType.annual) return '${package.storeProduct.priceString}/yr';
//     return 'yearly';
//   }
//
//   getYearlyPackage(packages) {
//     return packages.firstWhere((element) => element.packageType == PackageType.annual);
//   }
// }
