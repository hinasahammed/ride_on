// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourModel _$TourModelFromJson(Map<String, dynamic> json) => TourModel(
      responseCode: (json['ResponseCode'] as num?)?.toInt(),
      message: json['Message'] as String?,
      data: (json['Data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TourModelToJson(TourModel instance) => <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'Message': instance.message,
      'Data': instance.data,
    };
