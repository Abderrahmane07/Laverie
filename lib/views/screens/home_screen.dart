import 'package:flutter/material.dart';
import 'package:laverie/models/laundry_model.dart';
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
  late LaundryModel laundry = LaundryModel(
      id: '',
      createdAt: DateTime.now(),
      ownerNumber: '',
      opensAt: DateTime.now(),
      closesAt: DateTime.now(),
      name: '',
      location: '');

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

      final laundryResponse = await Supabase.instance.client
          .from('laundries')
          .select()
          .eq('id', 'eb16c09e-4a36-4d8e-a790-5556b36273e5');
      laundry = LaundryModel.fromJson(laundryResponse[0]);
      print(laundry.name);
    } catch (e) {
      print(e);
    }
  }

  void openDialogForLaundry() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Informations sur la laverie",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Nom : ${laundry.name}",
              ),
              Text(
                "Adresse : ${laundry.location}",
              ),
              Text(
                "Ouverture : ${laundry.opensAt.hour}:${laundry.opensAt.minute}",
              ),
              Text(
                "Fermeture : ${laundry.closesAt.hour}:${laundry.closesAt.minute}",
              ),
            ],
          ),
          actions: [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 115, 125, 212),
      appBar: AppBar(
        title: FutureBuilder(
          future: _machinesData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text('Laverie ${laundry.name}');
            } else {
              return const Text('Laverie');
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              openDialogForLaundry();
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 180,
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
                            // MachineButton(
                            //   width: 80,
                            //   height: 80,
                            //   machine: machinesList[9],
                            // ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                  child: Icon(Icons.cookie_outlined)),
                            ),
                            const SizedBox(width: 40),
                            // MachineButton(
                            //   width: 80,
                            //   height: 80,
                            //   machine: machinesList[10],
                            // ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Center(
                                  child: Icon(Icons.coffee_outlined)),
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
