import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'providers/music_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => MusicProvider(),
      child: MusicPlayerApp(),
    ),
  );
}

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        sliderTheme: SliderThemeData(
          thumbColor: Colors.green,
          activeTrackColor: Colors.green,
          inactiveTrackColor: Colors.grey,
        ),
      ),
      home: LoginScreen(),
    );
  }
}