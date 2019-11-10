// Everything save in here will be wipe out when start the application over again.
class ILiveStore {
  List<String> posterSizes = [];
}

class LiveStore implements ILiveStore {
  @override
  List<String> posterSizes;
}
