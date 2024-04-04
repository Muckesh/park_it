import 'package:flutter/material.dart';
import 'package:park_it/widgets/CTAButton.dart';
import 'package:park_it/widgets/CarSlot.dart';
import 'package:park_it/widgets/CustomAppBar.dart';
import 'package:park_it/widgets/CustomButton.dart';
import 'package:park_it/widgets/InfoContainer.dart';

class ParkingScreen extends StatelessWidget {
  const ParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xff252626),
      appBar: const CustomAppBar(
        leading: CTAButton(
          icon: Icon(Icons.menu_rounded),
        ),
        text: Text(
          "Choose a spot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        action: CTAButton(
          icon: Icon(Icons.search),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Info Container
            InfoContainer(height: height),
            // Parking Slot

            // Column 1
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CarSlot(
                            isAvailable: false,
                            height: height,
                            width: width,
                          );
                        }),
                  ),

                  // Vertical Divider
                  const VerticalDivider(
                    thickness: 2,
                  ),

                  // Column 2
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CarSlot(
                            isAvailable: true,
                            height: height,
                            width: width,
                          );
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Entry text
            const Text("Entry"),

            const SizedBox(
              height: 10,
            ),

            // Book spot Button
            CustomButton(buttonText: "Book Spot", height: height),
          ],
        ),
      ),
    );
  }
}
