import "package:flutter/foundation.dart";
import "package:implosion/charge_station_state.dart";
import "package:implosion/data_archive.dart";
import "package:implosion/grid_state.dart";
import "package:implosion/pickup_types.dart";
import "package:implosion/feed_location.dart";

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

//TODO: make real values
  static String toJsonStr() {
    return """
{
  "scouter": "$scouter",
  "teamNumber": $teamNumber,
  "autoStatus": "${auto.toJsonStr()}",
  "endgameStatus": "${endGame.toJsonStr()}",
  "notes": "$notes",
  "matchId": $matchNumber,
  "defense": $playingDefense,
  "feedLocation": "${feedLocation.toJsonStr()}",
  "pickup": "${pickup.toJsonStr()}",
  "autoConeScores": [$conesScoredHighAuto, $conesScoredMidAuto, $conesScoredLowAuto],
  "autoCubeScores": [$cubesScoredHighAuto, $cubesScoredMidAuto, $cubesScoredLowAuto],
  "cubeScores": [$cubesScoredHigh, $cubesScoredMid, $cubesScoredLow],
  "coneScores": [$conesScoredHigh, $conesScoredMid, $conesScoredLow]
}
""";
  }

  static void save() async {
    //DataArchive.saveToStorage(toJsonStr(), "{\"matchNumber\": ${matchNumber.toString()}, \"teamNumber\": ${teamNumber.toString()}}");
    if (kDebugMode) print(toJsonStr());
    await DataArchive.save(
      toJsonStr(),
      """{ "teamNumber": $teamNumber, "matchNumber": $matchNumber }"""
    );
    reset();
  }

  static void reset() {
      teamNumber = 0;
      matchNumber++;
      auto = ChargeStationStatus.notOn;
      endGame = ChargeStationStatus.notOn;
      playingDefense = false;
      notes = "";
      pickup = GamePiecePickup.both;
      feedLocation = FeedLocation.both;

      conesScoredHighAuto = 0;
      cubesScoredHighAuto = 0;

      conesScoredMidAuto = 0;
      cubesScoredMidAuto = 0;

      conesScoredLowAuto = 0;
      cubesScoredLowAuto = 0;


      conesScoredHigh = 0;
      cubesScoredHigh = 0;

      conesScoredMid = 0;
      cubesScoredMid = 0;

      conesScoredLow = 0;
      cubesScoredLow = 0;
  }
}
