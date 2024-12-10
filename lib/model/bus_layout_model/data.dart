import 'package:json_annotation/json_annotation.dart';

import 'slot.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
	@JsonKey(name: 'MaxRow') 
	int? maxRow;
	@JsonKey(name: 'MaxCol') 
	int? maxCol;
	@JsonKey(name: 'Layout') 
	dynamic layout;
	@JsonKey(name: 'Slot') 
	List<Slot>? slot;

	Data({this.maxRow, this.maxCol, this.layout, this.slot});

	factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

	Map<String, dynamic> toJson() => _$DataToJson(this);
}
