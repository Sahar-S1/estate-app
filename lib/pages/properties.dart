import 'package:estate/components/property_card.dart';
import 'package:estate/utils/directus.dart';
import 'package:flutter/material.dart';

class PropertiesPage extends StatelessWidget {
  const PropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estate - Properties"),
      ),
      body: FutureBuilder(
        future: getProperties(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR - ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          assert(snapshot.hasData);
          var properties = snapshot.data!;
          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (ctx, idx) {
              var property = properties[idx];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PropertyCard(property: property),
              );
            },
          );
        },
      ),
    );
  }
}
