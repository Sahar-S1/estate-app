import 'package:estate/components/PropertyCard.dart';
import 'package:estate/data/properties.dart';
import 'package:flutter/material.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estate - Properties"),
      ),
      body: GridView.builder(
        itemCount: 100,
        itemBuilder: (ctx, idx) {
          var property = properties[idx % properties.length];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PropertyCard(property: property),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }
}
