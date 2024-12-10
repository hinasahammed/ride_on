// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      maxRow: (json['MaxRow'] as num?)?.toInt(),
      maxCol: (json['MaxCol'] as num?)?.toInt(),
      layout: json['Layout'],
      slot: (json['Slot'] as List<dynamic>?)
          ?.map((e) => Slot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'MaxRow': instance.maxRow,
      'MaxCol': instance.maxCol,
      'Layout': instance.layout,
      'Slot': instance.slot,
    };
