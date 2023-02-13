import 'package:estate/models/property.dart';
import 'package:flutter/material.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final property = arguments['property'] as Property;

    return Scaffold(
      appBar: AppBar(
        title: Text("Estate - ${property.address}"),
      ),
      body: Container(),
    );
  }
}
