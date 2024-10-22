import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add Firebase core
import 'login.dart'; // Correct the import for your LoginPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Firebase is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
