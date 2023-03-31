import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;

import 'package:flutter/services.dart';
import 'package:jordan2023/game_piece.dart';

typedef Img = ui.Image;

class Grid extends CustomPainter {
  Img? _background;
  Img? _cone;
  Img? _cube;
  final Paint _paint = Paint();

  static const double kHitWidth = 80;
  static const int bCube = 0x1;
  static const int bCone = 0x2;

  final List<Rect> hitboxes = [
    Rect.fromCenter(center: const Offset(120, 40), height: kHitWidth, width: kHitWidth),
    Rect.fromCenter(center: const Offset(100, 180), height: kHitWidth, width: kHitWidth),
    Rect.fromCenter(center: const Offset(130, 434), height: kHitWidth, width: kHitWidth),

    Rect.fromCenter(center: const Offset(290, 70), height: kHitWidth, width: kHitWidth),
    Rect.fromCenter(center: const Offset(290, 260), width: kHitWidth, height: kHitWidth),
    Rect.fromCenter(center: const Offset(295, 434), width: kHitWidth, height: kHitWidth),

    Rect.fromLTWH(-380, -250, kHitWidth, kHitWidth),
    Rect.fromLTWH(-370, -70, kHitWidth, kHitWidth),
    Rect.fromLTWH(-360, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(-200, -250, kHitWidth, kHitWidth),
    Rect.fromLTWH(-200, -70, kHitWidth, kHitWidth),
    Rect.fromLTWH(-190, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(-25, -215, kHitWidth, kHitWidth),
    Rect.fromLTWH(-25, -40, kHitWidth, kHitWidth),
    Rect.fromLTWH(-25, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(130, -250, kHitWidth, kHitWidth),
    Rect.fromLTWH(130, -70, kHitWidth, kHitWidth),
    Rect.fromLTWH(135, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(320, -250, kHitWidth, kHitWidth),
    Rect.fromLTWH(310, -70, kHitWidth, kHitWidth),
    Rect.fromLTWH(310, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(475, -215, kHitWidth, kHitWidth),
    Rect.fromLTWH(480, -25, kHitWidth, kHitWidth),
    Rect.fromLTWH(470, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(650, -250, kHitWidth, kHitWidth),
    Rect.fromLTWH(640, -70, kHitWidth, kHitWidth),
    Rect.fromLTWH(635, 150, kHitWidth, kHitWidth),

  ];

  static var gridSpaces = [
    //PART A
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    [GamePiece(isCube: true, isVisible: false)],
    [GamePiece(isCube: true, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    //PART B
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    [GamePiece(isCube: true, isVisible: false)],
    [GamePiece(isCube: true, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    //PART C
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    [GamePiece(isCube: true, isVisible: false)],
    [GamePiece(isCube: true, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],

    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false)],
    [GamePiece(isCube: false, isVisible: false), GamePiece(isCube: true, isVisible: false)],
  ];

  late bool isAuto;

  Grid(this.isAuto) {
    // background = FileImage(File("asset/thingie.png"));
  }

  Future<bool> loadImages() async {
    _background = await loadImg("lib/asset/thingie.png"); // woah thats a silly null check my guy
    _cone = await loadImg("lib/asset/cone.png");
    _cube = await loadImg("lib/asset/cube.png");

    for(int i = 0; i < gridSpaces.length; i++) {
      for (int j = 0; j < gridSpaces[i].length; j++) {
        if (gridSpaces[i][j].isCube) {
          gridSpaces[i][j].cloneFrom(_cube!);
        } else {
          gridSpaces[i][j].cloneFrom(_cone!);
        }
      }
    }
    return true;
  }

  Future<Img> loadImg(String path) async {
    final data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  bool? hitCheck(Offset position) {
    if (kDebugMode) print("hitTest ${position.toString()}");
    for(int i = 0; i < hitboxes.length; i++) {
      if(hitboxes[i].contains(position)) {

        //figure out which one it hit
        for(int j = 0; j < gridSpaces[i].length; j++) {
          if (gridSpaces[i][j].isVisible) {
            gridSpaces[i][j].isVisible = false;

            if (j+1 != gridSpaces[i].length) {
              gridSpaces[i][(j+1)].isVisible = false;
              return true;
            }

            return true;
          }
        }

        //if all are invisible make first one visible
        gridSpaces[i][0].isVisible = true;
        return true;
      }
    }

    //misclick my bad
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(0.35);
    canvas.drawImage(_background!, const Offset(0, 0), _paint);

    for (var element in hitboxes) {
      canvas.drawRect(element, _paint);
    }

    // huh     huh   huh                 huh       huh
    for (int i = 0; i < hitboxes.length; i++) {
      Offset curHitbox = hitboxes[i].center;

      for (int j = 0; j < gridSpaces[i].length; j++) {
        gridSpaces[i][j].draw(canvas, curHitbox);
      }
    }

    if (kDebugMode) print("painted");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // <strong>KILL THE COMPUTER</strong>
  }
}
