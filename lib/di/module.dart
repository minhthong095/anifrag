import 'package:Anifrag/service/requesting.dart';
import 'package:inject/inject.dart';

const differentReques

@module
class Module {
  @provide
  Requesting2 requestingWithValue() => Requesting2(value: "With Value");

  @provide
  Requesting2 requesting() => Requesting2();
}

class Requesting2 {
  final String value;
  Requesting2({this.value = "VALUE"});
}
