import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'bus_layout_model.g.dart';

@JsonSerializable()
class BusLayoutModel {
	@JsonKey(name: 'ResponseCode') 
	int? responseCode;
	@JsonKey(name: 'Message') 
	String? message;
	@JsonKey(name: 'Data') 
	Data? data;

	BusLayoutModel({this.responseCode, this.message, this.data});

	factory BusLayoutModel.fromJson(Map<String, dynamic> json) {
		return _$BusLayoutModelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$BusLayoutModelToJson(this);
}
