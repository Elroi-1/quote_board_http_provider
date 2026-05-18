import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../bloc/quote_event.dart';
import '../bloc/quote_state.dart';
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
    context.read<QuoteBloc>().add(GetQuotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quote Board"),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditQuoteScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteLoading || state is QuoteInitial) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is QuoteError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is QuoteLoaded) {
            final quotes = state.quotes;

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
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
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
                                      context.read<QuoteBloc>().add(
                                        DeleteQuoteEvent(quote.id!),
                                      );
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
          }

          return Container(); // Should never reach here
        },
      ),
    );
  }
}
