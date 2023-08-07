import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'views/screens/home_screen.dart';

const supabaseUrl = 'https://oobuzeddpbkwmmxbriwm.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vYnV6ZWRkcGJrd21teGJyaXdtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTEyOTI4MzAsImV4cCI6MjAwNjg2ODgzMH0.qQE7CPTBe6UkSVAltGO8-54JRkELt5LUWMOx5armygk';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laverie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
