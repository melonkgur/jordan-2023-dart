import 'package:flutter/material.dart';
import 'package:jordan2023/end_game.dart';
import 'package:jordan2023/midgame.dart';
import 'package:jordan2023/nice_appbar.dart';

class Teleop extends StatefulWidget {
  const Teleop({super.key});

  @override
  State<Teleop> createState() => _TeleopState();
}

class _TeleopState extends State<Teleop> {
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
      // appBar: AppBar(
      //   title: const Text("Teleop Grid"),
      //   actions: <Widget>[
      //     IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EndOfMatch())),
      //     icon: const Icon(Icons.arrow_forward_ios))
      //   ],
      // ),
      appBar: niceAppBarBuilder(
        context,
        "Tele-Op Grid",
        IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EndOfMatch())),
          icon: const Icon(Icons.arrow_forward_ios)
        ),
        true
      ),
      backgroundColor: const Color(0xFF12131e),
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
