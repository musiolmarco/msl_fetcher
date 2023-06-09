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
  static Widget _defaultLoadingWidget = const Center(
    child: CircularProgressIndicator(),
  );

  /// The default error [Widget] that is used if no [fetchingErrorWidget] is passed
  static Widget Function(Object error, VoidCallback onRefresh)
      // ignore: prefer_function_declarations_over_variables
      _defaultErrorWidget = (Object error, VoidCallback onRefresh) => Center(
            child: MslFetcherDefaultErrorWidget(
              onRefresh: () => onRefresh(),
            ),
          );

  /// The method that fetches and returns the data
  final Future<T> Function() fetchData;

  /// This [Widget] is displayed while the data is being fetched
  final Widget? loadingWidget;

  /// This [Widget] is displayed if the data is available
  ///
  /// [availableData] is the data that got fetched from the backend
  ///
  /// [onRefresh] is the method that will refresh the fetching.
  /// This can be used if you add some data and watch to refetch the data.
  final Widget Function(
    T availableData,
    VoidCallback onRefresh,
  ) dataAvailableWidget;

  /// Tis [Widget] is displayed if there was an error while fetching the data
  ///
  /// [error] is the [Object] that got catched by the [MslFetcherProvider]
  ///
  /// [onRefresh] is the function that will redo the fetch again
  final Widget Function(
    Object error,
    VoidCallback onRefresh,
  )? fetchingErrorWidget;

  /// Pass [showErrorLog] as true if you want to log errors into the console
  final bool? showErrorLogs;

  const MslFetcher({
    super.key,
    required this.fetchData,
    required this.dataAvailableWidget,
    this.fetchingErrorWidget,
    this.loadingWidget,
    this.showErrorLogs,
  });

  /// This method lets the user setup his own default [Widget]s that will be displayed
  static void setup({
    Widget Function(Object error, VoidCallback onRefresh)? defaultErrorWidget,
    Widget? defaultLoadingWidget,
  }) {
    if (defaultErrorWidget != null) _defaultErrorWidget = defaultErrorWidget;
    if (defaultLoadingWidget != null) {
      _defaultLoadingWidget = defaultLoadingWidget;
    }
  }

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
            return dataAvailableWidget(
              state.data,
              () =>
                  context.read<MslFetcherProvider<T>>().fetchDataAndEmitState(),
            );
          } else {
            Object error = (state is MslFetcherProviderError)
                ? state.error
                : MslFetcherNoStateAvailable();

            return fetchingErrorWidget != null
                ? fetchingErrorWidget!(
                    error,
                    () => context
                        .read<MslFetcherProvider<T>>()
                        .fetchDataAndEmitState(),
                  )
                : _defaultErrorWidget(
                    error,
                    () => context
                        .read<MslFetcherProvider<T>>()
                        .fetchDataAndEmitState(),
                  );
          }
        },
      ),
    );
  }
}
