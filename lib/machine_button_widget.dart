import 'package:flutter/material.dart';

class MachineButton extends StatelessWidget {
  final String machineNumber;
  final double? height;
  final double? width;

  const MachineButton({
    Key? key,
    required this.machineNumber,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('Libre'),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text('En cours'),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text('Hors service'),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('En panne'),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: const Text('En maintenance'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Signaler un problème'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('Okey'),
                onPressed: () {},
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        // print('machine $machineNumber tapped');
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
        child: Center(child: Text(machineNumber)),
      ),
    );
  }
}
