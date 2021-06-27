import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quote.dart';
import '../blocs/quote_bloc.dart';
import '../../domain/repositories/quote_repository.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/profile.dart';
import '../../domain/entities/quote.dart';
import 'quote_card.dart';

class QuoteBodyWidget extends StatefulWidget {
  final Job job;
  QuoteBodyWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  @override
  _QuoteBodyWidgetState createState() => _QuoteBodyWidgetState();
}

class _QuoteBodyWidgetState extends State<QuoteBodyWidget> {
  @override
  Widget build(BuildContext context) {
    //  if (widget.job.bids == null || widget.job.bids.length == 0) {
    //    BlocProvider.of<QuoteBloc>(context)
    //        .add(QuoteJobLoadEvent(id: widget.job.id));
    //  }
    //
    // return BlocProvider.value(
    //   value: BlocProvider.of<QuoteBloc>(context),
    //   child: BlocBuilder<QuoteBloc, QuoteState>(
    //     builder: (context, state) {
    //      if (state is QuoteJobLoadFailed) {
    //         return ErrorWidget('Unhandle State $state');
    //       } else if (state is QuoteJobLoaded) {
    //        if (widget.job.bids == null)
    //          widget.job.bids = [];
    //        else
    //          widget.job.bids.clear();
    //        if (state.quotes != null && state.quotes.length > 0)
    //          print('state.quotes.length: ' + state.quotes.length.toString());
    //        widget.job.bids = state.quotes;
    //        return buildBody(context);
    //       }
    //       return LoadingWidget();
    //     },
    //   ),
    // );
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          //if (appCType == AppType.CLIENT)
          //  BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.job.id));
          //else
            if (widget.job.bids != null)
              widget.job.bids.clear();
            BlocProvider.of<QuoteBloc>(context).add(QuoteJobLoadEvent(id: widget.job.id));
        },
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
          itemCount: widget.job != null && widget.job.bids != null ? widget.job.bids.length : 0,
          itemBuilder: (context, index) {
            Quote quote = widget.job.bids[index];
            return BlocProvider(
              create: (context) => ProfileBloc(
                profileRepository: RepositoryProvider.of<ProfileRepository>(context),
                appType: appType,
                authLocalDataSource: sl<AuthLocalDataSource>(),
              )..add(TraderProfileGetEvent(id: quote.traderId)),
              child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                if (state is TraderProfileGetLoaded) {
                  //locatorAddClientProfile(state.profile);
                  return QuoteCard(
                    job: widget.job,
                    quote: quote,
                    traderProfile: state.profile,
                  );
                } else if (state is TraderProfileGetFailed) {
                  return ErrorWidget('Error $state');
                } else {
                  return LoadingWidget();
                }
              }),
            );
          }
        ),
      ),
    );
  }
}