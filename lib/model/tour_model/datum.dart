import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'Code')
  int? code;
  @JsonKey(name: 'FileNo')
  String? fileNo;
  @JsonKey(name: 'Barcode')
  int? barcode;
  @JsonKey(name: 'TypeCode')
  int? typeCode;
  @JsonKey(name: 'Name')
  String? name;
  @JsonKey(name: 'NoOfDays')
  int? noOfDays;
  @JsonKey(name: 'MaximumSeat')
  int? maximumSeat;
  @JsonKey(name: 'MinimumAdvanceAmt')
  int? minimumAdvanceAmt;
  int? isPackage;
  @JsonKey(name: 'VehicleCode')
  int? vehicleCode;
  @JsonKey(name: 'StartDate')
  String? startDate;
  @JsonKey(name: 'EndDate')
  String? endDate;
  @JsonKey(name: 'Details')
  String? details;
  @JsonKey(name: 'TermsAndCondetion')
  String? termsAndCondetion;
  @JsonKey(name: 'CancelPolicy')
  String? cancelPolicy;
  @JsonKey(name: 'BoardingPoint')
  String? boardingPoint;
  @JsonKey(name: 'BoardingTime')
  String? boardingTime;
  @JsonKey(name: 'Amount')
  int? amount;
  @JsonKey(name: 'DOT')
  String? dot;
  @JsonKey(name: 'PostedBy')
  int? postedBy;
  @JsonKey(name: 'IsActive')
  int? isActive;
  @JsonKey(name: 'GuideName')
  String? guideName;
  @JsonKey(name: 'GuideContactNo')
  String? guideContactNo;
  @JsonKey(name: 'Layout')
  String? layout;
  @JsonKey(name: 'ContactNo')
  dynamic contactNo;
  @JsonKey(name: 'BookingEndDate')
  String? bookingEndDate;
  @JsonKey(name: 'BranchCode')
  int? branchCode;
  @JsonKey(name: 'TourType')
  dynamic tourType;
  @JsonKey(name: 'AvailableSeat')
  int? availableSeat;
  @JsonKey(name: 'VehicleNo')
  dynamic vehicleNo;
  @JsonKey(name: 'VehicleDetails')
  dynamic vehicleDetails;
  @JsonKey(name: 'DriverName')
  dynamic driverName;
  @JsonKey(name: 'DriverPhoneNo')
  dynamic driverPhoneNo;
  @JsonKey(name: 'TourTypeName')
  dynamic tourTypeName;
  @JsonKey(name: 'PNR')
  int? pnr;

  Datum({
    this.code,
    this.fileNo,
    this.barcode,
    this.typeCode,
    this.name,
    this.noOfDays,
    this.maximumSeat,
    this.minimumAdvanceAmt,
    this.isPackage,
    this.vehicleCode,
    this.startDate,
    this.endDate,
    this.details,
    this.termsAndCondetion,
    this.cancelPolicy,
    this.boardingPoint,
    this.boardingTime,
    this.amount,
    this.dot,
    this.postedBy,
    this.isActive,
    this.guideName,
    this.guideContactNo,
    this.layout,
    this.contactNo,
    this.bookingEndDate,
    this.branchCode,
    this.tourType,
    this.availableSeat,
    this.vehicleNo,
    this.vehicleDetails,
    this.driverName,
    this.driverPhoneNo,
    this.tourTypeName,
    this.pnr,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
