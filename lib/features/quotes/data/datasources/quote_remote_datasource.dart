import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/http_provider.dart';
import '../models/quote.dart';

class QuoteRemoteDatasource {
  final http.Client _client;

  QuoteRemoteDatasource({http.Client? client})
      : _client = client ?? HttpProvider.client;

  Future<List<Quote>> fetchQuotes() async {
    final response = await _client.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.quotesPath}'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List quotesList = data['quotes'];
      return quotesList.map((e) => Quote.fromJson(e)).toList();
    }
    throw Exception('Failed to load quotes');
  }

  Future<void> addQuote(Quote quote) async {
    try {
      await _client.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.quotesPath}/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(quote.toJson()),
      );
    } catch (_) {}
  }

  Future<void> updateQuote(Quote quote) async {
    try {
      await _client.put(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.quotesPath}/${quote.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(quote.toJson()),
      );
    } catch (_) {}
  }

  Future<void> deleteQuote(int id) async {
    try {
      await _client.delete(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.quotesPath}/$id'),
      );
    } catch (_) {}
  }
}
