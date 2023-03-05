import 'dart:ui';

import 'package:estate/models/property.dart';
import 'package:estate/utils/directus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PropertyPage extends StatelessWidget {
  final Property property;

  const PropertyPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    var isFavorite = false;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "${ENDPOINT}/assets/${property.thumbnail}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Positioned(
                top: size.height * .075,
                left: size.width * .1,
                child: Hero(
                  tag: property.id,
                  child: Image.network(
                    "${ENDPOINT}/assets/${property.thumbnail}",
                    width: size.width * .8,
                    height: size.height * .3,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property.address_name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                              property.address,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 80),
                      Text(
                        '₹ ${(property.market_value / 10000000).toStringAsFixed(2)} Cr',
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        var items = [
                          {
                            "icon": Icons.bed,
                            "value": "${property.rooms} Bedrooms",
                          },
                          {
                            "icon": Icons.straighten,
                            "value": "${property.carpet_area} m^2"
                          },
                          if (property.facilities.contains("water_supply"))
                            {"icon": Icons.water_drop, "value": "Water Supply"},
                          if (property.facilities.contains("security"))
                            {"icon": Icons.security, "value": "Security"},
                          if (property.facilities.contains("backup_power"))
                            {
                              "icon": Icons.battery_saver,
                              "value": "Backup Power"
                            },
                          if (property.facilities.contains("parking"))
                            {"icon": Icons.local_parking, "value": "Parking"},
                          if (property.amenities.contains("swimming_pool"))
                            {"icon": Icons.pool, "value": "Swimming Pool"},
                          if (property.amenities.contains("gym"))
                            {"icon": Icons.fitness_center, "value": "Gym"},
                          if (property.amenities.contains("park"))
                            {"icon": Icons.park, "value": "Park"},
                          if (property.amenities.contains("club_house"))
                            {"icon": Icons.sports_tennis, "value": "Clubhouse"},
                        ];
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) => Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade900,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Icon(
                                    items[index]["icon"] as IconData,
                                    color: Colors.lightBlue.shade400,
                                  ),
                                ),
                                Text(
                                  items[index]["value"] as String,
                                  style: TextStyle(
                                    color: Colors.lightBlue.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        );
                      },
                    ),
                  ),
                  const Divider(thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.phone),
                        label: Text('Contact Broker'),
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return IconButton(
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Table getPropertyTable(ThemeData theme, Property property) {
    TableRow getTableRow(String heading, String value) {
      return TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                heading,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                value,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      );
    }

    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: [
        getTableRow("Address", property.address),
        getTableRow("Market Value", "₹${property.market_value}"),
        getTableRow("Carpet Area", "${property.carpet_area} m^2"),
        getTableRow("Rooms", "${property.rooms} BHK"),
      ],
    );
  }
}
