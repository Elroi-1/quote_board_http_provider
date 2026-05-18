import 'package:equatable/equatable.dart';
import '../models/quote_model.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  List<Object?> get props => [];
}

class GetQuotesEvent extends QuoteEvent {}

class AddQuoteEvent extends QuoteEvent {
  final Quote quote;
  const AddQuoteEvent(this.quote);
  @override
  List<Object?> get props => [quote];
}

class UpdateQuoteEvent extends QuoteEvent {
  final Quote quote;
  const UpdateQuoteEvent(this.quote);
  @override
  List<Object?> get props => [quote];
}

class DeleteQuoteEvent extends QuoteEvent {
  final int id;
  const DeleteQuoteEvent(this.id);
  @override
  List<Object?> get props => [id];
}
