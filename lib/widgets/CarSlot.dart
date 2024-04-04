import 'package:flutter/material.dart';

class CarSlot extends StatelessWidget {
  final bool isAvailable;
  const CarSlot({
    super.key,
    required this.height,
    required this.isAvailable, required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        isAvailable
            ? SizedBox(
                height: height * 0.1, child: const Center(child: Text("A 212")))
            : Image.asset(
                "assets/images/cars1.png",
                height: height * 0.1,
                width: width * 0.2,
              ),
      ],
    );
  }
}
