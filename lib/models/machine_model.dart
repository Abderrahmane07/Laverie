class MachineModel {
  String id;
  String machineName;
  DateTime createdAt;
  String laundryId;
  bool isFunctional;
  DateTime finishesAt;

  MachineModel(
      {required this.id,
      required this.machineName,
      required this.createdAt,
      required this.laundryId,
      required this.isFunctional,
      required this.finishesAt});

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
        id: json['id'],
        machineName: json['machine_name'],
        createdAt: DateTime.parse(json['created_at']),
        laundryId: json['laundry_id'],
        isFunctional: json['is_functional'],
        finishesAt: DateTime.parse(json['finishes_at']));
  }
}
