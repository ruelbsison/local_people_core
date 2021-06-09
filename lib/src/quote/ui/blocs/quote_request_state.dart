part of 'quote_request_bloc.dart';

abstract class QuoteRequestState extends Equatable {
  const QuoteRequestState();
}

class QuoteRequestInitial extends QuoteRequestState {
  @override
  List<Object> get props => [];
}

class QuoteRequestAdding extends QuoteRequestState {
  @override
  List<Object> get props => [];
}

class QuoteRequestAdded extends QuoteRequestState {
  final QuoteRequest quoteRequest;

  const QuoteRequestAdded(this.quoteRequest);

  @override
  List<Object> get props {
    return [quoteRequest];
  }
}

class QuoteRequestAddFailed extends QuoteRequestState {
  final String e;

  const QuoteRequestAddFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteRequestAddFailed{e: $e}';
  }
}

class QuoteRequestDeleting extends QuoteRequestState {
  @override
  List<Object> get props => [];
}

class QuoteRequestDeleted extends QuoteRequestState {
  final QuoteRequest quoteRequest;

  const QuoteRequestDeleted(this.quoteRequest);

  @override
  List<Object> get props {
    return [quoteRequest];
  }
}

class QuoteRequestDeleteFailed extends QuoteRequestState {
  final String e;

  const QuoteRequestDeleteFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteRequestDeleteFailed{e: $e}';
  }
}

class QuoteRequestLoading extends QuoteRequestState {
  @override
  List<Object> get props => [];
}

class QuoteRequestLoaded extends QuoteRequestState {
  final List<QuoteRequest> quoteRequest;

  const QuoteRequestLoaded(this.quoteRequest);

  @override
  List<Object> get props {
    return [quoteRequest];
  }
}

class QuoteRequestLoadFailed extends QuoteRequestState {
  final String e;

  const QuoteRequestLoadFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteRequestLoadFailed{e: $e}';
  }
}

class QuoteRequestUpdating extends QuoteRequestState {
  @override
  List<Object> get props => [];
}

class QuoteRequestUpdateed extends QuoteRequestState {
  final QuoteRequest quoteRequest;

  const QuoteRequestUpdateed(this.quoteRequest);

  @override
  List<Object> get props {
    return [quoteRequest];
  }
}

class QuoteRequestUpdateFailed extends QuoteRequestState {
  final String e;

  const QuoteRequestUpdateFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteRequestUpdateFailed{e: $e}';
  }
}
