part of 'quote_request_bloc.dart';

abstract class QuoteRequestEvent extends Equatable {
  const QuoteRequestEvent();
}

class QuoteRequestAddEvent extends QuoteRequestEvent {
  const QuoteRequestAddEvent({@required this.quoteRequest});

  final QuoteRequest quoteRequest;

  @override
  List<Object> get props => [quoteRequest];
}

class QuoteRequestDeleteEvent extends QuoteRequestEvent {
  const QuoteRequestDeleteEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class QuoteRequestGetEvent extends QuoteRequestEvent {
  const QuoteRequestGetEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class QuoteRequestUpdateEvent extends QuoteRequestEvent {
  const QuoteRequestUpdateEvent({@required this.quoteRequest});

  final QuoteRequest quoteRequest;

  @override
  List<Object> get props => [quoteRequest];
}
