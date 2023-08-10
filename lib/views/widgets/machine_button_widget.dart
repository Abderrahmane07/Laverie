import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/machine_model.dart';

class MachineButton extends StatefulWidget {
  final String machineNumber;
  final double? height;
  final MachineModel machine;
  final double? width;

  const MachineButton({
    Key? key,
    required this.machineNumber,
    required this.machine,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<MachineButton> createState() => _MachineButtonState();
}

class _MachineButtonState extends State<MachineButton> {
  late Timer _timer;
  int remainingTimeInMinutes = 0;

  void updateRemainingTime() {
    final remaining =
        (widget.machine.finishesAt.difference(DateTime.now().toUtc()))
            .inMinutes;
    setState(() {
      remainingTimeInMinutes = remaining > 0 ? remaining : 0;
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
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController updatingController = TextEditingController();
    void openDialogfForSignalingAProblem() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signaler un problème'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Veuillez décrire le problème:'),
                const SizedBox(height: 20),
                Row(
                  children: [],
                ),
                const SizedBox(height: 20),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Envoyer'),
                onPressed: () async {
                  final description = descriptionController.text;
                  await Supabase.instance.client.from('problems').insert(
                    {
                      'machine_id': widget.machine.id,
                      'text_description': description,
                      'created_at': DateTime.now().toUtc().toString(),
                    },
                  );
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    void openDialogfUpdatingAMachine() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Changer le temps restant'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Combien de temps reste-t-il ?'),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  controller: updatingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '66 min',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Mettre à jour'),
                onPressed: () async {
                  final updating = updatingController.text;
                  await Supabase.instance.client.from('machines').update(
                    {
                      'finishes_at': (DateTime.now()
                              .toUtc()
                              .add(Duration(minutes: int.parse(updating))))
                          .toString(),
                    },
                  ).eq('id', widget.machine.id);
                  print("id: ${widget.machine.id}");
                  print('updating: $updating');
                  print(
                      'finishes_at: ${DateTime.now().toUtc().add(Duration(minutes: int.parse(updating)))}');
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    void openDialogForMachine() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "L'état de la machine ${widget.machineNumber} est:",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.machine.isFunctional && remainingTimeInMinutes == 0)
                  const Text("Libre et fonctionnelle"),
                if (widget.machine.isFunctional && remainingTimeInMinutes > 0)
                  Text(
                      "Fonctionnelle, temps restant :${remainingTimeInMinutes.toString()}min"),
                if (!widget.machine.isFunctional) const Text("Hors service"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    if (widget.machine.isFunctional)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    if (!widget.machine.isFunctional)
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).pop();
                        openDialogfUpdatingAMachine();
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Signaler un problème'),
                onPressed: () {
                  Navigator.of(context).pop();
                  openDialogfForSignalingAProblem();
                },
              ),
              TextButton(
                child: const Text('Okey'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        openDialogForMachine();
      },
      child: Container(
        height: widget.height ?? 80,
        width: widget.width ?? MediaQuery.of(context).size.width / 6,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.machineNumber),
              const SizedBox(height: 10),
              if (widget.machine.isFunctional && remainingTimeInMinutes == 0)
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              if (widget.machine.isFunctional && remainingTimeInMinutes > 0)
                Text("${remainingTimeInMinutes.toString()} min",
                    style: const TextStyle(color: Colors.green)),
              if (!widget.machine.isFunctional)
                const Icon(
                  Icons.error,
                  color: Colors.red,
                )
            ],
          ),
        ),
      ),
    );
  }
}
