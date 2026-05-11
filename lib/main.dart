import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/auth_gate.dart';

// Entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Firebase',
      // Dark theme for the app
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      // AuthGate - starts the app showing login/register screens
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
