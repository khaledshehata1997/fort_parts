class Address {
  Address({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.build,
    required this.floor,
    required this.isDefault,
  });

  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final String address;
  final String build;
  final String floor;
  final bool isDefault;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      name: json['name'],
      latitude: json['lat'],
      longitude: json['lng'],
      address: json['address'],
      build: json['build'],
      floor: json['flower'] ?? "",
      isDefault: json['default'] == 1,
    );
  }
}
