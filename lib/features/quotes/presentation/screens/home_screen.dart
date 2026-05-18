import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/providers/quote_provider.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/screens/add_edit_quote_screen.dart';
import 'package:quote_board_http_provider/features/quotes/presentation/widgets/quote_card.dart';
import 'package:quote_board_http_provider/theme/app_colors.dart';
import 'package:quote_board_http_provider/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<QuoteProvider>(context, listen: false).fetchQuotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quote Board HTTP Provider"),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditQuoteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<QuoteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.quotes.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null && provider.quotes.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 64,
                      color: AppColors.delete,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load quotes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Could not connect to the server.\nPlease check your internet connection and try again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => provider.fetchQuotes(),
                      icon: Icon(Icons.refresh),
                      label: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final quotes = provider.quotes;

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              return QuoteCard(quote: quotes[index]);
            },
          );
        },
      ),
    );
  }
}
