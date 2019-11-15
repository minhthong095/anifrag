import 'package:Anifrag/model/responses/response_home_page_movie.dart';
import 'package:Anifrag/store/live_store.dart';

class BlocHome {
  LiveStore _liveStore;

  BlocHome(this._liveStore);

  static const int _indexForListCarousel = 0;
  static const int maxNumEachPage = 20;

  List<ResponseHomePageMovie> listCarousel() {
    // First 20 records is belong to carousel/
    return _liveStore.homePageData
        .sublist(_indexForListCarousel, maxNumEachPage);
  }

  Map<String, List<ResponseHomePageMovie>> listRestMovies() {
    final result = Map<String, List<ResponseHomePageMovie>>();
    int pivot = _indexForListCarousel + 1;
    int lastEnd = maxNumEachPage;
    while (pivot < _liveStore.categories.length) {
      final start = lastEnd;
      final end = start + maxNumEachPage;
      lastEnd = end;
      result[_liveStore.categories[pivot]] =
          _liveStore.homePageData.sublist(start, end);
      // print("START $start END $end");
      pivot++;
    }
    return result;
  }

  String mainCategory() => _liveStore.categories[0];

  String baseUrlImage() =>
      _liveStore.responseConfiguration.images.secureBaseUrl + "w300";
}
