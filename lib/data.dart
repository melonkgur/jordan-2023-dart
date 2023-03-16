import 'package:implosion/charge_station_state.dart';
import 'package:implosion/grid_state.dart';
import 'package:implosion/pickup_types.dart';

import 'package:implosion/feed_location.dart';

class DataRecord {
  static String scouter = "";
  static int teamNumber = 0;
  static ChargeStationStatus auto = ChargeStationStatus.notOn;
  static ChargeStationStatus endGame = ChargeStationStatus.notOn;
  static bool playingDefense = false;
  static String notes = "";
  static GamePiecePickup pickup = GamePiecePickup.both;
  static FeedLocation feedLocation = FeedLocation.both;
  static var grid = [
    GridState.empty, GridState.empty, GridState.empty,
    GridState.empty, GridState.empty, GridState.empty,
    GridState.empty, GridState.empty, GridState.empty,

    GridState.empty, GridState.empty, GridState.empty,
    GridState.empty, GridState.empty, GridState.empty,
    GridState.empty, GridState.empty, GridState.empty,

    GridState.empty, GridState.empty, GridState.empty,
    GridState.empty, GridState.empty, GridState.empty,
    GridState.empty, GridState.empty, GridState.empty
  ];

//TODO: make real values
  String toJsonStr() {
    return """
{
  "scouter": "$scouter",
  "teamNumber": $teamNumber,
  "autoStatus": "${auto.toJsonStr()}",
  "endgameStatus": "${endGame.toJsonStr()}",
  "notes": "$notes",
  "defense": $playingDefense,
  "feedLocation": "${feedLocation.toJsonStr()}",
  "pickup": "${pickup.toJsonStr()}",
  "grid": [${/* TODO: parse grid */ "" }]
}
""";
  }

  void reset() {
      teamNumber = 0;
      auto = ChargeStationStatus.notOn;
      endGame = ChargeStationStatus.notOn;
      playingDefense = false;
      notes = "";
      pickup = GamePiecePickup.both;
      feedLocation = FeedLocation.both;
      grid = [
        GridState.empty, GridState.empty, GridState.empty,
        GridState.empty, GridState.empty, GridState.empty,
        GridState.empty, GridState.empty, GridState.empty,

        GridState.empty, GridState.empty, GridState.empty,
        GridState.empty, GridState.empty, GridState.empty,
        GridState.empty, GridState.empty, GridState.empty,

        GridState.empty, GridState.empty, GridState.empty,
        GridState.empty, GridState.empty, GridState.empty,
        GridState.empty, GridState.empty, GridState.empty
      ];
  }
}
