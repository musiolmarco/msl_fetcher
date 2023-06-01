import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'msl_fetcher_provider_state.dart';

class MslFetcherProvider<T> extends Cubit<MslFetcherProviderState> {
  /// The method that fetches and returns the data
  final Future<T> Function() onDataFetched;

  MslFetcherProvider({
    required this.onDataFetched,
  }) : super(MslFetcherProviderLoading()) {
    fetchDataAndEmitState();
  }

  /// Fetch the data from the given method and emit the specific state
  ///
  /// Emit [MslFetcherProviderLoading] while the data is being fetched
  /// Emit [MslFetcherProviderDataAvailable] if the data is available
  /// Emit [MslFetcherProviderError] if there is an error within the process
  Future<void> fetchDataAndEmitState() async {
    emit(MslFetcherProviderLoading());

    try {
      T data = await onDataFetched();
      emit(
        MslFetcherProviderDataAvailable(
          data: data,
        ),
      );
    } catch (e) {
      emit(
        MslFetcherProviderError(),
      );
    }
  }
}
