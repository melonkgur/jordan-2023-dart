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
} extension FromJsonStr on GamePiecePickup {
  GamePiecePickup fromJsonStr(String s) {
    switch (s) {
      case "None":
        return GamePiecePickup.none;
      case "Cube":
        return GamePiecePickup.cube;
      case "Cone":
        return GamePiecePickup.cone;
      case "Both":
        return GamePiecePickup.both;
      default:
        return GamePiecePickup.none;
    }
  }
}
