import 'package:json_annotation/json_annotation.dart';

part 'response_cast.g.dart';

@JsonSerializable()
class ResponseCast {
  final String name;

  ResponseCast({this.name});

  factory ResponseCast.fromJson(Map<String, dynamic> json) =>
      _$ResponseCastFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseCastToJson(this);
}
