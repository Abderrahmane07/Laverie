class LaundryModel {
  String id;
  DateTime createdAt;
  String ownerNumber;
  DateTime opensAt;
  DateTime closesAt;
  String name;
  String location;

  LaundryModel(
      {required this.id,
      required this.createdAt,
      required this.ownerNumber,
      required this.opensAt,
      required this.closesAt,
      required this.name,
      required this.location});

  factory LaundryModel.fromJson(Map<String, dynamic> json) {
    return LaundryModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        ownerNumber: json['owner_number'],
        opensAt: DateTime.parse(json['opens_at']),
        closesAt: DateTime.parse(json['closes_at']),
        name: json['name'],
        location: json['location']);
  }
}
