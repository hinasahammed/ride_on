import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/view/busLayout/widget/seat_booking_summary.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';

class BusLayoutTest extends StatefulWidget {
  const BusLayoutTest({super.key, required this.tourModel});
  final Datum tourModel;

  @override
  State<BusLayoutTest> createState() => _BusLayoutTestState();
}

class _BusLayoutTestState extends State<BusLayoutTest> {
  Future<void> refreshData(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<TourViewmodel>(context, listen: false)
          .fetchBusLAyoutTesting(context, widget.tourModel.code.toString());
    });
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
        leading: IconButton(
            onPressed: () {
              tourController.clearSelectedSeat();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: theme.colorScheme.onSurface,
            )),
        title: const Text("Choose Your Seat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return refreshData(context);
              },
              child: Consumer<TourViewmodel>(
                builder: (context, value, child) => ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Center(
                        child: switch (value.status) {
                      Status.loading => const CircularProgressIndicator(),
                      Status.error => const Text("No layout found"),
                      Status.completed => Container(
                          width: size.width,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: .3),
                            ),
                          ),
                          child: Column(
                            spacing: 10,
                            children: List.generate(
                              value.busLayout.maxRow!,
                              (mainIndex) {
                                final data = value.busLayout;
                                return SizedBox(
                                  height: 40,
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
                                                element.colNo == index + 1,
                                          )
                                          .toList();
                                      Slot seatModel = Slot();
                                      if (seat.isNotEmpty) {
                                        seatModel = seat.first;
                                      }
                                      return seat.isEmpty
                                          ? Gap(size.width * .1)
                                          : Consumer<TourViewmodel>(
                                              builder:
                                                  (context, value, child) =>
                                                      GestureDetector(
                                                onTap: () {
                                                  if (seatModel.reservationCode == 0 &&
                                                      seatModel.blockingCount ==
                                                          0 &&
                                                      seatModel
                                                              .onProgressTicketCode ==
                                                          0 &&
                                                      seatModel
                                                              .ticketDetailsCode ==
                                                          0) {
                                                    tourController
                                                        .selectSeat(seatModel);
                                                  }
                                                },
                                                child: Card(
                                                  margin:
                                                      const EdgeInsets.all(0),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Container(
                                                    width: size.width * .1,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
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
                                                          ? theme.colorScheme
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
                                                    child: Assets.icons.busSeat
                                                        .image(
                                                      width: 25,
                                                      color: seatModel
                                                                      .reservationCode !=
                                                                  0 ||
                                                              seatModel
                                                                      .blockingCount !=
                                                                  0 ||
                                                              seatModel
                                                                      .onProgressTicketCode !=
                                                                  0
                                                          ? theme.colorScheme
                                                              .onPrimaryContainer
                                                          : value.selectedSlot
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
                    }),
                  ],
                ),
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
