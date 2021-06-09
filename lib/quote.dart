library local_people_core;

export './src/quote/domain/entities/quote.dart';
export './src/quote/domain/entities/quote_list_response.dart';
export './src/quote/domain/entities/quote_request.dart';
export './src/quote/domain/entities/quote_request_list_response.dart';
export './src/quote/domain/entities/quote_request_response.dart';
export './src/quote/domain/entities/quote_response.dart';

export './src/quote/domain/repositories/quote_repository.dart';
export './src/quote/domain/repositories/quote_request_repository.dart';

export './src/quote/data/datasources/quote_remote_data_source.dart';
export './src/quote/data/datasources/quote_request_remote_data_source.dart';
export './src/quote/data/datasources/quote_remote_data_source_impl.dart';
export './src/quote/data/datasources/quote_request_remote_data_source_impl.dart';

export './src/quote/data/models/quote_model.dart';
export './src/quote/data/models/quote_request_model.dart';
export './src/quote/data/repositories/quote_repository_impl.dart';
export './src/quote/data/repositories/quote_request_repository_impl.dart';

export './src/quote/ui/blocs/quote_bloc.dart';
export './src/quote/ui/blocs/quote_request_bloc.dart';

export './src/quote/ui/widgets/suggested_time_slot_widget.dart';
export './src/quote/ui/widgets/place_bid_total_widget.dart';
export './src/quote/ui/widgets/place_bid_detail_widget.dart';
export './src/quote/ui/widgets/place_bid_widget.dart';
export './src/quote/ui/widgets/request_visit_widget.dart';
export './src/quote/ui/widgets/quote_request_detail_widget.dart';
export './src/quote/ui/widgets/request_quote_widget.dart';