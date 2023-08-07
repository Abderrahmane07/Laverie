class MachinesModel {
  String id;
  DateTime createdAt;
  String washerieId;
  bool isFunctional;
  bool isRunning;
  DateTime finishesAt;

  MachinesModel(
      {required this.id,
      required this.createdAt,
      required this.washerieId,
      required this.isFunctional,
      required this.isRunning,
      required this.finishesAt});

  factory MachinesModel.fromJson(Map<String, dynamic> json) {
    return MachinesModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        washerieId: json['washerie_id'],
        isFunctional: json['is_functional'],
        isRunning: json['is_running'],
        finishesAt: DateTime.parse(json['finishes_at']));
  }
}



// is_running isRunning;

// response;
// machine1 = MachinesModel(response[0]['id'], response[0]['createdAt'],
//     response[0]['washerieId'], response[0]['isFunctional'],
//     response[0]['isRunning'], response[0]['finishesAt']);
// machine2 =MachineModel.fromJson(response[1]);    
