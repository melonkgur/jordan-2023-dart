import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implosion/archives.dart';
import 'package:implosion/charge_station_state.dart';
import 'package:implosion/data.dart';
import 'package:implosion/feed_location.dart';
import 'package:implosion/main.dart';
import 'package:implosion/pickup_types.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DataArchive {
  //i guess idk
  static List<String> _archived = List.empty(growable: true);
  static List<String> _matches  = List.empty(growable: true);

  static const _storageKey = "2023jordanarchive";
  static const _matchIdKey = "2023jordanmatches";

  static late bool ready;

  static LocalStorage storage = LocalStorage("jordan_2023.json");

  static void clearStorage() async {
    storage.clear();
    _archived.clear();
    _matches.clear();
  }

  static String _encode(String s) {
    return base64.encode(utf8.encode(s));
  }

  static String _decode(String s) {
    return utf8.decode(base64.decode(s));
  }

  static Future<void> init() async {
    try {
      ready = await storage.ready;
      await load();
    } catch (e) {
      handleErr();
    }
    storage.onError.addListener(handleErr);
  }

  static void handleErr() {
    try {
      storage.deleteItem(_matchIdKey);
      storage.deleteItem(_storageKey);
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }

    try {
      storage.clear();
    } catch(e) {
      if (kDebugMode) print(e.toString());
    }
  }

  static Future<void> load() async {
    if (!ready) return;

    try {
      if (kDebugMode) print(storage.getItem(_matchIdKey));
      if (kDebugMode) print(storage.getItem(_storageKey));

      List<dynamic> tempMatch = jsonDecode(storage.getItem(_matchIdKey))["matches"];
      List<dynamic> tempGame = jsonDecode(storage.getItem(_storageKey))["archived"];

      _matches = tempMatch.map((e) => e.toString()).toList();
      _archived = tempGame.map((e) => e.toString()).toList();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  static Future<void> update() async {
    String archTemp = '{"archived":[';
    for (int i = 0; i < _archived.length; i++) {
      if (i + 1 == _archived.length) {
        archTemp += '"${_archived[i]}"';
      } else {
        archTemp += '"${_archived[i]}", ';
      }
    }
    archTemp += ']}';

    await storage.setItem(_storageKey, archTemp);


    String matchTemp = '{"matches":[';
    for (int i = 0; i < _matches.length; i++) {
      if (i + 1 == _matches.length) {
        matchTemp += '"${_matches[i]}"';
      } else {
        matchTemp += '"${_matches[i]}", ';
      }
    }
    matchTemp += ']}';

    await storage.setItem(_matchIdKey, matchTemp);
  }

  static Future<void> save(String game, String match) async {
    _archived.add(base64.encode(utf8.encode(game)).replaceAll(RegExp("\n"), ""));
    _matches.add(base64.encode(utf8.encode(match)));

    await update();
  }

  static List<Widget> getArchiveListWidget() {
    List<Widget> temp = List.empty(growable: true);
    for (int i = 0; i < _matches.length; i++) {
      final match = _MatchFromJson(_matches[i]);

      temp.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Text("${(i+1)}.", style: const TextStyle(fontStyle: FontStyle.italic)),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Text("Match ${match.matchNumber.toString()}, Team ${match.teamNumber.toString()}"),
              const Expanded(flex: 2, child: Padding(padding: EdgeInsets.symmetric(horizontal: 20))),
              TextButton(
                onPressed: () {
                  if (!ArchiveState.instance!.mounted) {
                    if (kDebugMode) print("archive instance wasn;t real twhen the popup");
                    return;
                  }

                  var qr = QrImage(
                    data: _decode(_archived[i]),
                    //size: 1000,
                  );

                  showDialog(
                    context: ArchiveState.instance!.context,
                    builder: (context) => AlertDialog(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 200),
                      backgroundColor: Colors.white,
                      content: SizedBox(width: 1000, height: 1000, child: qr,),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Close")
                        ),
                      ],
                    )
                  );

                },
                child: const Text("QR code")
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              TextButton(
                onPressed: () async {
                  if (!ArchiveState.instance!.mounted) {
                    if (kDebugMode) print("archive instance not mounted but tried to delete lmao");
                    return;
                  }

                  restore(i);

                  _matches.removeAt(i);
                  _archived.removeAt(i);
                  await update();
                  ArchiveState.instance!.reloadList();

                  Navigator.of(ArchiveState.instance!.context).pop();
                },
                child: const Text("Restore")
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              TextButton(
                onPressed: () async {
                  if (!ArchiveState.instance!.mounted) {
                    if (kDebugMode) print("archive instance not mounted but tried to delete lmao");
                    return;
                  }
                  _matches.removeAt(i);
                  _archived.removeAt(i);
                  await update();
                  ArchiveState.instance!.reloadList();
                },
                child: const Text("Delete")
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              //buttons or whatever idc
            ],
          )
        )
      );
    }

    return temp;
  }

  static String getArchiveIndex(int index) {
    return _archived[index];
  }

  static void restore(int index) {
    String str = _archived[index];
    _GameFromArchive match = _GameFromArchive(str);

    DataRecord.auto = match.endauto;
    DataRecord.endGame = match.endgame;

    DataRecord.playingDefense = match.defense;

    DataRecord.notes = match.notes;

    DataRecord.feedLocation = match.feed;
    DataRecord.pickup = match.pickup;

    DataRecord.matchNumber = match.matchNumber;
    DataRecord.teamNumber = match.teamNumber;

    DataRecord.scouter = match.scouter;

    //cones
    DataRecord.conesScoredHighAuto = match.conesScoredHighAuto;
    DataRecord.conesScoredMidAuto = match.conesScoredMidAuto;
    DataRecord.conesScoredLowAuto = match.conesScoredLowAuto;

    DataRecord.conesScoredHigh = match.conesScoredHigh;
    DataRecord.conesScoredMid = match.conesScoredMid;
    DataRecord.conesScoredLow = match.conesScoredLow;

    //cubes
    DataRecord.cubesScoredHighAuto = match.cubesScoredHighAuto;
    DataRecord.cubesScoredMidAuto = match.cubesScoredMidAuto;
    DataRecord.cubesScoredLowAuto = match.cubesScoredLowAuto;

    DataRecord.cubesScoredHigh = match.cubesScoredHigh;
    DataRecord.cubesScoredMid = match.cubesScoredMid;
    DataRecord.cubesScoredLow = match.cubesScoredLow;

    MainPage.reload();
  }
}

class _MatchFromJson {
  late final int teamNumber;
  late final int matchNumber;

  _MatchFromJson(String raw) {
    final parsed = jsonDecode(DataArchive._decode(raw));

    teamNumber = parsed["teamNumber"];
    matchNumber = parsed["matchNumber"];
  }
}

class _GameFromArchive {
  late final int teamNumber;
  late final int matchNumber;

  late String scouter;

  late final bool defense;

  late final String notes;


  // cant be final
  late FeedLocation feed = FeedLocation.nowhere;

  late ChargeStationStatus endgame = ChargeStationStatus.notOn;
  late ChargeStationStatus endauto = ChargeStationStatus.notOn;

  late GamePiecePickup pickup = GamePiecePickup.none;


  late final int conesScoredHighAuto;
  late final int conesScoredMidAuto;
  late final int conesScoredLowAuto;

  late final int conesScoredHigh;
  late final int conesScoredMid;
  late final int conesScoredLow;

  late final int cubesScoredHighAuto;
  late final int cubesScoredMidAuto;
  late final int cubesScoredLowAuto;

  late final int cubesScoredHigh;
  late final int cubesScoredMid;
  late final int cubesScoredLow;

  _GameFromArchive(String s) {
    final parsed = jsonDecode(DataArchive._decode(s));

    scouter = parsed["scouter"];

    teamNumber = parsed["teamNumber"];
    matchNumber = parsed["matchId"];

    defense = parsed["defense"];

    feed = feed.fromJsonStr(parsed["feedLocation"]);
    pickup = pickup.fromJsonStr(parsed["pickup"]);

    endgame = endgame.fromJsonStr(parsed["endgameStatus"]);
    endauto = endauto.fromJsonStr(parsed["autoStatus"]);

    conesScoredHighAuto = parsed["autoConeScores"][0];
    conesScoredMidAuto = parsed["autoConeScores"][1];
    conesScoredLowAuto = parsed["autoConeScores"][2];

    conesScoredHigh = parsed["coneScores"][0];
    conesScoredMid = parsed["coneScores"][1];
    conesScoredLow = parsed["coneScores"][2];

    cubesScoredHighAuto = parsed["autoCubeScores"][0];
    cubesScoredMidAuto = parsed["autoCubeScores"][1];
    cubesScoredLowAuto = parsed["autoCubeScores"][2];

    cubesScoredHigh = parsed["cubeScores"][0];
    cubesScoredMid = parsed["cubeScores"][1];
    cubesScoredLow = parsed["cubeScores"][2];

    notes = parsed["notes"];
  }

}
