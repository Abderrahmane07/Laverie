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
        opensAt: _parseTime(json['opens_at']),
        closesAt: _parseTime(json['closes_at']),
        name: json['name'],
        location: json['location']);
  }
}

DateTime _parseTime(String timeString) {
  // Split the time string and extract the time and timezone offset parts
  final timeAndOffset = timeString.split('+');
  final timePart = timeAndOffset[0]; // '22:00:00'
  final offsetPart = timeAndOffset[1]; // '02'

  // Parse the time part into hours, minutes, and seconds
  final timeParts = timePart.split(':');
  final hour = int.parse(timeParts[0]);
  final minute = int.parse(timeParts[1]);
  final second = int.parse(timeParts[2]);

  // Parse the offset part into an integer
  final offset = int.parse(offsetPart);

  // Create a Duration object for the offset
  final offsetDuration = Duration(hours: offset);

  // Create a DateTime object by combining the time and offset
  final dateTime = DateTime(0, 1, 1, hour, minute, second).add(offsetDuration);

  return dateTime;
}
