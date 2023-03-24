import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testfluttr1/pages/meswhish.dart';
import 'package:testfluttr1/pages/splashscreen_wrapper.dart';
import 'package:testfluttr1/services/authentification.dart';
import 'models/user.dart';
import 'pages/connexion_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "FlutterProjet",
    options: const FirebaseOptions(
        apiKey: "AIzaSyDYZCRZnfGoDArLrb5QSmmyYP6BuyvHwzU",
        appId: "1:678017101922:web:a1a3f2792c862be951a13b",
        messagingSenderId: "678017101922",
        projectId: "flutterprojet-a8f52",
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthentificationService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Project',
        debugShowCheckedModeBanner: false,
        home: SplashScreenWrapper(),
      ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthentificationService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Project',
        debugShowCheckedModeBanner: false,
        home: SplashScreenWrapper(),
      ),
    );
  }
}
*/


/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ConnexionPage(),
    );
  }
}
 */