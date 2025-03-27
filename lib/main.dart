import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfirebase/firebase_options.dart';
import 'package:myfirebase/screens/auth/login/login_screen.dart';
import 'package:myfirebase/screens/home/home_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final Map<int, Color> _yellowMap = {
  50: Colors.yellow,
  100: Colors.yellow.shade100,
  200: Colors.yellow.shade200,
  300: Colors.yellow.shade300,
  400: Colors.yellow.shade400,
  500: Colors.yellow.shade500,
  600: Colors.yellow.shade600,
  700: Colors.yellow.shade700,
  800: Colors.yellow.shade800,
  900: Colors.yellow.shade900,
};

final Map<int, Color> _blueMap = {
  50: Colors.blue,
  100: Colors.blue.shade100,
  200: Colors.blue.shade200,
  300: Colors.blue.shade300,
  400: Colors.blue.shade400,
  500: Colors.blue.shade500,
  600: Colors.blue.shade600,
  700: Colors.blue.shade700,
  800: Colors.blue.shade800,
  900: Colors.blue.shade900,
};

var lightColorScheme = ColorScheme.fromSwatch(
  primarySwatch:
      MaterialColor(const Color.fromARGB(255, 252, 181, 21).value, _yellowMap),
  accentColor:
      MaterialColor(const Color.fromARGB(255, 9, 125, 234).value, _blueMap),
);

var darkColorScheme = ColorScheme.fromSwatch(
  brightness: Brightness.dark,
  primarySwatch:
      MaterialColor(const Color.fromARGB(255, 252, 181, 21).value, _yellowMap),
  accentColor:
      MaterialColor(const Color.fromARGB(255, 0, 50, 98).value, _blueMap),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'My Firebase',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: darkColorScheme,
        ),
        theme: ThemeData.light().copyWith(
          colorScheme: lightColorScheme,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint("Auth error: ${snapshot.error}");
              return const Scaffold(
                body: Center(
                  child: Text('Error terjadi, coba lagi.'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      );
    });
  }
}
