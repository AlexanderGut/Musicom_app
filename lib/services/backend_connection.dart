import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:musicomapp/models/user.dart';
import 'package:http/http.dart' as http;

// Clase para la comunicación con el backend
//
// Esta clase engloba las diferentes peticiones http hacia el backend,
// con lo que se evita la repetición de codigo para consultas http,
// parseo de json y parseo de querystring
class BackendService {

  // base url del servicio backend
  final String _baseUrl = "http://192.168.0.10:5000/v1";
  // headers para las peticiones http
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer '
  };
  static const params = {};

  // instancia del objeto BackendService para patron singleton
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

  // función para optener la instancia del BackendService
  //
  // esta función retorna la instancia creada al iniciar la aplicación,
  // asegurando que solo exista una instancia de esta clase
  static BackendService getInstance() {
    if (_instance == null) {
      _instance = BackendService._internal();
    }
    return _instance;
  }

  // Función para realizar una petición get
  //
  // Esta función realiza un http request de tipo get al servicio backend
  // recibe un string con la extensión de la url y un Map opcional con los parametros
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

  // Función para realizar una petición post
  //
  // Esta función realiza un http request de tipo post al servicio backend
  // recibe un string con la extensión de la url y un map con los datos del body
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
  // Función para realizar una petición put
  //
  // Esta función realiza un http request de tipo put al servicio backend
  // recibe un string con la extensión de la url y un map con los datos del body
  Future<http.Response> put(String url, Map<String, dynamic> data) async {
    try {
      return await http.put(_baseUrl+url, headers: headers, body: jsonEncode(data));
    } catch (e) {
      return null;
    }
  }

  // Función para realizar una petición delete
  //
  // Esta función realiza un http request de tipo delete al servicio backend
  // recibe un string con la extensión de la url
  Future<http.Response> delete(String url) {
    return null;
  }

  // Función que inicializa cliente http
  initClient() {
    if (client == null) {
      client = http.Client();
    }
  }

  // Función que cierra la conexión con cliente http
  closeClient() {
    if (client != null) {
      client.close();
      client = null;
    }
  }

  // Función que genera una querystring
  //
  // Esta función genera una querystring en base a un map con los parametros
  String _getQueryString(Map<String, String> params) {
    String queryString = '?';
    List<Map<String, String>> paramsList = List();

    for (var i = 0; i < params.keys.toList().length; i++) {
      var key = params.keys.toList()[i];
      queryString += "$key=${params[key]}";
      if (i+1 < paramsList.length) {
        queryString += '&';
      }
    }
    return queryString;
  }
}