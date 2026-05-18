import 'package:flutter/material.dart';

import '../../data/models/quote.dart';
import '../../data/repositories/quote_repository.dart';

class QuoteProvider extends ChangeNotifier {
  final QuoteRepository _quoteRepository;

  QuoteProvider({QuoteRepository? quoteRepository})
      : _quoteRepository = quoteRepository ?? QuoteRepository();

  List<Quote> _quotes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Quote> get quotes => _quotes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchQuotes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _quotes = await _quoteRepository.getQuotes();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addQuote(Quote quote) async {
    await _quoteRepository.addQuote(quote);
    await fetchQuotes();
  }

  Future<void> updateQuote(Quote quote) async {
    await _quoteRepository.updateQuote(quote);
    await fetchQuotes();
  }

  Future<void> deleteQuote(int id) async {
    await _quoteRepository.deleteQuote(id);
    await fetchQuotes();
  }
}
