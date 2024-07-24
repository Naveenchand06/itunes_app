import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:itunes_app/src/app.dart";
import "package:itunes_app/src/constants/app_colors.dart";

// * SSL HASH - 8317efefe33594d2b38a267bbfc690ed0e4a14a8bd44aa3efa9db1eecde19677
// SHA256 - 52:BD:C3:ED:42:F3:A2:33:E3:63:12:D8:56:70:62:50:03:DF:56:08:17:DF:D3:FC:DE:07:14:71:CA:30:91:49

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iTunes',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.secondary,
                // fontWeight: FontWeight.w500,
              ),
          iconTheme: const IconThemeData(
            color: AppColors.secondary,
          ),
          elevation: 0.0,
        ),
        listTileTheme: const ListTileThemeData(
          textColor: AppColors.secondary,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        ),
      ),
      home: const App(),
    );
  }
}
