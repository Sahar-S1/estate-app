import 'package:flutter/material.dart';

import '/pages/home.dart';
import '/pages/profile.dart';
import '/pages/properties.dart';
import '/pages/property.dart';
import '/pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/search': (context) => const SearchPage(),
        '/properties': (context) => const PropertiesPage(),
        '/properties/property': (context) => const PropertyPage(),
      },
      initialRoute: '/',
    );
  }
}
