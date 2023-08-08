import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/machines_model.dart';

class MachineButton extends StatelessWidget {
  final String machineNumber;
  final double? height;
  final MachinesModel machine;
  final double? width;

  const MachineButton({
    Key? key,
    required this.machineNumber,
    required this.machine,
    this.height,
    this.width,
  }) : super(key: key);

  int getRemainingTime() {
    final remaining = (machine.finishesAt.difference(DateTime.now())).inMinutes;
    if (remaining > 0) return remaining;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    void openDialogfForSignalingAProblem() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signaler un problème'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Veuillez décrire le problème:'),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
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
                  await Supabase.instance.client.from('problems').insert(
                    {
                      'machine_id': machine.id,
                      'text_description': 'description',
                      'created_at': DateTime.now().toString(),
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

    void openDialogForMachine() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "L'état de la machine $machineNumber est:",
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (machine.isFunctional && getRemainingTime() == 0)
                  const Text("Libre et fonctionnelle"),
                if (machine.isFunctional && getRemainingTime() > 0)
                  Text(
                      "Fonctionnelle, temps restant :${getRemainingTime().toString()}min"),
                if (!machine.isFunctional) const Text("Hors service"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    if (machine.isFunctional)
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    if (!machine.isFunctional)
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
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
        height: height ?? 80,
        width: width ?? MediaQuery.of(context).size.width / 6,
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
              Text(machineNumber),
              const SizedBox(height: 10),
              if (machine.isFunctional && getRemainingTime() == 0)
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              if (machine.isFunctional && getRemainingTime() > 0)
                Text("${getRemainingTime().toString()} min",
                    style: const TextStyle(color: Colors.green)),
              if (!machine.isFunctional)
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
