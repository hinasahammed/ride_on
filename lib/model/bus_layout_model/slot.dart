import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable()
class Slot {
	@JsonKey(name: 'Code') 
	int? code;
	@JsonKey(name: 'SlotNumber') 
	int? slotNumber;
	@JsonKey(name: 'TourCode') 
	int? tourCode;
	@JsonKey(name: 'TicketDetailsCode') 
	int? ticketDetailsCode;
	@JsonKey(name: 'ReservationCode') 
	int? reservationCode;
	@JsonKey(name: 'BlockingCount') 
	int? blockingCount;
	@JsonKey(name: 'OnProgressTicketCode') 
	int? onProgressTicketCode;
	@JsonKey(name: 'RowNo') 
	int? rowNo;
	@JsonKey(name: 'ColNo') 
	int? colNo;
	@JsonKey(name: 'Index_') 
	int? index;
	@JsonKey(name: 'Message') 
	dynamic message;
	@JsonKey(name: 'FreezTime') 
	dynamic freezTime;

	Slot({
		this.code, 
		this.slotNumber, 
		this.tourCode, 
		this.ticketDetailsCode, 
		this.reservationCode, 
		this.blockingCount, 
		this.onProgressTicketCode, 
		this.rowNo, 
		this.colNo, 
		this.index, 
		this.message, 
		this.freezTime, 
	});

	factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

	Map<String, dynamic> toJson() => _$SlotToJson(this);
}
