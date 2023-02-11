import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insigh/models/yahoo_finance_stock_data.dart';
import 'package:insigh/utils/api_routes.dart';

import '../models/advance_decline.dart';
import '../models/fincode_data_model.dart';

class CommonRepository {
  static Dio _dio = Dio();

  static Future<FinCodeDataModel> getLivePriceApi(String value) async{
    try {
      final response = await _dio.get(ApiRoutes.getLivePriceApi, queryParameters: {'finCodes' : value});
      return FinCodeDataModel.fromJson(response.data);

    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return FinCodeDataModel(data: null);
    }
  }
  static Future<YahooFinanceStockDataModel> getGlobalIndicesDataFromYahooFinance(String symbols) async{
    try {
      final response = await _dio.get(ApiRoutes.getLivePrice, queryParameters: {'symbols' : symbols});
      return YahooFinanceStockDataModel.fromJson(response.data);

    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return YahooFinanceStockDataModel(data: null);
    }
  }

  static Future<YahooFinanceStockDataModel> getLtpPrice(String symbols) async{
    try {
      final response = await _dio.get(ApiRoutes.getLivePrice, queryParameters: {'symbols' : symbols});
      return YahooFinanceStockDataModel.fromJson(response.data);

    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return YahooFinanceStockDataModel(data: null);
    }
  }

  static Future<AdvanceDeclineModel> getAdvanceDeclineList() async {
    try {
      final response = await _dio.get('https://www1.nseindia.com/common/json/indicesAdvanceDeclines.json');
      return AdvanceDeclineModel.fromJson(response.data);
    } catch (e) {
      return AdvanceDeclineModel.fromJson({});
    }
  }
}
