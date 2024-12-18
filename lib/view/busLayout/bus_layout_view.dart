import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/view/busLayout/widget/seat_booking_summary.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class BusLayoutView extends StatefulWidget {
  const BusLayoutView({super.key, required this.tourModel});
  final Datum tourModel;

  @override
  State<BusLayoutView> createState() => _BusLayoutViewState();
}

class _BusLayoutViewState extends State<BusLayoutView> {
  Future<void> refreshData(BuildContext context) async {
    await Provider.of<TourViewmodel>(context, listen: false)
        .fetchBusLAyout(context, widget.tourModel.code.toString());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    refreshData(context);
  }

  @override
  Widget build(BuildContext context) {
    final tourController = Provider.of<TourViewmodel>(context, listen: false);
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Seat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return refreshData(context);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Center(
                    child: SizedBox(
                      width: size.width,
                      child: FutureBuilder(
                        future: tourController.fetchBusLAyout(
                            context, widget.tourModel.code.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 200,
                              width: 500,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data?.data == null ||
                              snapshot.data!.data!.slot == null ||
                              snapshot.data!.data!.slot!.isEmpty) {
                            return Lottie.asset(Assets.images.busOngoing);
                          } else {
                            return SizedBox(
                              width: size.width,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  spacing: 10,
                                  children: List.generate(
                                    snapshot.data!.data!.maxRow!,
                                    (mainIndex) {
                                      final data = snapshot.data!.data!;
                                      return SizedBox(
                                        height: 50,
                                        child: ListView.separated(
                                          itemCount: data.maxCol!,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const Gap(10),
                                          itemBuilder: (context, index) {
                                            final seat = data.slot!
                                                .where(
                                                  (element) =>
                                                      element.rowNo ==
                                                          mainIndex + 1 &&
                                                      element.colNo ==
                                                          index + 1,
                                                )
                                                .toList();
                                            Slot seatModel = Slot();
                                            if (seat.isNotEmpty) {
                                              seatModel = seat.first;
                                            }
                                            return seat.isEmpty
                                                ? Gap(size.width * .15)
                                                : Consumer<TourViewmodel>(
                                                    builder: (context, value,
                                                            child) =>
                                                        GestureDetector(
                                                      onTap: () {
                                                        if (seatModel.reservationCode == 0 &&
                                                            seatModel
                                                                    .blockingCount ==
                                                                0 &&
                                                            seatModel
                                                                    .onProgressTicketCode ==
                                                                0 &&
                                                            seatModel
                                                                    .ticketDetailsCode ==
                                                                0) {
                                                          tourController
                                                              .selectSeat(
                                                                  seatModel);
                                                        }
                                                      },
                                                      child: Card(
                                                        margin: const EdgeInsets
                                                            .all(0),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: Container(
                                                          width:
                                                              size.width * .15,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: seatModel
                                                                            .reservationCode !=
                                                                        0 ||
                                                                    seatModel
                                                                            .blockingCount !=
                                                                        0 ||
                                                                    seatModel
                                                                            .onProgressTicketCode !=
                                                                        0 ||
                                                                    seatModel
                                                                            .ticketDetailsCode !=
                                                                        0
                                                                ? theme
                                                                    .colorScheme
                                                                    .primaryContainer
                                                                : value
                                                                        .selectedSlot
                                                                        .contains(
                                                                            seatModel)
                                                                    ? theme
                                                                        .colorScheme
                                                                        .primary
                                                                    : theme
                                                                        .colorScheme
                                                                        .surface,
                                                          ),
                                                          child: Assets
                                                              .icons.busSeat
                                                              .image(
                                                            width: 30,
                                                            color: seatModel
                                                                            .reservationCode !=
                                                                        0 ||
                                                                    seatModel
                                                                            .blockingCount !=
                                                                        0 ||
                                                                    seatModel
                                                                            .onProgressTicketCode !=
                                                                        0
                                                                ? theme
                                                                    .colorScheme
                                                                    .onPrimaryContainer
                                                                : value
                                                                        .selectedSlot
                                                                        .contains(
                                                                            seatModel)
                                                                    ? theme
                                                                        .colorScheme
                                                                        .onPrimary
                                                                    : theme
                                                                        .colorScheme
                                                                        .onSurface,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SeatBookingSummary(
            price: double.parse("${widget.tourModel.amount ?? '0.0'}"),
          ),
        ],
      ),
    );
  }
}
