import 'package:flutter/material.dart';

class CarSlot extends StatelessWidget {
  final bool isAvailable;
  const CarSlot({
    super.key,
    required this.height,
    required this.isAvailable,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        isAvailable
            ? SizedBox(
                height: height * 0.1, child: const Center(child: Text("A 212")))
            : Image.asset(
                "assets/images/cars.png",
                height: height * 0.1,
              ),
      ],
    );
  }
}
