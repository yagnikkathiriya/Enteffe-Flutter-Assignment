import 'package:enteffe_interview_task/bottombar/bottombar_screen.dart';
import 'package:enteffe_interview_task/helper/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ColorHelper.whiteColor,
          surfaceTintColor: ColorHelper.whiteColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: BottombarScreen(),
    );
  }
}
