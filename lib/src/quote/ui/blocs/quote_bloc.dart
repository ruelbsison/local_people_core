import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/quote_response.dart';
import '../../domain/entities/quote_list_response.dart';
import '../../domain/repositories/quote_repository.dart';
import 'package:local_people_core/auth.dart';
//import 'package:local_people_core/jobs.dart';
//import 'package:local_people_core/profile.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/transformers.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;
 // final ProfileRepository profileRepository;
 // final JobRepository jobRepository;
  final AuthLocalDataSource authLocalDataSource;

  QuoteBloc({
    @required this.quoteRepository,
 //   @required this.profileRepository,
 //   @required this.jobRepository,
    @required this.authLocalDataSource,
  }) : super(QuoteInitial());

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
    } else if (event is QuoteJobLoadEvent) {
      yield QuoteJobLoading();
      yield* _mapQuoteLoadFromJobToState(event.id);
    }
  }

  Stream<QuoteState> _mapQuoteAddToState(Quote quote) async* {
    try {
      int traderId = await authLocalDataSource.getUserId();
      if (traderId == null) {
        yield  QuoteAddFailed('Trader user id not found!');
        return;
      }

      quote.traderId = traderId;
      QuoteResponse response = await quoteRepository.createQuote(quote);
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

  Stream<QuoteState> _mapQuoteUpdateToState(Quote quote) async* {
    try {
      QuoteResponse response = await quoteRepository.updateQuote(quote);
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

  @override
  void onTransition(Transition<QuoteEvent, QuoteState> transition) {
    print('onTransition: $transition');
    super.onTransition(transition);
  }

  // @override
  // Stream<Transition<QuoteEvent, QuoteState>> transformEvents(
  //     Stream<QuoteEvent> events, TransitionFunction<QuoteEvent, QuoteState> transitionFn) {
  //   final otherStream = events
  //       .where((event) => event is! QuoteJobLoadEvent);
  //   final withIntervalStream = events
  //       .where((event) => event is QuoteJobLoadEvent)
  //       .interval(const Duration(seconds: 1));
  //   return super.transformEvents(
  //       MergeStream<QuoteEvent> ([otherStream, withIntervalStream]),
  //       transitionFn);
  // }

  // @override
  // Stream<Transition<QuoteEvent, QuoteState>> transformTransitions(
  //     Stream<Transition<QuoteEvent, QuoteState>> transitions) {
  //   final otherStream = transitions
  //       .where((event) => event is! QuoteJobLoadEvent);
  //   final withIntervalStream = transitions
  //       .where((event) => event is QuoteJobLoadEvent)
  //       .interval(const Duration(seconds: 1));
  //   return super.transformTransitions(
  //       MergeStream<Transition<QuoteEvent, QuoteState>>
  //         ([otherStream, withIntervalStream]));
  // }

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
        yield QuoteLoaded(response.quotes.toList());
      }
    } catch (e) {
      yield QuoteLoadFailed(e.toString());
    }
  }

  Stream<QuoteState> _mapQuoteLoadFromJobToState(int jobId) async* {
    try {
      QuoteListResponse response = await quoteRepository.listJobQuotes(jobId);
      if (response != null && response.exception != null) {
        yield QuoteJobLoadFailed(response.exception.toString());
      } else if (response != null && response.quotes == null) {
        yield  QuoteJobLoadFailed('');
      } else if (response != null && response.quotes != null) {
        //await Future<void>.delayed(const Duration(seconds: 1));
        yield QuoteJobLoaded(response.quotes.toList());
      }
    } catch (e) {
      yield QuoteJobLoadFailed(e.toString());
    }
  }
}
