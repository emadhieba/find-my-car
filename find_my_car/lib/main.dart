import 'package:find_my_car/screens/home_screen.dart';
import 'package:find_my_car/screens/maps/mapsScreen.dart';
import 'package:find_my_car/screens/onboarding/onBoarding.dart';
import 'package:find_my_car/sheard/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme ,
      darkTheme: lightTheme ,
      themeMode: ThemeMode.light ,
      home: OnBoarding(),
    );
  }

}
