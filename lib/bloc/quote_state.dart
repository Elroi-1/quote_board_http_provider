import 'package:equatable/equatable.dart';
import '../models/quote_model.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final List<Quote> quotes;
  const QuoteLoaded(this.quotes);

  @override
  List<Object?> get props => [quotes];
}

class QuoteError extends QuoteState {
  final String message;
  const QuoteError(this.message);

  @override
  List<Object?> get props => [message];
}
