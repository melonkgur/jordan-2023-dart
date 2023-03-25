import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class DataArchive {
  static LocalStorage storage = LocalStorage("jordan_2023.json");
  //i guess idk
  static List<String> _archived = List.empty(growable: true);
  static List<String> _matches = List.empty(growable: true);

  static const _storageKey = "2023jordanarchive";
  static const _matchIdKey = "2023jordanmatches";

  static void clearStorage() async {
    bool ready = await storage.ready;
    if (ready) {
      _archived.clear();
      _matches.clear();
      storage.clear();
    }
  }

  static void saveToStorage(String jsonArchive, String jsonMatch ) async {
    bool ready = await storage.ready;
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

      await storage.setItem(_matchIdKey, tempMatch);
    }
  }

  static void getFromStorage() async {
    bool ready = await storage.ready;
    if (ready) {
      Map<String, List<String>> data = storage.getItem(_storageKey);
      _archived = data["archived"]!;
      if (kDebugMode) {
        print(data);
      }
    }
  }

  static List<Widget> getArchiveListWidget() {
    List<Widget> temp = List.empty(growable: true);
    for (int i = 0; i < _matches.length; i++) {
      final match = _MatchFromJson(_matches[i]);

      temp.add(
        Row(
          children: [
            Text((i+1).toString(), style: const TextStyle(fontStyle: FontStyle.italic), textScaleFactor: 0.75,),
            Text("Match ${match.matchNumber.toString()}, Team ${match.teamNumber.toString()}"),
            const Expanded(flex: 2, child: Padding(padding: EdgeInsets.symmetric(horizontal: 20))),
            //buttons or whatever idc
          ],
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
    final parsed = jsonDecode(raw);

    if (parsed == null) {
      throw Exception("match was not json parsable. match: $raw");
    }

    teamNumber = parsed["teamNumber"];
    matchNumber = parsed["matchNumber"];
  }
}
