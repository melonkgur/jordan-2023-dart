enum GamePiecePickup {
  none,
  cone,
  cube,
  both
} extension ToJsonStr on GamePiecePickup {
  String toJsonStr() {
    switch (this) {
      case GamePiecePickup.none:
        return "None";
      case GamePiecePickup.cube:
        return "Cube";
      case GamePiecePickup.cone:
        return "Cone";
      case GamePiecePickup.both:
        return "Both";
      default:
        return "piss yourself";
    }
  }
}
