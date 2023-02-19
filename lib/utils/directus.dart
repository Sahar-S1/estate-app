import 'package:dio/dio.dart';
import 'package:estate/models/property.dart';

const ENDPOINT = "https://app.se.vsit.appsinfra.in";

final dio = Dio(
  BaseOptions(
    baseUrl: ENDPOINT,
  ),
);

Future<List<Property>> getProperties() async {
  var res = await dio.get('/items/property');
  return (res.data['data'] as List<dynamic>)
      .map((e) => Property.fromMap(e))
      .toList();
}
