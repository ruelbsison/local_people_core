import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';
import '../../domain/entities/quote_response.dart';
import '../../domain/entities/quote_list_response.dart';
import '../../domain/repositories/quote_repository.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/profile.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;
  final ProfileRepository profileRepository;
  final JobRepository jobRepository;
  final AuthLocalDataSource authLocalDataSource;

  QuoteBloc({
    @required this.quoteRepository,
    @required this.profileRepository,
    @required this.jobRepository,
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

  Stream<QuoteState> _mapQuoteLoadFromJobToState(int jobId) async* {
    try {
      QuoteListResponse response = await quoteRepository.listJobQuotes(jobId);
      if (response != null && response.exception != null) {
        yield QuoteJobLoadFailed(response.exception.toString());
      } else if (response != null && response.quotes == null) {
        yield  QuoteJobLoadFailed('');
      } else if (response != null && response.quotes != null) {
        var listIterator = response.quotes.iterator;
        while (listIterator.moveNext()) {
          Quote quote = listIterator.current;

          JobResponse jobResponse = await jobRepository.showJob(quote.jobId);
          if (jobResponse != null && jobResponse.exception != null) {
          } else if (jobResponse != null && jobResponse.job == null) {
            yield  QuoteJobLoadFailed('');
          } else if (jobResponse != null && jobResponse.job != null) {
            quote.job = jobResponse.job;
          }

          TraderResponse traderResponse = await profileRepository.getTraderProfile(quote.traderId);
          if (traderResponse != null && traderResponse.exception != null) {
          } else if (traderResponse != null && traderResponse.profile == null) {
            yield  QuoteJobLoadFailed('');
          } else if (traderResponse != null && traderResponse.profile != null) {
            quote.traderProfile = traderResponse.profile;
          }
        }
        yield QuoteJobLoaded(response.quotes);
      }
    } catch (e) {
      yield QuoteJobLoadFailed(e.toString());
    }
  }
}
