import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class DataArchive {
  static LocalStorage storage = LocalStorage("jordan_2023.json");
  //i guess idk
  static List<String> _archived = List.empty(growable: true);

  void getFromStorage() async {
    var ready = await storage.ready;
    if (ready) {
      Map<String, List<String>> data = storage.getItem("archived");
      _archived = data["archived"]!;
      if (kDebugMode) {
        print(data);
      }
    }
  }

  String getArchiveIndex(int index) {
    return _archived[index];
  }

  void restore(int index) {
    String str = getArchiveIndex(index);

  }
}
