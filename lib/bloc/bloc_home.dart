import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/live_store.dart';

class BlocHome {
  LiveStore _liveStore;
  BlocHome(this._liveStore);

  List<ResponseHomePageMovie> listCarousel() {
    // First 20 records is belong to carousel/
    return _liveStore.homePageData.sublist(0, 19);
  }

  String baseUrlImage() =>
      _liveStore.responseConfiguration.images.secureBaseUrl + "w780";
}
