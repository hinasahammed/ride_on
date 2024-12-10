import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/model/tour_model/datum.dart';
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
        title: const Text("Details"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return refreshData(context);
        },
        child: ListView(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: FutureBuilder(
                future: tourController.fetchBusLAyout(
                    context, widget.tourModel.code.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData ||
                      snapshot.data?.data == null ||
                      snapshot.data!.data!.slot == null ||
                      snapshot.data!.data!.slot!.isEmpty) {
                    return const Center(
                      child: Text("No Layout Found!"),
                    );
                  } else {
                    return SizedBox(
                      width: size.width,
                      child: ListView.builder(
                        itemCount: snapshot.data!.data!.maxRow,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, mainIndex) {
                          final data = snapshot.data!.data!;
                          return SizedBox(
                            height: 50,
                            width: size.width,
                            child: ListView.builder(
                                itemCount: data.maxCol!,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final seat = data.slot!
                                      .where(
                                        (element) =>
                                            element.rowNo == mainIndex + 1 &&
                                            element.colNo == index + 1,
                                      )
                                      .toList();
                                  Slot seatModel = Slot();
                                  if (seat.isNotEmpty) {
                                    seatModel = seat
                                        .where(
                                          (element) =>
                                              element.rowNo == mainIndex + 1 &&
                                              element.colNo == index + 1,
                                        )
                                        .toList()
                                        .first;
                                  }
                                  return seat.isEmpty
                                      ? Gap(size.width * .12)
                                      : Card(
                                          clipBehavior: Clip.hardEdge,
                                          margin: const EdgeInsets.all(5),
                                          child: Container(
                                            width: size.width * .15$^ ,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: seatModel.reservationCode != 0 &&
                                                      seatModel.blockingCount !=
                                                          0 &&
                                                      seatModel
                                                              .onProgressTicketCode !=
                                                          0
                                                  ? theme.colorScheme.primary
                                                  : theme.colorScheme.primary
                                                      .withOpacity(.1),
                                            ),
                                            child: Text(
                                              seat
                                                  .where(
                                                    (element) =>
                                                        element.rowNo ==
                                                            mainIndex + 1 &&
                                                        element.colNo ==
                                                            index + 1,
                                                  )
                                                  .toList()
                                                  .first
                                                  .slotNumber
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                }),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
