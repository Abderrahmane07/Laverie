class WasheriesModel {
  String id;
  DateTime createdAt;
  String ownerNumber;
  DateTime opensAt;
  DateTime closesAt;
  String name;
  String location;

  WasheriesModel(
      {required this.id,
      required this.createdAt,
      required this.ownerNumber,
      required this.opensAt,
      required this.closesAt,
      required this.name,
      required this.location});

  factory WasheriesModel.fromJson(Map<String, dynamic> json) {
    return WasheriesModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        ownerNumber: json['owner_number'],
        opensAt: DateTime.parse(json['opens_at']),
        closesAt: DateTime.parse(json['closes_at']),
        name: json['name'],
        location: json['location']);
  }
}
