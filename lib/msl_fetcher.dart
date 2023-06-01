library msl_fetcher;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msl_fetcher/msl_fetcher_provider.dart';

/// The [MslFetcher] is a [Widget] that setup the whole fetching progress
///
/// Use this [Widget] to fetch data and handle all states in under a minute
class MslFetcher<T> extends StatelessWidget {
  /// The method that fetches and returns the data
  final Future<T> Function() onDataFetched;

  /// This [Widget] is displayed while the data is being fetched
  final Widget loadingWidget;

  /// This [Widget] is displayed if the data is available
  final Widget dataAvailableWidget;

  /// Tis [Widget] is displayed if there was an error while fetching the data
  final Widget fetchingErrorWidget;

  const MslFetcher({
    super.key,
    required this.onDataFetched,
    required this.dataAvailableWidget,
    required this.fetchingErrorWidget,
    required this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MslFetcherProvider(onDataFetched: onDataFetched),
      child: BlocBuilder<MslFetcherProvider, MslFetcherProviderState>(
        builder: (context, state) {
          if (state is MslFetcherProviderLoading) {
            return loadingWidget;
          } else if (state is MslFetcherProviderDataAvailable) {
            return dataAvailableWidget;
          } else {
            return fetchingErrorWidget;
          }
        },
      ),
    );
  }
}
