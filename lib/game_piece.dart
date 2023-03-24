import 'dart:ffi';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Img = ui.Image;

class GamePiece {
  late Img picture;
  late final int? rotationDegrees;
  final bool isCube;
  bool isVisible = false;

  GamePiece({required this.isCube, required this.isVisible, this.rotationDegrees});

  void cloneFrom(Img img) {
    picture = img;
  }

  void draw(Canvas canvas, Offset pos) {
    if (!isVisible) {
      return;
    }
    canvas.drawImage(picture, pos, Paint());
  }
}
