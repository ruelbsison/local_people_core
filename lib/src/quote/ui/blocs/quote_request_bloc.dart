import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/quote_request.dart';
import '../../domain/entities/quote_request_response.dart';
import '../../domain/entities/quote_request_list_response.dart';
import '../../domain/repositories/quote_request_repository.dart';

part 'quote_request_event.dart';
part 'quote_request_state.dart';

class QuoteRequestBloc extends Bloc<QuoteRequestEvent, QuoteRequestState> {
  final QuoteRequestRepository quoteRequestRepository;

  QuoteRequestBloc({
    @required this.quoteRequestRepository
  }) : super(QuoteRequestInitial());

  @override
  Stream<QuoteRequestState> mapEventToState(
    QuoteRequestEvent event,
  ) async* {
    if (event is QuoteRequestAddEvent) {
      yield QuoteRequestAdding();
      yield* _mapQuoteRequestAddToState(event.quoteRequest);
    } else if (event is QuoteRequestDeleteEvent) {
      yield QuoteRequestDeleting();
      yield* _mapQuoteRequestDeleteToState(event.id);
    } else if (event is QuoteRequestGetEvent) {
      yield QuoteRequestLoading();
      yield* _mapQuoteRequestLoadToState(event.id);
    } else if (event is QuoteRequestUpdateEvent) {
      yield QuoteRequestUpdating();
      yield* _mapQuoteRequestUpdateToState(event.quoteRequest);
    }
  }

  Stream<QuoteRequestState> _mapQuoteRequestAddToState(QuoteRequest quoteRequest) async* {
    try {
      QuoteRequestResponse response = await quoteRequestRepository.createQuoteRequest(quoteRequest);
      if (response != null && response.exception != null) {
        yield QuoteRequestAddFailed(response.exception.toString());
      } else if (response != null && response.quoteRequest == null) {
        yield  QuoteRequestAddFailed('');
      } else if (response != null && response.quoteRequest != null) {
        yield QuoteRequestAdded(response.quoteRequest);
      }
    } catch (e) {
      yield QuoteRequestAddFailed(e.toString());
    }
  }

  Stream<QuoteRequestState> _mapQuoteRequestUpdateToState(QuoteRequest quoteRequest) async* {
    try {
      QuoteRequestResponse response = await quoteRequestRepository.updateQuoteRequest(quoteRequest);
      if (response != null && response.exception != null) {
        yield QuoteRequestUpdateFailed(response.exception.toString());
      } else if (response != null && response.quoteRequest == null) {
        yield  QuoteRequestUpdateFailed('');
      } else if (response != null && response.quoteRequest != null) {
        yield QuoteRequestUpdateed(response.quoteRequest);
      }
    } catch (e) {
      yield QuoteRequestUpdateFailed(e.toString());
    }
  }

  Stream<QuoteRequestState> _mapQuoteRequestDeleteToState(int id) async* {
    QuoteRequestResponse response = QuoteRequestResponse();
    try {
      response.exception = await quoteRequestRepository.deleteQuoteRequest(id);
      if (response != null && response.exception != null) {
        yield QuoteRequestUpdateFailed(response.exception.toString());
      } else if (response != null && response.quoteRequest == null) {
        yield  QuoteRequestUpdateFailed('');
      } else if (response != null && response.quoteRequest != null) {
        yield QuoteRequestUpdateed(response.quoteRequest);
      }
    } catch (e) {
      yield QuoteRequestUpdateFailed(e.toString());
    }
  }

  Stream<QuoteRequestState> _mapQuoteRequestLoadToState(int traderId) async* {
    try {
      QuoteRequestListResponse response = await quoteRequestRepository.listTraderQuoteRequests(traderId);
      if (response != null && response.exception != null) {
        yield QuoteRequestLoadFailed(response.exception.toString());
      } else if (response != null && response.quoteRequests == null) {
        yield  QuoteRequestLoadFailed('');
      } else if (response != null && response.quoteRequests != null) {
        yield QuoteRequestLoaded(response.quoteRequests);
      }
    } catch (e) {
      yield QuoteRequestLoadFailed(e.toString());
    }
  }
}
