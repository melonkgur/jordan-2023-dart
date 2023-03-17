enum ChargeStationStatus {
  notOn,
  inCommunity,
  taxi,
  dockedNotEngaged,
  dockedAndEngaged
} extension ToJsonStr on ChargeStationStatus {
  //TODO: figure out real vals
  String toJsonStr() {
    switch (this) {
      case ChargeStationStatus.notOn:
        return "NotOn";
      case ChargeStationStatus.taxi:
        return "Taxi";
      case ChargeStationStatus.inCommunity:
        return "InCommunity";
      case ChargeStationStatus.dockedAndEngaged:
        return "DockedAndEngaged";
      case ChargeStationStatus.dockedNotEngaged:
        return "DockedAndUnengaged";
      default:
        return "how"; //what is this language
    }
  }
}
