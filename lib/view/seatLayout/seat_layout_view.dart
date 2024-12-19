import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/data/response/status.dart';
import 'package:ride_on/model/tour_model/datum.dart';
import 'package:ride_on/view/seatLayout/widget/seat_items.dart';
import 'package:ride_on/view/seatLayout/widget/seat_booking_summary.dart';
import 'package:ride_on/viewmodel/provider/tour_viewmodel.dart';

class SeatLayoutView extends StatefulWidget {
  const SeatLayoutView({super.key, required this.tourModel});
  final Datum tourModel;

  @override
  State<SeatLayoutView> createState() => _SeatLayoutViewState();
}

class _SeatLayoutViewState extends State<SeatLayoutView> {
  Future<void> refreshData(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<TourViewmodel>(context, listen: false)
          .fetchBusLAyoutTesting(context, widget.tourModel.code.toString());
      if (context.mounted) {
        Provider.of<TourViewmodel>(context, listen: false).clearSelectedSeat();
      }
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
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        tourController.clearSelectedSeat();
        if (!didPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              tourController.clearSelectedSeat();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: theme.colorScheme.onSurface,
            ),
          ),
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
                        Status.loading => Container(
                            padding: const EdgeInsets.all(8),
                            height: size.height * .7,
                            child: const Center(
                                child: CircularProgressIndicator())),
                        Status.error => const Text("No layout found"),
                        Status.completed => const SeatItems(),
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
      ),
    );
  }
}
