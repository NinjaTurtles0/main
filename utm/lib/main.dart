import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utm/pages/Screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAEyUD2nwl89oXzbyM-6_ZQSzjFVGOydV8",
      appId: "1:612047402921:android:9051134e05c7cd149e76b8",
      messagingSenderId: "612047402921",
      projectId: "utmfood-c49b0",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTMFood',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}
