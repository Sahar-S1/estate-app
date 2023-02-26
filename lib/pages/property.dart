import 'dart:ui';

import 'package:estate/models/property.dart';
import 'package:estate/utils/directus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final property = arguments['property'] as Property;

    var theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Estate - ${property.address_name}"),
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.3,
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      children: [
                        getTableRow("Address", property.address),
                        getTableRow(
                            "Market Value", "₹${property.market_value}"),
                        getTableRow(
                            "Carpet Area", "${property.carpet_area} m^2"),
                        getTableRow("Rooms", "${property.rooms} BHK"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
