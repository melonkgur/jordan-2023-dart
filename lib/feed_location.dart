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
} extension FromJsonStr on FeedLocation {
  FeedLocation fromJsonStr(String s) {
    switch(s) {
      case "0":
        return FeedLocation.nowhere;
      case "1":
        return FeedLocation.ground;
      case "2":
        return FeedLocation.feeder;
      case "3":
        return FeedLocation.both;
      default:
        return FeedLocation.nowhere;
    }
  }
}
