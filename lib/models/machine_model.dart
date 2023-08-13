class MachineModel {
  String id;
  String machineName;
  DateTime createdAt;
  String laundryId;
  MachineType machineType;
  bool isFunctional;
  DateTime finishesAt;

  MachineModel({
    required this.id,
    required this.machineName,
    required this.createdAt,
    required this.laundryId,
    required this.machineType,
    required this.isFunctional,
    required this.finishesAt,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      id: json['id'],
      machineName: json['machine_name'],
      createdAt: DateTime.parse(json['created_at']),
      laundryId: json['laundry_id'],
      machineType: _parseMachineType(json['machine_type']),
      isFunctional: json['is_functional'],
      finishesAt: DateTime.parse(json['finishes_at']),
    );
  }
}

MachineType _parseMachineType(String machineType) {
  switch (machineType) {
    case 'washer':
      return MachineType.washer;
    case 'dryer':
      return MachineType.dryer;
    case 'coffeeMachine':
      return MachineType.coffeeMachine;
    case 'vendingMachine':
      return MachineType.vendingMachine;
    default:
      throw Exception('Unknown machine type: $machineType');
  }
}

enum MachineType { washer, dryer, coffeeMachine, vendingMachine }
