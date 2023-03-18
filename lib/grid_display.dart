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
  void paint(Canvas canvas, Size size) {
    canvas.scale(0.3);
    canvas.drawImage(_background!, Offset(size.width/2-_background!.width/2, size.height/2-_background!.height/2), _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // <strong>KILL THE COMPUTER</strong>
  }
}
