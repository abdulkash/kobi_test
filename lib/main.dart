import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobi_test/core/utils/colors.dart';
import 'package:kobi_test/core/utils/hex_color.dart';
import 'package:kobi_test/core/utils/theme.dart';
import 'package:kobi_test/src/view/pages/transaction_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // appBarTheme: const AppBarTheme(
            //     titleTextStyle: TextStyle(
            //   fontSize: 16,
            // )),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              surface: AppColors.primary,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.black,
            appBarTheme: AppBarTheme(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: AppColors.black,
              scrolledUnderElevation: 0,
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: -0.5,
                fontSize: 16,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                minimumSize: WidgetStatePropertyAll(Size(MediaQuery.sizeOf(context).width, 50)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: WidgetStateProperty.resolveWith((state) {
                  if (state.contains(WidgetState.disabled)) {
                    return AppColors.grey800;
                  }
                  return AppColors.primary;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((state) {
                  if (state.contains(WidgetState.disabled)) {
                    return AppColors.grey500;
                  }
                  return Colors.black;
                }),
                textStyle: WidgetStatePropertyAll(
                  context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Inter',
                    letterSpacing: -0.5,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            textTheme: Typography.blackCupertino.apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            )),
        home: const TransactionPage(),
      );
    });
  }
}
