import 'package:flutter/material.dart';
import 'package:laverie/models/machines_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/machine_button_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MachinesModel machine1;
  late MachinesModel machine2;
  late MachinesModel machine3;
  late MachinesModel machine4;
  late MachinesModel machine5;
  late MachinesModel machine6;
  Future<void> _machinesData() async {
    final response = await Supabase.instance.client
        .from('machines')
        .select()
        .eq('washerie_id', 'eb16c09e-4a36-4d8e-a790-5556b36273e5');
    print(response);
    machine1 = MachinesModel.fromJson(response[0]);
    machine2 = MachinesModel.fromJson(response[1]);
    machine3 = MachinesModel.fromJson(response[2]);
    machine4 = MachinesModel.fromJson(response[3]);
    machine5 = MachinesModel.fromJson(response[4]);
    machine6 = MachinesModel.fromJson(response[5]);
    print("machine1: $machine1");
  }

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
            Expanded(
              child: FutureBuilder(
                future: _machinesData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MachineButton(
                                machineNumber: '6', machine: machine5),
                            MachineButton(
                                machineNumber: '5', machine: machine4),
                            MachineButton(
                                machineNumber: '4', machine: machine3),
                            MachineButton(
                                machineNumber: '3', machine: machine2),
                            MachineButton(
                                machineNumber: '2', machine: machine1),
                            MachineButton(
                                machineNumber: '1', machine: machine6),
                          ],
                        ),
                        const SizedBox(height: 120),
                        MachineButton(
                          machineNumber: '8/9',
                          width: 90,
                          height: 90,
                          machine: machine1,
                        ),
                        MachineButton(
                          machineNumber: '10',
                          width: 90,
                          height: 90,
                          machine: machine2,
                        ),
                        const SizedBox(height: 40),
                        MachineButton(
                          machineNumber: '',
                          width: 20,
                          machine: machine2,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            MachineButton(
                              machineNumber: 'cookie',
                              width: 90,
                              height: 90,
                              machine: machine2,
                            ),
                            const SizedBox(width: 40),
                            MachineButton(
                              machineNumber: 'coffee',
                              width: 90,
                              height: 90,
                              machine: machine2,
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
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
