import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;

import 'package:flutter/services.dart';

typedef Img = ui.Image;

class Grid extends CustomPainter {
  Img? _background;
  Img? _cone;
  Img? _cube;
  final Paint _paint = Paint();

  static const double kHitWidth = 80;
  static const int bCube = 0x1;
  static const int bCone = 0x2;

  final List<Rect> hitboxes = const [
    Rect.fromLTWH(-700, -250, kHitWidth, kHitWidth),
    Rect.fromLTWH(-705, -70, kHitWidth, kHitWidth),
    Rect.fromLTWH(-690, 150, kHitWidth, kHitWidth),

    Rect.fromLTWH(-525, -215, kHitWidth, kHitWidth),
    Rect.fromLTWH(-530, -25, kHitWidth, kHitWidth),
    Rect.fromLTWH(-520, 150, kHitWidth, kHitWidth),

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

  final List<int> gridSpaces = [
    bCone, bCone, (bCone | bCube),
    bCube, bCube, (bCone | bCube),
    bCone, bCone, (bCone | bCube),

    bCone, bCone, (bCone | bCube),
    bCube, bCube, (bCone | bCube),
    bCone, bCone, (bCone | bCube),

    bCone, bCone, (bCone | bCube),
    bCube, bCube, (bCone | bCube),
    bCone, bCone, (bCone | bCube),
  ];


  Grid(this.isAuto) {
    // background = FileImage(File("asset/thingie.png"));
  }

  Future<bool> loadImages() async {
    _background = await loadImg("lib/asset/thingie.png"); // woah thats a silly null check my guy
    _cone = await loadImg("lib/asset/cone.png");
    _cube = await loadImg("lib/asset/cube.png");
    return true;
  }

  Future<Img> loadImg(String path) async {
    final data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }

  late bool isAuto;

  @override
  bool? hitTest(Offset position) {
    if (kDebugMode) print(position.toString());
    if (kDebugMode) print(super.hitTest(position));
    return super.hitTest(position);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(0.35);
    canvas.drawImage(_background!, Offset(size.width/2-_background!.width/2, size.height/2-_background!.height/2), _paint);
    for (var element in hitboxes) {
      canvas.drawRect(element, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // <strong>KILL THE COMPUTER</strong>
  }
}
