import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 115, 125, 212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: const Center(child: Text('ad zone')),
            ),
            const Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      MachineButton(machineNumber: '1'),
                      MachineButton(machineNumber: '2'),
                      MachineButton(machineNumber: '3'),
                      MachineButton(machineNumber: '4'),
                      MachineButton(machineNumber: '5'),
                      MachineButton(machineNumber: '6'),
                    ],
                  ),
                  Text(
                    'Laverie details here',
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: const Center(child: Text('ad zone')),
            ),
          ],
        ),
      ),
    );
  }
}

class MachineButton extends StatelessWidget {
  final String machineNumber;
  const MachineButton({
    Key? key,
    required this.machineNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('machine $machineNumber tapped');
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 6,
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
