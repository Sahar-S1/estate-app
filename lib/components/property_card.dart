import 'package:estate/models/property.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/properties/property',
          arguments: {
            'property': property,
          },
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg',
                  ),
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                color: Colors.redAccent,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
                color: theme.colorScheme.onPrimaryContainer,
                boxShadow: [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    property.address,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${property.marketValue}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium,
                  ),
                  Text(
                    'Carpet Area - ${property.carpetArea} m^2',
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    '${property.noOfRooms} BHK',
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
