import 'package:flutter/material.dart';
import 'package:implosion/counter.dart';
import 'package:implosion/data.dart';
import 'package:implosion/midgame.dart';
import 'package:implosion/nice_appbar.dart';

class AutonomousV2 extends StatefulWidget {
  const AutonomousV2({super.key});

  @override
  State<StatefulWidget> createState() => _AutoV2State();
}

class _AutoV2State extends State<AutonomousV2> {
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
    conesHigh = DataRecord.conesScoredHighAuto;
    cubesHigh = DataRecord.cubesScoredHighAuto;

    conesMid = DataRecord.conesScoredMidAuto;
    cubesMid = DataRecord.cubesScoredMidAuto;

    conesLow = DataRecord.conesScoredLowAuto;
    cubesLow = DataRecord.cubesScoredLowAuto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: niceAppBarBuilder(
        context,
        "Autonomous",
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
                      setVal:  (val) { conesHigh = val; DataRecord.conesScoredHighAuto = val; },
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
                      setVal: (val) { cubesHigh = val; DataRecord.cubesScoredHighAuto = val; },
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
                      setVal:  (val) { conesMid = val; DataRecord.conesScoredMidAuto = val; },
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
                      setVal: (val) { cubesMid = val; DataRecord.cubesScoredMidAuto = val; },
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
                    const Text("Cones - Low"),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal:  (val) { conesLow = val; DataRecord.conesScoredLowAuto = val; },
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
                    const Text("Cubes - Low"),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Counter(
                      setVal: (val) { cubesLow = val; DataRecord.cubesScoredLowAuto = val; },
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
