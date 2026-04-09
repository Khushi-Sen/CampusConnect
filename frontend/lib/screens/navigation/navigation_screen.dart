import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Navigation")),
      body: const Center(child: Text("Navigation Screen")),
    );
  }

// ElevatedButton(
//   onPressed: () async {
//     await ARService.openAR();
//   },
//   child: Text("Start AR Navigation"),
// )
}