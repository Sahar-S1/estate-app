import 'package:estate/models/property.dart';
import 'package:estate/utils/directus.dart';
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
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: property.id,
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        '${ENDPOINT}/assets/${property.thumbnail}',
                      ),
                    ),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8.0),
                    ),
                    color: theme.primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8.0),
                  ),
                  color: theme.colorScheme.onPrimaryContainer,
                  boxShadow: [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.address_name,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${property.market_value}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium,
                    ),
                    Text(
                      'Carpet Area - ${property.carpet_area} m^2',
                      style: theme.textTheme.labelSmall,
                    ),
                    Text(
                      '${property.rooms} BHK',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
