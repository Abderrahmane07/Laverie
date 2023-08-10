class MachineModel {
  String id;
  DateTime createdAt;
  String washerieId;
  bool isFunctional;
  bool isRunning;
  DateTime finishesAt;

  MachineModel(
      {required this.id,
      required this.createdAt,
      required this.washerieId,
      required this.isFunctional,
      required this.isRunning,
      required this.finishesAt});

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        washerieId: json['washerie_id'],
        isFunctional: json['is_functional'],
        isRunning: json['is_running'],
        finishesAt: DateTime.parse(json['finishes_at']));
  }
}
