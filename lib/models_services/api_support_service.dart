import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insigh/models/support.dart';

class ApiService {
  static Dio _dio = Dio();

  static Future<bool?> sendSupportEmail({required Support support}) async {
    var ref = await FirebaseFirestore.instance.collection('appControlsPublic').doc('appInfo').get();
    String? _baseUrl = ref.data()?['frontendUrl'];
    if (_baseUrl == null || _baseUrl == '') throw Exception('Api Url is not set');
    if (_baseUrl.endsWith('/')) _baseUrl = _baseUrl.substring(0, _baseUrl.length - 1);

    User? fbUser = FirebaseAuth.instance.currentUser;
    String? jsonWebToken = await fbUser?.getIdToken();
    if (jsonWebToken == null) throw Exception('User is not logged in');

    try {
      print({'jsonWebToken': jsonWebToken, ...support.toJson()});
      Response response = await _dio.post(_baseUrl + '/api/contact', data: {...support.toJson(), 'jsonWebToken': jsonWebToken});
      print(response.data);
      return true;
    } on DioError catch (e) {
      log('response ${e}');
      log('response ${e.response?.data['message']}');
      return false;
    }
  }
}
