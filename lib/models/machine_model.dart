class MachineModel {
  String id;
  String machineName;
  DateTime createdAt;
  String washerieId;
  bool isFunctional;
  DateTime finishesAt;

  MachineModel(
      {required this.id,
      required this.machineName,
      required this.createdAt,
      required this.washerieId,
      required this.isFunctional,
      required this.finishesAt});

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
        id: json['id'],
        machineName: json['machine_name'],
        createdAt: DateTime.parse(json['created_at']),
        washerieId: json['washerie_id'],
        isFunctional: json['is_functional'],
        finishesAt: DateTime.parse(json['finishes_at']));
  }
}
