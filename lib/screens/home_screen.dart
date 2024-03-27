import 'package:flutter/material.dart';
import 'package:park_it/widgets/CTAButton.dart';
import 'package:park_it/widgets/CustomAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: const CTAButton(
          icon: Icon(Icons.menu_rounded),
        ),
        text: const Column(
          children: [
            Text(
              "Jack Harrison",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "Brooklyn, NY",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        action: const CTAButton(icon: Icon(Icons.person)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose a ",
                    style: TextStyle(fontSize: 26),
                  ),
                  Text(
                    "parking place",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              // //  Container card
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff303030),
                    borderRadius: BorderRadius.circular(20)),
                height: 200,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
