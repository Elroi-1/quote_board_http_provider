import 'package:dio/dio.dart';
import '../models/quote_model.dart';

class QuoteService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  static List<Quote>? _cachedQuotes;

  Future<List<Quote>> getQuotes() async {
    if (_cachedQuotes != null) return _cachedQuotes!;
    try {
      final response = await dio.get('/quotes');
      final List data = response.data['quotes'];
      _cachedQuotes = data.map((e) => Quote.fromJson(e)).toList();
      return _cachedQuotes!;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> addQuote(Quote quote) async {
    try {
      await dio.post('/quotes/add', data: quote.toJson());
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
      await dio.put('/quotes/${quote.id}', data: quote.toJson());
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
      await dio.delete('/quotes/$id');
    } catch (e) {
      // Ignore 404
    }
    _cachedQuotes?.removeWhere((q) => q.id == id);
  }
}
