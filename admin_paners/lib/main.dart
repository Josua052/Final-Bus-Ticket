import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

// Import halaman Admin
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart'; // Jika login screen adalah bagian dari aplikasi admin
import 'screens/admin_home_screen.dart';
import 'screens/kelola_bus.dart'; // Contoh halaman admin lain
import 'screens/kelola_penumpang.dart';
import 'screens/detail_penumpang.dart'; // Detail penumpang (punya background gelap)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start of updated code for global System UI Overlay Style
  // 🎨 Atur style sistem UI global:
  // Default untuk sebagian besar halaman yang mungkin memiliki background terang.
  // Status bar background putih, ikon status bar hitam.
  // Navigation bar background putih, ikon navigation bar hitam (KONSTAN).
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Default Background Status Bar PUTIH
      statusBarIconBrightness: Brightness.dark, // Default: ikon Status Bar hitam
      statusBarBrightness: Brightness.light,    // Untuk iOS: teks gelap

      systemNavigationBarColor: Colors.white, // Background Navigation Bar KONSTAN PUTIH
      systemNavigationBarIconBrightness: Brightness.dark, // Ikon Navigation Bar KONSTAN HITAM
    ),
  );
  // End of updated code for global System UI Overlay Style

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String adminHomeRoute = '/admin_home_screen';
  static const String kelolaPenumpangRoute = '/kelola_penumpang_screen';
  static const String kelolaBusRoute = '/kelola_bus_screen'; // Tambahkan route kelola bus
  static const String detailPenumpangRoute = '/detail_penumpang_screen'; // Tambahkan route detail penumpang

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Admin Paners',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF5F6FA), // Background default aplikasi (terang)
            primaryColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, // Default AppBar background putih
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black), // Ikon di AppBar hitam
              // systemOverlayStyle ini mengatur ikon status bar ketika AppBar ini aktif.
              // Karena AppBarTheme ini putih, ikon status bar harus gelap (dark).
              systemOverlayStyle: SystemUiOverlayStyle.dark, // Ikon status bar hitam untuk AppBar yang cerah
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
          ),
          initialRoute: splashRoute,
          routes: {
            splashRoute: (context) => SplashScreen(),
            loginRoute: (context) => LoginScreen(),
            adminHomeRoute: (context) => AdminHomeScreen(),
            kelolaPenumpangRoute: (context) => KelolaPenumpangScreen(),
            kelolaBusRoute: (context) => KelolaBusScreen(),
            detailPenumpangRoute: (context) => DetailPenumpangScreen(pemesanan: ModalRoute.of(context)!.settings.arguments as dynamic), // Pastikan ini menangani argumen
          },
        );
      },
    );
  }
}