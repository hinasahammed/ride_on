import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/view/busLayout/widget/seat_booking_summary.dart';
import 'package:ride_on/viewmodel/controller/tour_controller.dart';

class BusLayout extends StatefulWidget {
  const BusLayout({super.key, required this.tourModel});
  final Datum tourModel;

  @override
  State<BusLayout> createState() => _BusLayoutState();
}

class _BusLayoutState extends State<BusLayout> {
  Future<void> refreshData(BuildContext context) async {
    await Provider.of<TourController>(context, listen: false)
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
    final tourController = Provider.of<TourController>(context, listen: false);
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
                children: [
                  Center(
                    child: SizedBox(
                      width: size.width * .95,
                      child: FutureBuilder(
                        future: tourController.fetchBusLAyout(
                            context, widget.tourModel.code.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
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
                              child: ListView.builder(
                                itemCount: snapshot.data!.data!.maxRow,
                                padding: const EdgeInsets.all(16),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, mainIndex) {
                                  final data = snapshot.data!.data!;
                                  return Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: size.width,
                                      child: ListView.builder(
                                          itemCount: data.maxCol!,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
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
                                              seatModel = seat
                                                  .where(
                                                    (element) =>
                                                        element.rowNo ==
                                                            mainIndex + 1 &&
                                                        element.colNo ==
                                                            index + 1,
                                                  )
                                                  .toList()
                                                  .first;
                                            }
                                            return seat.isEmpty
                                                ? Gap(size.width * .15)
                                                : Consumer<TourController>(
                                                    builder: (context, value,
                                                            child) =>
                                                        GestureDetector(
                                                      onTap: () {
                                                        if (seatModel.reservationCode == 0 ||
                                                            seatModel
                                                                    .blockingCount ==
                                                                0 ||
                                                            seatModel
                                                                    .onProgressTicketCode ==
                                                                0) {
                                                          tourController
                                                              .selectSeat(
                                                                  seatModel);
                                                        }
                                                      },
                                                      child: Card(
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        child: Container(
                                                          width:
                                                              size.width * .15,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          15),
                                                                  border: Border.all(
                                                                      color: theme
                                                                          .colorScheme
                                                                          .primary),
                                                                  color: seatModel.reservationCode != 0 ||
                                                                          seatModel.blockingCount !=
                                                                              0 ||
                                                                          seatModel.onProgressTicketCode !=
                                                                              0
                                                                      ? theme
                                                                          .colorScheme
                                                                          .primaryContainer
                                                                      : value.selectedSlot.contains(
                                                                              seatModel)
                                                                          ? theme
                                                                              .colorScheme
                                                                              .primary
                                                                          : theme
                                                                              .colorScheme
                                                                              .surface),
                                                          child: Assets
                                                              .icons.busSeat
                                                              .image(
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
                                          }),
                                    ),
                                  );
                                },
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
          const SeatBookingSummary(),
        ],
      ),
    );
  }
}
