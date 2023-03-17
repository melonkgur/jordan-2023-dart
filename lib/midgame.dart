import 'package:flutter/material.dart';

class Midgame extends StatefulWidget {
  const Midgame({super.key});

  @override
  State<Midgame> createState() => _MidgameState();
}

class _MidgameState extends State<Midgame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MidGame"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text("die")
          ],
        ),
      )
    );
  }

}
