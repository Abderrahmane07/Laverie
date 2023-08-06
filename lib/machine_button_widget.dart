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
    return InkWell(
      onTap: () {
        print('machine $machineNumber tapped');
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
