import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'providers/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ChatService>(
      create: (_) => ChatService(),
      child: MaterialApp(
        title: 'Coastal Tourism App',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.teal,
        ),
        routes: {
          '/': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}