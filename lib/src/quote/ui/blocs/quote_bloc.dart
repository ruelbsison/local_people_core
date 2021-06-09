import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/quote_response.dart';
import '../../domain/entities/quote_list_response.dart';
import '../../domain/repositories/quote_repository.dart';
part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteBloc(@required this.quoteRepository) : super(QuoteInitial());

  @override
  Stream<QuoteState> mapEventToState(
    QuoteEvent event,
  ) async* {
    if (event is QuoteAddEvent) {
      yield QuoteAdding();
      yield* _mapQuoteAddToState(event.quote);
    } else if (event is QuoteDeleteEvent) {
      yield QuoteDeleting();
      yield* _mapQuoteDeleteToState(event.id);
    } else if (event is QuoteGetEvent) {
      yield QuoteLoading();
      yield* _mapQuoteLoadToState(event.id);
    } else if (event is QuoteUpdateEvent) {
      yield QuoteUpdating();
      yield* _mapQuoteUpdateToState(event.quote);
    }
  }

  Stream<QuoteState> _mapQuoteAddToState(Quote Quote) async* {
    try {
      QuoteResponse response = await quoteRepository.createQuote(Quote);
      if (response != null && response.exception != null) {
        yield QuoteAddFailed(response.exception.toString());
      } else if (response != null && response.quote == null) {
        yield  QuoteAddFailed('');
      } else if (response != null && response.quote != null) {
        yield QuoteAdded(response.quote);
      }
    } catch (e) {
      yield QuoteAddFailed(e.toString());
    }
  }

  Stream<QuoteState> _mapQuoteUpdateToState(Quote Quote) async* {
    try {
      QuoteResponse response = await quoteRepository.updateQuote(Quote);
      if (response != null && response.exception != null) {
        yield QuoteUpdateFailed(response.exception.toString());
      } else if (response != null && response.quote == null) {
        yield  QuoteUpdateFailed('');
      } else if (response != null && response.quote != null) {
        yield QuoteUpdateed(response.quote);
      }
    } catch (e) {
      yield QuoteUpdateFailed(e.toString());
    }
  }

  Stream<QuoteState> _mapQuoteDeleteToState(int id) async* {
    QuoteResponse response = QuoteResponse();
    try {
      response.exception = await quoteRepository.deleteQuote(id);
      if (response != null && response.exception != null) {
        yield QuoteUpdateFailed(response.exception.toString());
      } else if (response != null && response.quote == null) {
        yield  QuoteUpdateFailed('');
      } else if (response != null && response.quote != null) {
        yield QuoteUpdateed(response.quote);
      }
    } catch (e) {
      yield QuoteUpdateFailed(e.toString());
    }
  }

  Stream<QuoteState> _mapQuoteLoadToState(int traderId) async* {
    try {
      QuoteListResponse response = await quoteRepository.listTraderQuotes(traderId);
      if (response != null && response.exception != null) {
        yield QuoteLoadFailed(response.exception.toString());
      } else if (response != null && response.quotes == null) {
        yield  QuoteLoadFailed('');
      } else if (response != null && response.quotes != null) {
        yield QuoteLoaded(response.quotes);
      }
    } catch (e) {
      yield QuoteLoadFailed(e.toString());
    }
  }
}
