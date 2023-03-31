import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:implosion/archives.dart';
import 'package:implosion/charge_station_state.dart';
import 'package:implosion/feed_location.dart';
import 'package:implosion/pickup_types.dart';
import 'package:localstorage/localstorage.dart';

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
                    if (kDebugMode) print("archive instance not mounted but tried to delete lmao");
                    return;
                  }

                  DataArchive.restore(i);

                  _matches.removeAt(i);
                  _archived.removeAt(i);
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
    String str = getArchiveIndex(index);
    //parse or something idk mane
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

  late final String scouter;

  late final GamePiecePickup pickup;
  late final bool defense;

  late final String notes;

  late final FeedLocation feed;

  late final ChargeStationStatus endgame;
  late final ChargeStationStatus endauto;

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

    teamNumber = parsed["teamNumber"];
    matchNumber = parsed["matchId"];

    defense = parsed["defense"];

    feed = feed.fromJsonStr(parsed["feedLocation"]);
    pickup = pickup.fromJsonStr(parsed["pickup"]);

    endgame = endgame.fromJsonStr(parsed["endgameStatus"]);
    endauto = endauto.fromJsonStr(parsed["autoStatus"]);

    conesScoredHighAuto = parsed["conesScoredAuto"][0] as int;
    conesScoredMidAuto = parsed["conesScoredAuto"][1] as int;
    conesScoredLowAuto = parsed["conesScoredAuto"][2] as int;

    conesScoredHigh = parsed["conesScored"][0] as int;
    conesScoredMid = parsed["conesScored"][1] as int;
    conesScoredLow = parsed["conesScored"][2] as int;

    cubesScoredHighAuto = parsed["cubesScoredAuto"][0] as int;
    cubesScoredMidAuto = parsed["cubesScoredAuto"][1] as int;
    cubesScoredLowAuto = parsed["cubesScoredAuto"][2] as int;

    cubesScoredHigh = parsed["cubesScored"][0] as int;
    cubesScoredMid = parsed["cubesScored"][1] as int;
    cubesScoredLow = parsed["cubesScored"][2] as int;

    notes = parsed["notes"];
  }

}
