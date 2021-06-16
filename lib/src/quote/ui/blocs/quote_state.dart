part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();
}

class QuoteInitial extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteAdding extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteAdded extends QuoteState {
  final Quote quote;

  const QuoteAdded(this.quote);

  @override
  List<Object> get props {
    return [quote];
  }
}

class QuoteAddFailed extends QuoteState {
  final String e;

  const QuoteAddFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteAddFailed{e: $e}';
  }
}

class QuoteDeleting extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteDeleted extends QuoteState {
  final Quote quote;

  const QuoteDeleted(this.quote);

  @override
  List<Object> get props {
    return [quote];
  }
}

class QuoteDeleteFailed extends QuoteState {
  final String e;

  const QuoteDeleteFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteDeleteFailed{e: $e}';
  }
}

class QuoteLoading extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteLoaded extends QuoteState {
  final List<Quote> quotes;

  const QuoteLoaded(this.quotes);

  @override
  List<Object> get props {
    return [quotes];
  }
}

class QuoteLoadFailed extends QuoteState {
  final String e;

  const QuoteLoadFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteLoadFailed{e: $e}';
  }
}

class QuoteUpdating extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteUpdateed extends QuoteState {
  final Quote quote;

  const QuoteUpdateed(this.quote);

  @override
  List<Object> get props {
    return [quote];
  }
}

class QuoteUpdateFailed extends QuoteState {
  final String e;

  const QuoteUpdateFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteUpdateFailed{e: $e}';
  }
}

class QuoteJobLoading extends QuoteState {
  @override
  List<Object> get props => [];
}

class QuoteJobLoaded extends QuoteState {
  final List<Quote> quotes;

  const QuoteJobLoaded(this.quotes);

  @override
  List<Object> get props {
    return [quotes];
  }
}

class QuoteJobLoadFailed extends QuoteState {
  final String e;

  const QuoteJobLoadFailed(this.e);

  @override
  List<Object> get props {
    return [e];
  }

  @override
  String toString() {
    return 'QuoteJobLoadFailed{e: $e}';
  }
}

