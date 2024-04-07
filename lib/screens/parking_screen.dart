import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_it/widgets/CarSlot.dart';
import 'package:park_it/widgets/CustomAppBar.dart';
import 'package:park_it/widgets/InfoContainer.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = false;
  List<Map<String, dynamic>> leftSlots = [];
  List<Map<String, dynamic>> rightSlots = [];
  String statusText = '';
  String availableSlotNumber = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/data'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          data = jsonData.map((item) => item as Map<String, dynamic>).toList();
          // Filter slots into left and right based on 'left_or_right' value
          leftSlots =
              data.where((slot) => slot['left_or_right'] == 'L').toList();
          rightSlots =
              data.where((slot) => slot['left_or_right'] == 'R').toList();

          // Check if there are any available slots
          bool isAvailable = data.any((slot) => slot['state'] == 1);
          statusText = isAvailable ? 'Available' : 'Unavailable';

          // Find the first available slot number
          availableSlotNumber = isAvailable
              ? data.firstWhere((slot) => slot['state'] == 1)['slot_number']
              : '';

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> changeSlotState(int slotId, int newState) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/change-state'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{'slot_id': slotId, 'new_state': newState},
        ),
      );
      if (response.statusCode == 200) {
        print('Slot state changed successfully');
        // Refresh data after state change
        fetchData();
      } else {
        throw Exception('Failed to change slot state');
      }
    } catch (e) {
      print('Error changing slot state: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(
        text: Text("Choose a Spot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Info Container
            InfoContainer(
              height: height,
              statusText: statusText,
              availableSlotNumber: availableSlotNumber,
            ),
            // Parking Slot

            // Column 1
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: leftSlots.length,
                      itemBuilder: (context, index) {
                        return CarSlot(
                          slotNumber: leftSlots[index]['slot_number'],
                          isAvailable: leftSlots[index]['state'] == 1,
                          height: height,
                          width: width,
                          onTap: () {
                            changeSlotState(
                              leftSlots[index]['id'],
                              leftSlots[index]['state'] == 1 ? 0 : 1,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Vertical Divider
                  const VerticalDivider(thickness: 2),

                  // Column 2
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: rightSlots.length,
                      itemBuilder: (context, index) {
                        return CarSlot(
                          slotNumber: rightSlots[index]['slot_number'],
                          isAvailable: rightSlots[index]['state'] == 1,
                          height: height,
                          width: width,
                          onTap: () {
                            changeSlotState(
                              rightSlots[index]['id'],
                              rightSlots[index]['state'] == 1 ? 0 : 1,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text("Entry"),
            const SizedBox(height: 10),
            // Book spot Button
            // CustomButton(buttonText: "Book Spot", height: height),
          ],
        ),
      ),
    );
  }
}
