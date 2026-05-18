import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class QuoteService {
  final String baseUrl = 'https://dummyjson.com';

  static List<Quote>? _cachedQuotes;

  Future<List<Quote>> getQuotes() async {
    if (_cachedQuotes != null) return _cachedQuotes!;
    try {
      final response = await http.get(Uri.parse('$baseUrl/quotes'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List quotesList = data['quotes'];
        _cachedQuotes = quotesList.map((e) => Quote.fromJson(e)).toList();
        return _cachedQuotes!;
      } else {
        throw Exception('Failed to load quotes');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addQuote(Quote quote) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/quotes/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(quote.toJson()),
      );
    } catch (e) {
      // get for the error message
    }
    // adding the new quote to the cache
    final newQuote = Quote(
      id: DateTime.now().millisecondsSinceEpoch,
      quote: quote.quote,
      author: quote.author,
    );
    _cachedQuotes?.insert(0, newQuote);
  }

  Future<void> updateQuote(Quote quote) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/quotes/${quote.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(quote.toJson()),
      );
    } catch (e) {
      // Ignore 404
    }
    final index = _cachedQuotes?.indexWhere((q) => q.id == quote.id) ?? -1;
    if (index != -1) {
      _cachedQuotes![index] = quote;
    }
  }

  Future<void> deleteQuote(int id) async {
    try {
      await http.delete(Uri.parse('$baseUrl/quotes/$id'));
    } catch (e) {
      // Ignore 404
    }
    _cachedQuotes?.removeWhere((q) => q.id == id);
  }
}
