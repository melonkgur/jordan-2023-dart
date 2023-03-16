enum GridState {
  empty,
  coneTeleop,
  coneAuto,
  cubeTeleop,
  cubeAuto
} extension ToJsonStr on GridState {
  //TODO: find real vals
  String toJsonStr() {
    switch (this) {
      case GridState.empty:
        return "Nothing";
      case GridState.coneTeleop:
        return "ConeTeleop";
      case GridState.coneAuto:
        return "ConeAuto";
      case GridState.cubeAuto:
        return "CubeAuto";
      case GridState.cubeTeleop:
        return "CubeTeleop";
      default:
        return "crazy and insane";
    }
  }
}
