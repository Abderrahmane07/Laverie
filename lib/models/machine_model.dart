class MachineModel {
  /* changes made to handle stacking machines. */

  String id;
  String machineName;
  DateTime createdAt;
  String laundryId;
  bool isFunctional;
  DateTime finishesAt;
  int position;
  int orderInPosition;

  MachineModel(
      {required this.id,
      required this.machineName,
      required this.createdAt,
      required this.laundryId,
      required this.isFunctional,
      required this.finishesAt,
      required this.position,
      required this.orderInPosition});

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
        id: json['id'],
        machineName: json['machine_name'],
        createdAt: DateTime.parse(json['created_at']),
        laundryId: json['laundry_id'],
        isFunctional: json['is_functional'],
        finishesAt: DateTime.parse(json['finishes_at']),
        position: json['position'],
        orderInPosition: json['orderInPosition']);
  }
}
