import 'package:flutter/material.dart';

class QueryResult extends StatelessWidget {
  const QueryResult({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Text(email?? ""),
      ),
    );
  }
}