import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/data/repositories/task_repository_impl.dart';
import 'package:untitled3/presentation/home_screen.dart';
import 'package:untitled3/presentation/process_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                )
            ),
          )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter API TEST',
      home: HomeScreen(),
    );
  }
}
