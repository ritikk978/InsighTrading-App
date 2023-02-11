// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser()
  ..id = json['id'] as String?
  ..email = json['email'] as String? ?? ''
  ..referalCode = json['referalCode'] as String? ?? ''
  ..isAnonymous = json['isAnonymous'] as bool? ?? true
  ..favoritesSignals = (json['favoritesSignals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..isNotificationsEnabled = json['isNotificationsEnabled'] as bool? ?? true
  ..timestampLastLogin = parseToDateTime(json['timestampLastLogin'])
  ..timestampCreated = parseToDateTime(json['timestampCreated'])
  ..subRevenueCatIsActive = json['subRevenueCatIsActive'] as bool? ?? false
  ..subRevenueCatWillRenew = json['subRevenueCatWillRenew'] as bool? ?? false
  ..subRevenueCatPeriodType = json['subRevenueCatPeriodType'] as String? ?? ''
  ..subRevenueCatProductIdentifier =
      json['subRevenueCatProductIdentifier'] as String? ?? ''
  ..subRevenueCatIsSandbox = json['subRevenueCatIsSandbox'] as bool? ?? false
  ..subRevenueCatOriginalPurchaseDate =
      parseToDateTime(json['subRevenueCatOriginalPurchaseDate'])
  ..subRevenueCatLatestPurchaseDate =
      parseToDateTime(json['subRevenueCatLatestPurchaseDate'])
  ..subRevenueCatExpirationDate =
      parseToDateTime(json['subRevenueCatExpirationDate'])
  ..subRevenueCatUnsubscribeDetectedAt =
      parseToDateTime(json['subRevenueCatUnsubscribeDetectedAt'])
  ..subRevenueCatBillingIssueDetectedAt =
      parseToDateTime(json['subRevenueCatBillingIssueDetectedAt'])
  ..subIsLifetime = json['subIsLifetime'] as bool? ?? false;

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'referalCode': instance.referalCode,
      'isAnonymous': instance.isAnonymous,
      'favoritesSignals': instance.favoritesSignals,
      'isNotificationsEnabled': instance.isNotificationsEnabled,
      'timestampLastLogin': parseToDateTime(instance.timestampLastLogin),
      'timestampCreated': parseToDateTime(instance.timestampCreated),
      'subRevenueCatIsActive': instance.subRevenueCatIsActive,
      'subRevenueCatWillRenew': instance.subRevenueCatWillRenew,
      'subRevenueCatPeriodType': instance.subRevenueCatPeriodType,
      'subRevenueCatProductIdentifier': instance.subRevenueCatProductIdentifier,
      'subRevenueCatIsSandbox': instance.subRevenueCatIsSandbox,
      'subRevenueCatOriginalPurchaseDate':
          parseToDateTime(instance.subRevenueCatOriginalPurchaseDate),
      'subRevenueCatLatestPurchaseDate':
          parseToDateTime(instance.subRevenueCatLatestPurchaseDate),
      'subRevenueCatExpirationDate':
          parseToDateTime(instance.subRevenueCatExpirationDate),
      'subRevenueCatUnsubscribeDetectedAt':
          parseToDateTime(instance.subRevenueCatUnsubscribeDetectedAt),
      'subRevenueCatBillingIssueDetectedAt':
          parseToDateTime(instance.subRevenueCatBillingIssueDetectedAt),
      'subIsLifetime': instance.subIsLifetime,
    };
