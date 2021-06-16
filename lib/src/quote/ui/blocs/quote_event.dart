part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();
}

class QuoteAddEvent extends QuoteEvent {
  const QuoteAddEvent({@required this.quote});

  final Quote quote;

  @override
  List<Object> get props => [Quote];
}

class QuoteDeleteEvent extends QuoteEvent {
  const QuoteDeleteEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class QuoteGetEvent extends QuoteEvent {
  const QuoteGetEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class QuoteUpdateEvent extends QuoteEvent {
  const QuoteUpdateEvent({@required this.quote});

  final Quote quote;

  @override
  List<Object> get props => [Quote];
}

class QuoteJobLoadEvent extends QuoteEvent {
  const QuoteJobLoadEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
