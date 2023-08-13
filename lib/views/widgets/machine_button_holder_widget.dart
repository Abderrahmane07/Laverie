import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/machine_model.dart';
import '../../models/machines_holder_model.dart';

class MachinesHolderButton extends StatefulWidget {
  final MachinesHolder machinesHolder;
  final double? height;
  final double? width;

  const MachinesHolderButton(
      {Key? key,
      required this.machinesHolder,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  State<MachinesHolderButton> createState() => _MachinesHolderButtonState();
}

class _MachinesHolderButtonState extends State<MachinesHolderButton> {
  late Timer _timer;
  int remainingTimeInMinutes = 0;
  // this map to get keep the remaining time updated.
  Map<MachineModel, int> remainingTime = {}; // might cause problems later.

  bool? isCheckedProblem = false;
  bool? isCheckedUpdate = false;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController updatingController = TextEditingController();

  int updateSingleMachineTime(MachineModel machine) {
    return max(
        0, machine.finishesAt.difference(DateTime.now().toUtc()).inMinutes);
  }

  void updateRemainingTime() {
    setState(() {
      widget.machinesHolder.stackedMachines.forEach((machine) {
        remainingTime[machine] = updateSingleMachineTime(machine);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    updateRemainingTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateRemainingTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {});
  }
}
