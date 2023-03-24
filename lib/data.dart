import 'package:implosion/charge_station_state.dart';
import 'package:implosion/grid_state.dart';
import 'package:implosion/pickup_types.dart';
import 'package:implosion/feed_location.dart';

class DataRecord {
  static String scouter = "NAME";
  static int teamNumber = 0;
  static int matchNumber = 1;
  static ChargeStationStatus auto = ChargeStationStatus.notOn;
  static ChargeStationStatus endGame = ChargeStationStatus.notOn;
  static bool playingDefense = false;
  static String notes = "";


  static int conesScoredHighAuto = 0;
  static int cubesScoredHighAuto = 0;

  static int conesScoredMidAuto = 0;
  static int cubesScoredMidAuto = 0;

  static int conesScoredLowAuto = 0;
  static int cubesScoredLowAuto = 0;


  static int conesScoredHigh = 0;
  static int cubesScoredHigh = 0;

  static int conesScoredMid = 0;
  static int cubesScoredMid = 0;

  static int conesScoredLow = 0;
  static int cubesScoredLow = 0;


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
  "matchId": $matchNumber
  "defense": $playingDefense,
  "feedLocation": "${feedLocation.toJsonStr()}",
  "pickup": "${pickup.toJsonStr()}",
  "grid": [${/* TODO: parse grid */ "" }]
}
""";
  }

  void reset() {
      teamNumber = 0;
      teamNumber++;
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
