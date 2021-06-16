import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quote.dart';
import '../blocs/quote_bloc.dart';
import '../../domain/repositories/quote_repository.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/profile.dart';
import 'quote_card.dart';

class QuoteBodyWidget extends StatefulWidget {
  final int jobId;
  QuoteBodyWidget({
    Key key,
    @required this.jobId
  }) : super(key: key);

  @override
  _QuoteBodyWidgetState createState() => _QuoteBodyWidgetState();
}

class _QuoteBodyWidgetState extends State<QuoteBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<QuoteBloc>(context)..add(QuoteJobLoadEvent(id: widget.jobId)),
      child: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
         if (state is QuoteJobLoadFailed) {
            return ErrorWidget('Unhandle State $state');
          } else if (state is QuoteJobLoaded) {
           return buildBody(state.quotes);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Widget buildBody(List<Quote> quotes) {
    final appCType = AppConfig.of(context).appType;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          if (appCType == AppType.CLIENT)
            BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.jobId));
          else
            BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.jobId));
        },
        child: ListView.builder(
          itemCount: quotes.length,
          itemBuilder: (context, index) => (appCType == AppType.TRADER
              ? QuoteCard(quote: quotes[index])
              : QuoteCard(quote: quotes[index])),
        ),
      ),
    );
  }
}