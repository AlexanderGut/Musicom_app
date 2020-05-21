import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:musicomapp/models/user.dart';
import 'package:http/http.dart' as http;

class BackendService {

  final String _baseUrl = "http://192.168.0.10:5000/v1";
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer '
  };
  static const params = {};

  static BackendService _instance;

  var client;

  BackendService._internal() {
    var _user = User.getInstance();
    if (_user != null) {
      headers['Authorization'] = 'Bearer ${_user.token}';
    } else {
      User.getData();
      headers['Authorization'] = 'Bearer ${User.getInstance().token}';
    }
    _instance = this;
  }

  static BackendService getInstance() {
    if (_instance == null) {
      _instance = BackendService._internal();
    }
    return _instance;
  }

  Future<http.Response> get(String url, {Map<String, String> params}) async {

    String queryString = '';
    if (params != null) {
      queryString = _getQueryString(params);
    }

    try {
      if (client != null) {
        return await client.get(_baseUrl + url + queryString, headers: headers);
      } else {
        return await http.get(_baseUrl + url + queryString, headers: headers);
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> data) async {
    try {
      if (client != null) {
        return await client.post(_baseUrl+url, headers: headers, body: jsonEncode(data));
      } else {
        return await http.post(_baseUrl+url, headers: headers, body: jsonEncode(data));
      }
    } catch (e) {
      return null;
    }
  }

  Future<http.Response> put(String url, Map<String, String> data) {

    return null;
  }

  Future<http.Response> delete(String url) {
    return null;
  }

  initClient() {
    if (client == null) {
      client = http.Client();
    }
  }

  closeClient() {
    if (client != null) {
      client.close();
      client = null;
    }
  }

  String _getQueryString(Map<String, String> params) {
    String queryString = '?';
    List<MapEntry<String, String>> paramsList = params.entries.map((p) => p);
    for (var i = 0; i < paramsList.length; i++) {
      queryString += "${paramsList[i].key}=${paramsList[i].value}";
      if (i+1 < paramsList.length) {
        queryString += '&';
      }
    }
    return queryString;
  }
}