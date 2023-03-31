import 'package:flutter/material.dart';
import 'package:jordan2023/grid_display.dart';
import 'package:jordan2023/midgame.dart';
import 'package:jordan2023/nice_appbar.dart';

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
      appBar: niceAppBarBuilder(
        context,
        "Autonomous Grid",
        IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Midgame())),
          icon: const Icon(Icons.arrow_forward_ios)
        ),
        true
      ),
      backgroundColor: const Color(0xFF12131e),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
              onTapUp: (details) {
                //if (kDebugMode) print("tepp;d");
                _grid.hitCheck(details.localPosition);

                setState((){ /* bastard */ });
              },
              child: FutureBuilder(
                future: _loadImages,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    //if (kDebugMode) print("THERE IS DATA");
                    return CustomPaint(painter: _grid, size: const Size(1600, 500),);
                  }
                  return Container();
                },
              )
            )
          ],
        ),
      )
    );
  }
}
