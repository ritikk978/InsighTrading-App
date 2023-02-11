import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiUsersService {
  static Dio _dio = Dio();

  static Future<bool?> deleteAccount() async {
    try {
      var ref = await FirebaseFirestore.instance.collection('appControlsPublic').doc('appInfo').get();
      String? _baseUrl = ref.data()?['frontendUrl'];
      if (_baseUrl == null || _baseUrl == '') throw Exception('Api Url is not set');
      if (_baseUrl.endsWith('/')) _baseUrl = _baseUrl.substring(0, _baseUrl.length - 1);

      User? fbUser = FirebaseAuth.instance.currentUser;
      String? jsonWebToken = await fbUser?.getIdToken();
      if (jsonWebToken == null) return null;

      await _dio.patch(_baseUrl + '/api/user-delete-account', data: {'jsonWebToken': jsonWebToken}, options: Options(receiveTimeout: 5000));

      return true;
    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return false;
    }
  }
}
