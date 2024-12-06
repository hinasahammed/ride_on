import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'tour_model.g.dart';

@JsonSerializable()
class TourModel {
  @JsonKey(name: 'ResponseCode')
  int? responseCode;
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'Data')
  List<Datum>? data;

  TourModel({this.responseCode, this.message, this.data});

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return _$TourModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TourModelToJson(this);
}
