// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_layout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusLayoutModel _$BusLayoutModelFromJson(Map<String, dynamic> json) =>
    BusLayoutModel(
      responseCode: (json['ResponseCode'] as num?)?.toInt(),
      message: json['Message'] as String?,
      data: json['Data'] == null
          ? null
          : Data.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BusLayoutModelToJson(BusLayoutModel instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'Message': instance.message,
      'Data': instance.data,
    };
