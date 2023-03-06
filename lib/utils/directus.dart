import 'package:dio/dio.dart';
import 'package:estate/models/property.dart';

const ENDPOINT = "https://app.se.vsit.appsinfra.in";

final dio = Dio(
  BaseOptions(
    baseUrl: ENDPOINT,
  ),
);

String asset(String assetId) {
  return '$ENDPOINT/assets/$assetId';
}

Future<List<Property>> getProperties() async {
  var res = await dio.get('/items/property');
  return (res.data['data'] as List<dynamic>)
      .map((e) => Property.fromMap(e))
      .toList();
}

Future<List<String>> getSliderImages({String city = "Thane"}) async {
  var res = await dio.get(
    '/items/slider',
    queryParameters: {
      "filter": {
        "city": {
          "_eq": city,
        }
      }
    },
  );
  return (res.data['data'] as List<dynamic>)
      .map((e) => asset(e["image"] as String))
      .toList();
}
