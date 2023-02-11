// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:insigh/models/_parsers.dart';
// import 'package:insigh/constants/app_constants.dart';
//
// class RevenueCatSevice {
//   static String _androidKey = AppConstants.REVENUECAT_ANDROID_KEY;
//   static String _iosKey = AppConstants.REVENUECAT_IOS_KEY;
//
//   static String _apiKey = Platform.isIOS ? _iosKey : _androidKey;
//
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   static Future init() async {
//     PurchasesConfiguration configuration = PurchasesConfiguration(_apiKey);
//     await Purchases.configure(configuration);
//     await Purchases.setDebugLogsEnabled(true);
//   }
//
//   static Future<List<Offering>> getOfferings() async {
//     try {
//       final offering = await Purchases.getOfferings();
//       final current = offering.current;
//
//       return current == null ? [] : [current];
//     } catch (e) {
//       print(e);
//       return [];
//     }
//   }
//
//   static Future<List<Package>> getPackages() async {
//     try {
//       List<Offering> offerings = await RevenueCatSevice.getOfferings();
//       final _packages = offerings.map((e) => e.availablePackages).expand((element) => element).toList();
//       return _packages;
//     } catch (e) {
//       return [];
//     }
//   }
//
//   static Future<bool> purchasePackage(Package package) async {
//     try {
//       await Purchases.purchasePackage(package);
//       return true;
//     } catch (e) {
//       print('Error package ${e}');
//       return false;
//     }
//   }
//
//   static Future updateUserSub(EntitlementInfo entitlementInfo) async {
//     try {
//       User? fbUser = FirebaseAuth.instance.currentUser;
//       if (fbUser == null) return;
//
//       await _firestore.collection('users').doc(fbUser.uid).update({
//         'subRevenueCatBillingIssueDetectedAt': parseToDateTime(entitlementInfo.billingIssueDetectedAt),
//         'subRevenueCatExpirationDate': parseToDateTime(entitlementInfo.expirationDate),
//         'subRevenueCatIsActive': entitlementInfo.isActive,
//         'subRevenueCatIsSandbox': entitlementInfo.isSandbox,
//         'subRevenueCatLatestPurchaseDate': parseToDateTime(entitlementInfo.latestPurchaseDate),
//         'subRevenueCatOriginalPurchaseDate': parseToDateTime(entitlementInfo.originalPurchaseDate),
//         'subRevenueCatPeriodType': entitlementInfo.periodType.toString(),
//         'subRevenueCatProductIdentifier': entitlementInfo.productIdentifier,
//         'subRevenueCatUnsubscribeDetectedAt': parseToDateTime(entitlementInfo.unsubscribeDetectedAt),
//         'subRevenueCatWillRenew': entitlementInfo.willRenew,
//       });
//
//       return true;
//     } catch (e) {
//       print('Error package ${e}');
//       return false;
//     }
//   }
// }
