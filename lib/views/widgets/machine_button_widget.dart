import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/machine_model.dart';

class MachineButton extends StatefulWidget {
  final MachineModel machine;
  final double? height;
  final double? width;

  const MachineButton({
    Key? key,
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
  bool? isCheckedProblem = false;
  bool? isCheckedUpdate = false;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController updatingController = TextEditingController();

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

  void openDialogForMachine() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "L'état de la machine ${widget.machine.machineName} est:",
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
            widget.machine.isFunctional
                ? TextButton(
                    child: const Text('Signaler un problème'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      openDialogfForSignalingAProblem();
                    },
                  )
                : Container(),
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

  void openDialogfForSignalingAProblem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signaler un problème'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Veuillez décrire le problème :'),
              const SizedBox(height: 20),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 20),
              StatefulBuilder(builder: (context, _setState) {
                return CheckboxListTile(
                  value: isCheckedProblem,
                  onChanged: (value) {
                    print(value);
                    _setState(() {
                      isCheckedProblem = value;
                    });
                  },
                  title: const Text('Machine en panne'),
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
                // Here I want to open back the openDialogForMachine
                openDialogForMachine();
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
                if (isCheckedProblem!) {
                  await Supabase.instance.client.from('machines').update(
                    {
                      'is_functional': false,
                    },
                  ).eq('id', widget.machine.id);
                  // setState(() {
                  widget.machine.isFunctional = false;
                  // });
                }
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
              const SizedBox(height: 20),
              !widget.machine.isFunctional
                  ? StatefulBuilder(builder: (context, _setState) {
                      return CheckboxListTile(
                        value: isCheckedUpdate,
                        onChanged: (value) {
                          print(value);
                          _setState(() {
                            isCheckedUpdate = value;
                          });
                        },
                        title: const Text('Machine à marche'),
                      );
                    })
                  : Container(),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
                openDialogForMachine();
              },
            ),
            TextButton(
              child: const Text('Mettre à jour'),
              onPressed: () async {
                final updating = updatingController.text;
                await Supabase.instance.client
                    .from('machines')
                    .update(isCheckedUpdate!
                        ? {
                            'finishes_at': (DateTime.now().toUtc().add(
                                    Duration(minutes: int.parse(updating))))
                                .toString(),
                            'is_functional': true,
                          }
                        : {
                            'finishes_at': (DateTime.now().toUtc().add(
                                    Duration(minutes: int.parse(updating))))
                                .toString(),
                          })
                    .eq('id', widget.machine.id);
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

  @override
  Widget build(BuildContext context) {
    print('mamamam');

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
              Text(widget.machine.machineName),
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
