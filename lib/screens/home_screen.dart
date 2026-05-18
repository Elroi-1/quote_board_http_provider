import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';
import '../widgets/app_bar.dart';
import 'add_edit_quote_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          final quotes = provider.quotes;

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quote = quotes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                        Text(
                          "\"" + quote.quote + "\"",
                          style: AppTextStyles.quoteTitle,
                        ),
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
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.iconColor,
                                  ),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            AddEditQuoteScreen(quote: quote),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.delete,
                                  ),
                                  onPressed: () {
                                    provider.deleteQuote(quote.id!);
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
            },
          );
        },
      ),
    );
  }
}
