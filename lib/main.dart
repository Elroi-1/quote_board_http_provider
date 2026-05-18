import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/quote_provider.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuoteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.appBackground),
        home: HomeScreen(),
      ),
    ),
  );
}
