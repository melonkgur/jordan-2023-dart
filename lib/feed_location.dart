enum FeedLocation {
  nowhere,
  ground,
  feeder,
  both
} extension ToJsonStr on FeedLocation {
  //TODO: figure out real vals
  String toJsonStr() {
    switch (this) {
      case FeedLocation.nowhere:
        return "0";
      case FeedLocation.ground:
        return "1";
      case FeedLocation.feeder:
        return "2";
      case FeedLocation.both:
        return "3";
      default:
        return "-1"; //WTF ITS NOT EVEN POSSIBLE!?
    }
  }
}
