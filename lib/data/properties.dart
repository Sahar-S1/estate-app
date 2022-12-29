import 'package:estate/models/property.dart';

List<Property> properties = List.of([
  Property(
    id: 1,
    address: "Ulhasnagar",
    marketValue: 20000000,
    carpetArea: 500,
    noOfRooms: 2,
    type: "flat",
    saleType: "rent",
    facilities: List.of([
      "Continuous Water Supply",
      "0% Electrical Cutouts",
    ]),
    amenities: List.of([
      "Clubhouse",
      "Swimming Pool",
      "Gym",
    ]),
    images: List.of([]),
    brokerId: 1,
  ),
  Property(
    id: 2,
    address: "Kalyan",
    marketValue: 30000000,
    carpetArea: 1000,
    noOfRooms: 3,
    type: "flat",
    saleType: "buy",
    facilities: List.of([
      "Continuous Water Supply",
      "0% Electrical Cutouts",
      "24/7 Security",
    ]),
    amenities: List.of([
      "Clubhouse",
      "Swimming Pool",
      "Gym",
    ]),
    images: List.of([]),
    brokerId: 2,
  ),
  Property(
    id: 3,
    address: "Wadala",
    marketValue: 15000000,
    carpetArea: 750,
    noOfRooms: 2,
    type: "flat",
    saleType: "pg",
    facilities: List.of([
      "Continuous Water Supply",
    ]),
    amenities: List.of([
      "Clubhouse",
      "Gym",
    ]),
    images: List.of([]),
    brokerId: 3,
  ),
]);
