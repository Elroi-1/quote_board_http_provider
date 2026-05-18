import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_board_http_provider/features/quotes/data/repositories/quote_repository.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/providers/quote_provider.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/screens/home_screen.dart';
import 'package:quote_board_http_provider/theme/app_colors.dart';

void main() {
  final quoteRepository = QuoteRepository();

  runApp(
    ChangeNotifierProvider(
      create: (_) => QuoteProvider(quoteRepository: quoteRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.appBackground),
        home: HomeScreen(),
      ),
    ),
  );
}
