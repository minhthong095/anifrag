import 'package:Anifrag/service/requesting.dart';
import 'package:inject/inject.dart';

@module
class Module {
  @provide
  Requesting2 requesting() => Requesting2();

  @provide
  Requesting2 requestingWithValue() => Requesting2(value: "With Value");
}


class Requesting2 {
  final String value;
  Requesting2({this.value = "VALUE"})''
}