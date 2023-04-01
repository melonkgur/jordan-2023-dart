import 'package:flutter/material.dart';
import 'package:jordan2023/counter.dart';
import 'package:jordan2023/data.dart';
import 'package:jordan2023/end_game.dart';
import 'package:jordan2023/general_info.dart';
import 'package:jordan2023/nice_appbar.dart';

class TeleopV2 extends StatefulWidget {
  const TeleopV2({super.key});

  @override
  State<TeleopV2> createState() => _TeleopV2State();
}

class _TeleopV2State extends State<TeleopV2> {
  late int conesHigh;
  late int cubesHigh;

  late int conesMid;
  late int cubesMid;

  late int conesLow;
  late int cubesLow;

  bool isAuto = false;

  @override
  void initState() {
    super.initState();
    conesHigh = DataRecord.conesScoredHigh;
    cubesHigh = DataRecord.cubesScoredHigh;

    conesMid = DataRecord.conesScoredMid;
    cubesMid = DataRecord.cubesScoredMid;

    conesLow = DataRecord.conesScoredLow;
    cubesLow = DataRecord.cubesScoredLow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: niceAppBarBuilder(
        context,
        "Tele-Op",
        IconButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Midgame() )),
          icon: const Icon(Icons.arrow_forward_ios)
        ),
        true
      ),
      backgroundColor: const Color(0xFF12131e),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
              flex: 2,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20),)
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Cones - High",  ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal:  (val) { conesHigh = val; DataRecord.conesScoredHigh = val; },
                      getVal: () => conesHigh
                    ),
                  ],
                ),

                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Cubes - High",  ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal: (val) { cubesHigh = val; DataRecord.cubesScoredHigh = val; },
                      getVal: () => cubesHigh
                    )
                  ],
                ),

                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),
              ],
            ),

            const Expanded(
              flex: 2,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20),)
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Cones - Mid",  ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal:  (val) { conesMid = val; DataRecord.conesScoredMid = val; },
                      getVal: () => conesMid
                    ),
                  ],
                ),

                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Cubes - Mid",  ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal: (val) { cubesMid = val; DataRecord.cubesScoredMid = val; },
                      getVal: () => cubesMid
                    )
                  ],
                ),

                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),
              ],
            ),

            const Expanded(
              flex: 2,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20),)
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Cones - Low",  ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal:  (val) { conesLow = val; DataRecord.conesScoredLow = val; },
                      getVal: () => conesLow
                    ),
                  ],
                ),

                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Cubes - Low",  ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal: (val) { cubesLow = val; DataRecord.cubesScoredLow = val; },
                      getVal: () => cubesLow
                    )
                  ],
                ),

                const Expanded(
                  flex: 2,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),)
                ),
              ],
            ),
            const Expanded(
              flex: 2,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20),)
            ),
          ]
        )
      ),
    );
  }

}
