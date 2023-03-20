import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Img = ui.Image;

class GamePiece {
  late Img picture;
  late final String _path;
  bool isVisible = false;

  GamePiece(this._path, this.isVisible);

  void loadImg() async {
    final data = await rootBundle.load(_path);
    picture = await decodeImageFromList(data.buffer.asUint8List());
  }

  void cloneFrom(Img img) {
    picture = img;
  }
}
