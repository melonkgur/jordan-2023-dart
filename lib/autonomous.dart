import 'package:flutter/material.dart';

class Autonomous extends StatefulWidget {
  const Autonomous({super.key});

  @override
  State<Autonomous> createState() => _AutoState();
}

class _AutoState extends State<Autonomous> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autonomous Grid"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            Text("die")
          ],
        ),
      )
    );
  }
}
