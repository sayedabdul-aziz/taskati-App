import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('task');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                titleTextStyle: getHeadlineStyle(),
                iconTheme: IconThemeData(color: AppColors.primaryColor),
                backgroundColor: Colors.transparent,
                elevation: 0.0),
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.redColor),
                    borderRadius: BorderRadius.circular(15)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.redColor),
                    borderRadius: BorderRadius.circular(15))),
            fontFamily: GoogleFonts.poppins().fontFamily),
        debugShowCheckedModeBanner: false,
        home: const SplashView());
  }
}
