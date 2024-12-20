import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/model/bus_layout_model/slot.dart';
import 'package:ride_on/viewmodel/provider/seat_layout_viewmodel.dart';

class SeatItems extends StatelessWidget {
  const SeatItems({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final tourController = Provider.of<SeatLayoutViewmodel>(context, listen: false);
    return Consumer<SeatLayoutViewmodel>(
      builder: (context, value, child) => Container(
        width: size.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: .3),
          ),
        ),
        child: Column(
          spacing: 10,
          children: List.generate(
            value.busLayout.maxRow ?? 0,
            (mainIndex) {
              final data = value.busLayout;
              return SizedBox(
                height: 45,
                child: ListView.separated(
                  itemCount: data.maxCol!,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const Gap(10),
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
                      seatModel = seat.first;
                    }
                    return seat.isEmpty
                        ? Gap(size.width * .1)
                        : GestureDetector(
                            onTap: () {
                              if (seatModel.reservationCode == 0 &&
                                  seatModel.blockingCount == 0 &&
                                  seatModel.onProgressTicketCode == 0 &&
                                  seatModel.ticketDetailsCode == 0) {
                                tourController.selectSeat(seatModel);
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                  width: size.width * .1,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: seatModel.reservationCode != 0 ||
                                            seatModel.blockingCount != 0 ||
                                            seatModel.onProgressTicketCode !=
                                                0 ||
                                            seatModel.ticketDetailsCode != 0
                                        ? theme.colorScheme.primaryContainer
                                        : value.selectedSlot.contains(seatModel)
                                            ? theme.colorScheme.primary
                                            : theme.colorScheme.surface,
                                  ),
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      const Gap(2),
                                      Assets.icons.busSeat.image(
                                        width: 25,
                                        color: value.selectedSlot
                                                .contains(seatModel)
                                            ? theme.colorScheme.onPrimary
                                            : theme.colorScheme.onSurface,
                                      ),
                                      Text(
                                        seatModel.slotNumber.toString(),
                                        style: theme.textTheme.labelSmall!
                                            .copyWith(
                                          color: value.selectedSlot
                                                  .contains(seatModel)
                                              ? theme.colorScheme.onPrimary
                                              : theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  )),
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
}
