// Everything save in here will be wipe out when start the application over again.
class ILiveStore {
  List<String> posterSizes = [];
}

class LiveStore implements ILiveStore {
  @override
  List<String> posterSizes;
}

class IConfigurationData {
  String get baseUrl => "";
  List<String> get posterSizes => <String>[];
  List<String> get chagneKeys => <String>[];
}

class IConfigurationDataOffline {}

class IConfigurationDataLive {}
