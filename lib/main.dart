import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/repository/authRepository/auth_repo.dart';
import 'package:ride_on/repository/storageRepository/api_storage_repo.dart';
import 'package:ride_on/view/splash/splash_view.dart';
import 'package:ride_on/viewmodel/provider/auth_controller.dart';
import 'package:ride_on/viewmodel/provider/tour_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  runApp(MyApp(
    preferences: pref,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.preferences});
  final SharedPreferences preferences;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthRepo _authRepo;
  late ApiStorageRepo _storageRepository;

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepo(preferences: widget.preferences);
    _storageRepository = ApiStorageRepo();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewmodel(authRepo: _authRepo),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              TourViewmodel(storageRepository: _storageRepository),
        )
      ],
      child: MaterialApp(
        title: 'Ride On',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xfff2f8fc),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff064374),
            primary: const Color(0xff064374),
            onPrimary: const Color(0xffffffff),
          ),
          textTheme: GoogleFonts.robotoTextTheme(),
          useMaterial3: true,
        ),
        home: const SplashView(),
      ),
    );
  }
}
