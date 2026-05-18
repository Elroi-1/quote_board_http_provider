import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../service/quote_service.dart';

class QuoteProvider extends ChangeNotifier {
  final QuoteService _quoteService = QuoteService();

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
      _quotes = await _quoteService.getQuotes();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addQuote(Quote quote) async {
    await _quoteService.addQuote(quote);
    await fetchQuotes();
  }

  Future<void> updateQuote(Quote quote) async {
    await _quoteService.updateQuote(quote);
    await fetchQuotes();
  }

  Future<void> deleteQuote(int id) async {
    await _quoteService.deleteQuote(id);
    await fetchQuotes();
  }
}
