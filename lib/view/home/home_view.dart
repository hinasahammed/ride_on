import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';
import 'package:ride_on/view/bookingDetails/booking_details.dart';
import 'package:ride_on/viewmodel/controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    ApiStorageRepo().fetchTourBooking();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: FutureBuilder(
        future: HomeController().fetchTourList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.onSurface,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No data found"),
            );
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.data!.length,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                var data = snapshot.data!.data![index];
                return Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(0),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetails(
                            tourModel: data,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name ?? '',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.event_seat,
                                size: 20.0,
                                color:
                                    theme.colorScheme.onSurface.withOpacity(.8),
                              ),
                              const Gap(5),
                              Text(
                                "Available: ${data.availableSeat} ",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                "${data.startDate ?? ''} - ${data.endDate ?? ''}",
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹${data.amount}",
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
