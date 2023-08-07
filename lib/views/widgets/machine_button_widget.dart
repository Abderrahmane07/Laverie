import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                const Text("Libre et fonctionnelle"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
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
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
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
            children: [
              Text(machineNumber),
              Text(machine.isFunctional.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
