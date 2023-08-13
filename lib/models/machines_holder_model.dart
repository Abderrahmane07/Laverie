import 'package:laverie/models/machine_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// this class corresponds to the table position in the database.
class MachinesHolder {
  int position;
  List<MachineModel>
      stackedMachines; // this is an ordered list that contains stacked tables in one position.

  MachinesHolder({required this.position, required this.stackedMachines});

  Future<MachinesHolder> fromJson(Map<String, dynamic> json) async {
    int position = json['position'];

    List<MachineModel> machinesList =
        await getMachinesFromIds(json['stacked_machines']);
    return MachinesHolder(position: position, stackedMachines: machinesList);
  }

  Future<List<MachineModel>> getMachinesFromIds(
      String stackedMachineIds) async {
    List<String> machineIds = stackedMachineIds.split(',').toList();

    // Assuming you have a method to fetch machines by ID from your database
    List<MachineModel> machines = await fetchMachinesByIds(machineIds);

    return machines;
  }

  Future<List<MachineModel>> fetchMachinesByIds(List<String> machineIds) async {
    List<MachineModel> machines = [];

    await Supabase.instance.client
        .from('machines')
        .select()
        .in_('id', machineIds);

    return machines;
  }

  String machinesToString() {
    String result = "";

    this.stackedMachines.forEach((e) => "${result}/${e.machineName}");

    return result;
  }
}
