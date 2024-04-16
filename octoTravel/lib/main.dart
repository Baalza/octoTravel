import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system, // Utilizza il tema del sistema
      darkTheme: ThemeData.dark(), // Tema scuro predefinito
      debugShowCheckedModeBanner: false,
      title: 'Il titolo della tua app',
      home: Builder(
        builder: (context) {
          return MaterialApp(
            themeMode: ThemeMode.system, // Utilizza il tema del sistema
            darkTheme: ThemeData.dark(), // Tema scuro predefinito
            debugShowCheckedModeBanner: false,
            initialRoute: '/', // Rotta iniziale per lo splash screen
            routes: {
              '/': (context) => SplashScreen(), // Rotta per lo splash screen
              '/home': (context) => HomeScreen(), // Rotta per la home page
            },
          );
        },
      ),
    );
  }
}
