import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart' as myhome;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbRef = FirebaseDatabase.instance.ref("payments/latest/amount");
  final FlutterTts tts = FlutterTts();
  String liveText = "Waiting...";

  @override
  void initState() {
    super.initState();

    initVoice();

    dbRef.onValue.listen((event) async {
      String message = event.snapshot.value.toString();

      setState(() {
        liveText = message;
      });
      await tts.speak("$message rupees received in your bank account");
    });
  }

  Future initVoice() async {
    await tts.setLanguage("en-IN");

    await tts.setSpeechRate(0.4);

    await tts.setVolume(1.0);

    await tts.speak("System ready");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const AppStarter(),
    );
  }
}

class AppStarter extends StatefulWidget {
  const AppStarter({super.key});

  @override
  State<AppStarter> createState() => _AppStarterState();
}

class _AppStarterState extends State<AppStarter> {
  bool? setupDone;

  @override
  void initState() {
    super.initState();
    checkSetup();
  }

  Future<void> checkSetup() async {
    final prefs = await SharedPreferences.getInstance();

    setupDone = prefs.getBool('setupCompleted') ?? false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (setupDone == null) {
      return const Scaffold(
        backgroundColor: Colors.black,

        body: Center(child: CircularProgressIndicator()),
      );
    }

    return SplashScreen();
  }
}
