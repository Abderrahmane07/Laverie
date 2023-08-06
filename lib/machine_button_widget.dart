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
            title: const Text(
              'Confirm Deletion',
            ),
            content: const Text(
              'Are you sure you want to delete these assets?',
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {},
              ),
              TextButton(
                child: const Text('Delete'),
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
