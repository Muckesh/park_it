import 'package:flutter/material.dart';
import 'package:park_it/widgets/ColumnText.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: height * 0.1,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Parking lot
          ColumnText(
            heading: 'Parking lot',
            subHeading: 'A 212',
          ),
          ColumnText(heading: "Floor", subHeading: "2"),
          ColumnText(heading: "Status", subHeading: "Available",color: Colors.blueAccent,),
        ],
      ),
    );
  }
}
