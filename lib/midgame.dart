import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implosion/charge_station_state.dart';
import 'package:implosion/data.dart';
import 'package:implosion/feed_location.dart';
import 'package:implosion/nice_appbar.dart';
import 'package:implosion/pickup_types.dart';
import 'package:implosion/teleop.dart';
import 'package:implosion/teleop_counter.dart';

class Midgame extends StatefulWidget {
  const Midgame({super.key});

  @override
  State<Midgame> createState() => _MidgameState();
}

class _MidgameState extends State<Midgame> {
  late ChargeStationStatus endgameStatus;
  late FeedLocation feedLocation;
  late GamePiecePickup piecePickup;
  late bool defense;

  @override
  void initState() {
    super.initState();

    endgameStatus = DataRecord.endGame;
    feedLocation = DataRecord.feedLocation;
    piecePickup = DataRecord.pickup;
    defense = DataRecord.playingDefense;
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
        "Mid-Game",
        IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TeleopV2())),
            icon: const Icon(Icons.arrow_forward_ios)
        ),
        true
      ),
      backgroundColor: const Color(0xFF12131e),
      body: Center(
        child: SafeArea(
          left: true,
          right: true,
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Endgame Status:", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(value: ChargeStationStatus.notOn, child: Text("None"),),
                            DropdownMenuItem(value: ChargeStationStatus.inCommunity, child: Text("In Community"),),
                            DropdownMenuItem(value: ChargeStationStatus.dockedNotEngaged, child: Text("Docked"),),
                            DropdownMenuItem(value: ChargeStationStatus.dockedAndEngaged, child: Text("Docked & Engaged"),),
                          ],
                          value: endgameStatus,
                          isDense: true,
                          onChanged: (value) => setState(() {
                            endgameStatus = value!;
                            DataRecord.endGame = value;
                            if (kDebugMode) print(DataRecord.endGame.toJsonStr());
                          }),
                        )
                      ]
                    )
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Feed Location:", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(value: FeedLocation.nowhere, child: Text("None")),
                            DropdownMenuItem(value: FeedLocation.ground, child: Text("Floor")),
                            DropdownMenuItem(value: FeedLocation.feeder, child: Text("Feeder"),),
                            DropdownMenuItem(value: FeedLocation.both, child: Text("Both"),)
                          ],
                          value: feedLocation,
                          isDense: true,
                          onChanged: (value) => setState(() {
                            feedLocation = value!;
                            DataRecord.feedLocation = value;
                            if (kDebugMode) print(DataRecord.feedLocation.toJsonStr());
                          }),
                        )
                      ]
                    )
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Picks Up:", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                        DropdownButton(
                          items: const [
                            DropdownMenuItem(value: GamePiecePickup.none, child: Text("None"),),
                            DropdownMenuItem(value: GamePiecePickup.cone, child: Text("Cones"),),
                            DropdownMenuItem(value: GamePiecePickup.cube, child: Text("Cubes"),),
                            DropdownMenuItem(value: GamePiecePickup.both, child: Text("Both"),)
                          ],
                          value: piecePickup,
                          isDense: true,
                          onChanged: (value) => setState(() {
                            piecePickup = value!;
                            DataRecord.pickup = value;
                            if (kDebugMode) print(DataRecord.pickup.toJsonStr());
                          }),
                        )
                      ]
                    )
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Playing Defense", textScaleFactor: 1.25,),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                        Switch(
                          value: defense,
                          onChanged: (value) => setState(() {
                            defense = value;
                            DataRecord.playingDefense = value;
                            if (kDebugMode) print(DataRecord.playingDefense);
                          }),
                        ),
                      ]
                    )
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

}
