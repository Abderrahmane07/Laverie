import 'package:flutter/material.dart';

import 'machine_button_widget.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 120),
                  MachineButton(
                    machineNumber: '8/9',
                    width: 90,
                    height: 90,
                  ),
                  MachineButton(
                    machineNumber: '10',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(height: 40),
                  MachineButton(
                    machineNumber: '',
                    width: 20,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      MachineButton(
                        machineNumber: 'cookie',
                        width: 90,
                        height: 90,
                      ),
                      SizedBox(width: 40),
                      MachineButton(
                        machineNumber: 'coffee',
                        width: 90,
                        height: 90,
                      ),
                    ],
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
