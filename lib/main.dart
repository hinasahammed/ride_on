import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/repository/authRepository/auth_repo.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';
import 'package:ride_on/view/home/home_view.dart';
import 'package:ride_on/view/splash/splash_view.dart';
import 'package:ride_on/viewmodel/controller/auth_controller.dart';
import 'package:ride_on/viewmodel/controller/tour_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthRepo _authRepo;
  late ApiStorageRepo _storageRepository;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepo();
    _storageRepository = ApiStorageRepo();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(authRepo: _authRepo),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              TourController(storageRepository: _storageRepository),
        )
      ],
      child: MaterialApp(
        title: 'Ride On',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffDBDBDB),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          textTheme: GoogleFonts.robotoTextTheme(),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
