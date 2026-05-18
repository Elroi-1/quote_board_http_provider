import '../datasources/quote_remote_datasource.dart';
import '../models/quote.dart';

class QuoteRepository {
  final QuoteRemoteDatasource _remoteDatasource;

  static List<Quote>? _cachedQuotes;

  QuoteRepository({QuoteRemoteDatasource? remoteDatasource})
      : _remoteDatasource = remoteDatasource ?? QuoteRemoteDatasource();

  Future<List<Quote>> getQuotes() async {
    if (_cachedQuotes != null) return _cachedQuotes!;
    try {
      _cachedQuotes = await _remoteDatasource.fetchQuotes();
      return _cachedQuotes!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addQuote(Quote quote) async {
    await _remoteDatasource.addQuote(quote);
    final newQuote = Quote(
      id: DateTime.now().millisecondsSinceEpoch,
      quote: quote.quote,
      author: quote.author,
    );
    _cachedQuotes?.insert(0, newQuote);
  }

  Future<void> updateQuote(Quote quote) async {
    await _remoteDatasource.updateQuote(quote);
    final index = _cachedQuotes?.indexWhere((q) => q.id == quote.id) ?? -1;
    if (index != -1) {
      _cachedQuotes![index] = quote;
    }
  }

  Future<void> deleteQuote(int id) async {
    await _remoteDatasource.deleteQuote(id);
    _cachedQuotes?.removeWhere((q) => q.id == id);
  }
}
