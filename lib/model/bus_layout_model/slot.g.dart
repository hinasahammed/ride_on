// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
      code: (json['Code'] as num?)?.toInt(),
      slotNumber: (json['SlotNumber'] as num?)?.toInt(),
      tourCode: (json['TourCode'] as num?)?.toInt(),
      ticketDetailsCode: (json['TicketDetailsCode'] as num?)?.toInt(),
      reservationCode: (json['ReservationCode'] as num?)?.toInt(),
      blockingCount: (json['BlockingCount'] as num?)?.toInt(),
      onProgressTicketCode: (json['OnProgressTicketCode'] as num?)?.toInt(),
      rowNo: (json['RowNo'] as num?)?.toInt(),
      colNo: (json['ColNo'] as num?)?.toInt(),
      index: (json['Index_'] as num?)?.toInt(),
      message: json['Message'],
      freezTime: json['FreezTime'],
    );

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'Code': instance.code,
      'SlotNumber': instance.slotNumber,
      'TourCode': instance.tourCode,
      'TicketDetailsCode': instance.ticketDetailsCode,
      'ReservationCode': instance.reservationCode,
      'BlockingCount': instance.blockingCount,
      'OnProgressTicketCode': instance.onProgressTicketCode,
      'RowNo': instance.rowNo,
      'ColNo': instance.colNo,
      'Index_': instance.index,
      'Message': instance.message,
      'FreezTime': instance.freezTime,
    };
