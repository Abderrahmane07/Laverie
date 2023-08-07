class ProblemsModel {
  String id;
  DateTime createdAt;
  String machineId;
  String textDescription;

  ProblemsModel(
      {required this.id,
      required this.createdAt,
      required this.machineId,
      required this.textDescription});

  factory ProblemsModel.fromJson(Map<String, dynamic> json) {
    return ProblemsModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        machineId: json['machine_id'],
        textDescription: json['text_description']);
  }
}
