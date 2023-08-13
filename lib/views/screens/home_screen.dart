import 'package:flutter/material.dart';
import 'package:laverie/models/machine_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/machine_button_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<MachineModel> machinesList = [];

  Future<void> _machinesData() async {
    try {
      final response = await Supabase.instance.client
          .from('machines')
          .select()
          .eq('laundry_id', 'eb16c09e-4a36-4d8e-a790-5556b36273e5')
          .order('machine_order', ascending: true);

      final data = response as List<dynamic>;

      machinesList = data
          .map((machineData) => MachineModel.fromJson(machineData))
          .toList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 115, 125, 212),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: const Center(child: Text('ad zone')),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 160,
              child: FutureBuilder(
                future: _machinesData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(6, (index) {
                            int machineNumber = 6 - index - 1;
                            return MachineButton(
                              machine: machinesList[machineNumber],
                            );
                          }).reversed.toList(),
                        ),
                        const SizedBox(height: 80),
                        MachineButton(
                          width: 80,
                          height: 80,
                          machine: machinesList[6],
                          stackedMachine: machinesList[7],
                          isStacked: true,
                        ),
                        MachineButton(
                          width: 80,
                          height: 80,
                          machine: machinesList[8],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          height: 64,
                          width: 20,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            MachineButton(
                              width: 80,
                              height: 80,
                              machine: machinesList[9],
                            ),
                            const SizedBox(width: 40),
                            MachineButton(
                              width: 80,
                              height: 80,
                              machine: machinesList[10],
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
