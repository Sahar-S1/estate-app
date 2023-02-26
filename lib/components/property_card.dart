import 'package:estate/models/property.dart';
import 'package:estate/utils/directus.dart';
import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final bool right;

  const PropertyCard({
    super.key,
    required this.property,
    this.right = false,
  });

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
      child: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            if (!right) image(theme),
            Expanded(
              child: details(theme),
            ),
            if (right) image(theme),
          ],
        ),
      ),
    );
  }

  Widget details(ThemeData theme) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: right ? Radius.circular(20) : Radius.zero,
          right: right ? Radius.zero : Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  right ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  property.address_name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment:
                      right ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.place_outlined,
                      size: 13,
                    ),
                    SizedBox(width: 3),
                    Text(
                      property.address_city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  '₹${property.market_value}',
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
    );
  }

  Widget image(ThemeData theme) {
    return Hero(
      tag: property.id,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(
              '${ENDPOINT}/assets/${property.thumbnail}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
