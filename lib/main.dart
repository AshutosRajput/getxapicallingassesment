import 'package:assignmentjoyistick/controllers/googlecontroller/googlecontroler.dart';
import 'package:assignmentjoyistick/screens/home/homes.dart';
import 'package:assignmentjoyistick/screens/login/login.dart';
import 'package:assignmentjoyistick/utility/routes/approutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set transparent or your desired color
    statusBarIconBrightness: Brightness.dark, // Change status bar icons to dark (optional)
    systemNavigationBarColor: Colors.transparent, // Set transparent or your desired color
    systemNavigationBarIconBrightness: Brightness.dark, // Change navigation bar icons to dark (optional)
  ));
  GoogleSignInService.getUserInfoFromSharedPrefs();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screnSize=MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute
    );
  }

}


late Size screnSize;