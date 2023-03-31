import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class DataArchive {
  static LocalStorage storage = LocalStorage("jordan_2023.json");
  //i guess idk
  static List<String> _archived = List.empty(growable: true);
  static List<String> _matches  = List.empty(growable: true);

  static const _storageKey = "2023jordanarchive";
  static const _matchIdKey = "2023jordanmatches";

  static bool ready = false;

  static void init() async {
    ready = await storage.ready;
    getFromStorage();
    storage.onError.addListener(errHandler);
  }

  static void errHandler() {
    if (!ready) return;
    try {
      storage.deleteItem(_matchIdKey);
      storage.deleteItem(_storageKey);
    } catch (e) { if (kDebugMode) print(e.toString()); }
    try {
      storage.clear();
    } catch (e) { if (kDebugMode) print(e.toString()); }
  }

  static void clearStorage() async {
    // try{
    //   ready = await storage.ready;
    // } catch (e) {
    //   if (kDebugMode) print(e.toString());

    //   //works for some damn reason
    //   storage.deleteItem(_matchIdKey);
    //   storage.deleteItem(_storageKey);
    //   _archived.clear();
    //   _matches.clear();

    //   return;
    // }
    if (ready) {
      //put it here, hopefully the thing will never piss itself that damn hard again i mean really
      storage.clear();
      _archived.clear();
      _matches.clear();
    }
  }

  static void saveToStorage(String jsonArchive, String jsonMatch ) async {
    // bool ready = await storage.ready;
    if (ready) {
      _archived.add(jsonArchive);
      String tempArchive = "{\n\"archived\":[\n";
      for (int i = 0; i < _archived.length; i++) {
        if (i+1 != _archived.length) {
          tempArchive += "\"${_archived[i]}\",\n";
        } else {
          tempArchive += "\"${_archived[i]}\"\n";
        }
      }

      tempArchive += "]\n}";

      tempArchive = tempArchive.replaceAll(RegExp('\n'), ""); //im gonna stab somebody

      await storage.setItem(_storageKey, tempArchive);

      _matches.add(jsonMatch);

      String tempMatch = "{\n\"matches\":[\n";
      for (int i = 0; i < _matches.length; i++) {
        if (i+1 != _matches.length) {
          tempMatch += "\"${_matches[i]}\",\n";
        } else {
          tempMatch += "\"${_matches[i]}\"\n";
        }
      }
      tempMatch += "]\n}";

      tempMatch = tempMatch.replaceAll(RegExp('\n'), "");

      await storage.setItem(_matchIdKey, tempMatch);
    }
  }

  static void getFromStorage() {
    if (ready) {
      try {
        List<String> storedMatches = List.empty(growable: true);
        (jsonDecode(storage.getItem(_matchIdKey))["matches"]).map((e) => print(e.toString()));
        List<String> storedGames = List.empty(growable: true);
        (jsonDecode(storage.getItem(_storageKey))["archived"]).map((e) => print(e.toString())); //i hate flutter now
        _matches = storedMatches;
        _archived = storedGames;
      } catch (e) {
        if (kDebugMode) print(e.toString());
        if (kDebugMode) print(storage.getItem(_storageKey));
        if (kDebugMode) print(storage.getItem(_matchIdKey));
      }
    }
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
    final parsed = jsonDecode(raw.replaceAll(RegExp("'"), "\""));

    teamNumber = parsed["teamNumber"];
    matchNumber = parsed["matchNumber"];
  }
}
