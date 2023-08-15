import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscann/pages/home_page.dart';
import 'package:qrscann/pages/validation_page.dart';
import 'package:qrscann/provider/scan_list_provider.dart';
import 'package:qrscann/provider/ui_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UiProvider()),
        ChangeNotifierProvider(create: (_)=>ScanListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Entregas',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'validation' : (_) => const ValidationPage(),
        },
        theme: ThemeData(),
      ),
    );
  }
}