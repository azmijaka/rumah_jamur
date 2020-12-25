//import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumah_jamur/screens/screens.dart';

//fungsi main
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//widget app
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init,
      builder: (context, snapshot) {
        //No Internet
        if (snapshot.hasError) {
          return ErrorScreen();
        }
        //Main App
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/welcome',
            getPages: [
              GetPage(name: '/qrview', page: () => QrView()),
              GetPage(name: '/jadwal', page: () => ListPresensi()),
              GetPage(name: '/success', page: () => SuccessScreen()),
              GetPage(name: '/code', page: () => CodePresensi()),
              GetPage(name: '/welcome', page: () => WelcomeScreen()),
              GetPage(name: '/login', page: () => LoginScreen()),
              GetPage(name: '/register', page: () => RegisterScreen()),
              GetPage(name: '/home', page: () => HomeScreen()),
              GetPage(name: '/profile', page: () => ProfileScreen()),
              GetPage(name: '/error', page: () => ErrorScreen()),
              GetPage(name: '/peserta', page: () => ListPeserta()),
              GetPage(name: '/detail', page: () => DetailPeserta()),
              GetPage(name: '/izin', page: () => IzinScreen()),
              GetPage(name: '/addberita', page: () => AddBeritaScreen()),
              GetPage(name: '/detailberita', page: () => DetailBerita()),
              GetPage(name: '/listberita', page: () => ListBerita()),
            ],
          );
        }
        //Loading
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xFFd1a17b)),
          ),
        );
      },
    );
  }
}
