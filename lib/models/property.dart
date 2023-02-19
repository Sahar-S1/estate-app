import 'dart:convert';

class Property {
  final int id;
  final String address_number;
  final String address_name;
  final String address_street;
  final String address_city;
  final String address_state;
  final int address_pincode;
  final double market_value;
  final double carpet_area;
  final int rooms;
  final String type;
  final String sale_type;
  final List<String> facilities;
  final List<String> amenities;
  final String thumbnail;

  String get address {
    return [
      address_number,
      address_name,
      address_street,
      address_city,
      address_state,
      address_pincode,
    ].join(", ");
  }

  Property({
    required this.id,
    required this.address_number,
    required this.address_name,
    required this.address_street,
    required this.address_city,
    required this.address_state,
    required this.address_pincode,
    required this.market_value,
    required this.carpet_area,
    required this.rooms,
    required this.type,
    required this.sale_type,
    required this.facilities,
    required this.amenities,
    required this.thumbnail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address_number': address_number,
      'address_name': address_name,
      'address_street': address_street,
      'address_city': address_city,
      'address_state': address_state,
      'address_pincode': address_pincode,
      'market_value': market_value,
      'carpet_area': carpet_area,
      'rooms': rooms,
      'type': type,
      'sale_type': sale_type,
      'facilities': facilities,
      'amenities': amenities,
      'thumbnail': thumbnail,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'] as int,
      address_number: map['address_number'] as String,
      address_name: map['address_name'] as String,
      address_street: map['address_street'] as String,
      address_city: map['address_city'] as String,
      address_state: map['address_state'] as String,
      address_pincode: map['address_pincode'] as int,
      market_value: map['market_value'] as double,
      carpet_area: map['carpet_area'] as double,
      rooms: map['rooms'] as int,
      type: map['type'] as String,
      sale_type: map['sale_type'] as String,
      facilities: List<String>.from((map['facilities'] as List<dynamic>)),
      amenities: List<String>.from((map['amenities'] as List<dynamic>)),
      thumbnail: map['thumbnail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Property.fromJson(String source) =>
      Property.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Property(id: $id, address_number: $address_number, address_name: $address_name, address_street: $address_street, address_city: $address_city, address_state: $address_state, address_pincode: $address_pincode, market_value: $market_value, carpet_area: $carpet_area, rooms: $rooms, type: $type, sale_type: $sale_type, facilities: $facilities, amenities: $amenities, thumbnail: $thumbnail)';
  }
}
