import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/quote_service.dart';
import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteService quoteService;

  QuoteBloc(this.quoteService) : super(QuoteInitial()) {
    on<GetQuotesEvent>(_onGetQuotes);
    on<AddQuoteEvent>(_onAddQuote);
    on<UpdateQuoteEvent>(_onUpdateQuote);
    on<DeleteQuoteEvent>(_onDeleteQuote);
  }

  Future<void> _onGetQuotes(
    GetQuotesEvent event,
    Emitter<QuoteState> emit,
  ) async {
    emit(QuoteLoading());
    try {
      final quotes = await quoteService.getQuotes();
      emit(QuoteLoaded(quotes));
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  Future<void> _onAddQuote(
    AddQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    try {
      await quoteService.addQuote(event.quote);
      add(GetQuotesEvent()); // Refresh quotes
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  Future<void> _onUpdateQuote(
    UpdateQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    try {
      await quoteService.updateQuote(event.quote);
      add(GetQuotesEvent()); // Refresh quotes
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }

  Future<void> _onDeleteQuote(
    DeleteQuoteEvent event,
    Emitter<QuoteState> emit,
  ) async {
    try {
      await quoteService.deleteQuote(event.id);
      add(GetQuotesEvent()); // Refresh quotes
    } catch (e) {
      emit(QuoteError(e.toString()));
    }
  }
}
