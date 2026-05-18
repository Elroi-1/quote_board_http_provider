import 'package:flutter/material.dart';
import 'package:quote_board_http_provider/features/quotes/data/models/quote.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/providers/quote_provider.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/screens/add_edit_quote_screen.dart';
import 'package:quote_board_http_provider/theme/app_colors.dart';
import 'package:quote_board_http_provider/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('"${quote.quote}"', style: AppTextStyles.quoteTitle),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quote.author,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: AppColors.iconColor),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditQuoteScreen(quote: quote),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: AppColors.delete),
                        onPressed: () {
                          context.read<QuoteProvider>().deleteQuote(quote.id!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
