import 'package:Anifrag/di/component.dart';
import 'package:Anifrag/store/live_store.dart';

mixin PrefixUrlImgMixin {
  String get baseUrlImage => ComponentInjector.I.blocDetail;
}
