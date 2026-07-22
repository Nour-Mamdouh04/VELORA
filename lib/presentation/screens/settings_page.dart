import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: "DMSans",
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 121, 113, 72),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
