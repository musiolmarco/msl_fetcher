library msl_fetcher;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msl_fetcher/data/exceptions/msl_fetcher_no_state_available.dart';
import 'package:msl_fetcher/msl_fetcher_provider.dart';
import 'package:msl_fetcher/presentation/widgets/msl_fetcher_default_error_widget.dart';

/// The [MslFetcher] is a [Widget] that setup the whole fetching progress
///
/// Use this [Widget] to fetch data and handle all states in under a minute
class MslFetcher<T> extends StatelessWidget {
  /// The default loading [Widget] that is used if no [loadingWidget]
  /// is passed.
  static const Widget _defaultLoadingWidget = CircularProgressIndicator();

  /// The default error [Widget] that is used if no [fetchingErrorWidget] is passed
  static const Widget _defaultErrorWidget = MslFetcherDefaultErrorWidget();

  /// The method that fetches and returns the data
  final Future<T> Function() fetchData;

  /// This [Widget] is displayed while the data is being fetched
  final Widget? loadingWidget;

  /// This [Widget] is displayed if the data is available
  ///
  /// [availableData] is the data that got fetched from the backend
  final Widget Function(T availableData) dataAvailableWidget;

  /// Tis [Widget] is displayed if there was an error while fetching the data
  ///
  /// [error] is the [Object] that got catched by the [MslFetcherProvider]
  final Widget Function(Object error)? fetchingErrorWidget;

  /// Pass [showErrorLog] as true if you want to log errors into the console
  final bool? showErrorLogs;

  const MslFetcher({
    super.key,
    required this.fetchData,
    required this.dataAvailableWidget,
    required this.fetchingErrorWidget,
    required this.loadingWidget,
    this.showErrorLogs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MslFetcherProvider<T>(
        onDataFetched: fetchData,
        showErrorLogs: showErrorLogs,
      ),
      child: BlocBuilder<MslFetcherProvider<T>, MslFetcherProviderState>(
        builder: (context, state) {
          if (state is MslFetcherProviderLoading) {
            return loadingWidget != null
                ? loadingWidget!
                : _defaultLoadingWidget;
          } else if (state is MslFetcherProviderDataAvailable<T>) {
            return dataAvailableWidget(state.data);
          } else {
            return fetchingErrorWidget != null
                ? fetchingErrorWidget!(
                    (state is MslFetcherProviderError)
                        ? state.error
                        : MslFetcherNoStateAvailable(),
                  )
                : _defaultErrorWidget;
          }
        },
      ),
    );
  }
}
