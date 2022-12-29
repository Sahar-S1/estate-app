import 'dart:convert';

class Property {
  final int id;
  final String address;
  final double marketValue;
  final double carpetArea;
  final int noOfRooms;
  final String type;
  final String saleType;
  final List<String> facilities;
  final List<String> amenities;
  final List<String> images;
  final int brokerId;

  Property({
    required this.id,
    required this.address,
    required this.marketValue,
    required this.carpetArea,
    required this.noOfRooms,
    required this.type,
    required this.saleType,
    required this.facilities,
    required this.amenities,
    required this.images,
    required this.brokerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'marketValue': marketValue,
      'carpetArea': carpetArea,
      'noOfRooms': noOfRooms,
      'type': type,
      'saleType': saleType,
      'facilities': facilities,
      'amenities': amenities,
      'images': images,
      'brokerId': brokerId,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'] as int,
      address: map['address'] as String,
      marketValue: map['marketValue'] as double,
      carpetArea: map['carpetArea'] as double,
      noOfRooms: map['noOfRooms'] as int,
      type: map['type'] as String,
      saleType: map['saleType'] as String,
      facilities: List<String>.from((map['facilities'] as List<String>)),
      amenities: List<String>.from((map['amenities'] as List<String>)),
      images: List<String>.from((map['images'] as List<String>)),
      brokerId: map['brokerId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Property(id: $id, address: $address, marketValue: $marketValue, carpetArea: $carpetArea, noOfRooms: $noOfRooms, type: $type, saleType: $saleType, facilities: $facilities, amenities: $amenities, images: $images, brokerId: $brokerId)';
  }
}
