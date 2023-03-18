import 'package:flutter/material.dart';
import 'package:implosion/grid_display.dart';
import 'package:implosion/midgame.dart';

class Autonomous extends StatefulWidget {
  const Autonomous({super.key});

  @override
  State<Autonomous> createState() => _AutoState();
}

class _AutoState extends State<Autonomous> {
  final Grid _grid = Grid(true);
  late final Future<bool> _loadImages = _grid.loadImages();

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
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Midgame())),
            icon: const Icon(Icons.arrow_forward_ios)
          )
        ],
      ),
      backgroundColor: const Color(0xFF12131e),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder(
              future: _loadImages,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return CustomPaint( painter: _grid, );
                }
                return const Padding(padding: EdgeInsets.symmetric(vertical: 20));
              },
            )
          ],
        ),
      )
    );
  }
}
