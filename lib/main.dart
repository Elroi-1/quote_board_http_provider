import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home_screen.dart';
import 'bloc/quote_bloc.dart';
import 'service/quote_service.dart';
import 'theme/app_colors.dart';

void main() {
  final quoteService = QuoteService();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => QuoteBloc(quoteService))],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: AppColors.appBackground),
        home: HomeScreen(),
      ),
    ),
  );
}
