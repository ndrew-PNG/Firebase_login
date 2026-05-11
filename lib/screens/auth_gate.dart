import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';

// AuthGate - controls which screen to show based on auth state
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // Boolean to track which auth screen to display
  bool showLoginPage = true;

  // Toggle between login and register screens
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // StreamBuilder listens to authentication state changes
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If user is logged in, show home screen
        if (snapshot.hasData) {
          return HomeScreen();
        }
        // If user is not logged in, show auth screens
        else {
          if (showLoginPage) {
            return LoginScreen(onTap: togglePages);
          } else {
            return RegisterScreen(onTap: togglePages);
          }
        }
      },
    );
  }
}
