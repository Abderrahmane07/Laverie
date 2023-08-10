class ProblemModel {
  String id;
  DateTime createdAt;
  String machineId;
  String textDescription;

  ProblemModel(
      {required this.id,
      required this.createdAt,
      required this.machineId,
      required this.textDescription});

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        machineId: json['machine_id'],
        textDescription: json['text_description']);
  }
}
