part of 'msl_fetcher_provider.dart';

@immutable
abstract class MslFetcherProviderState {}

/// This class is emitted while the data is being fetched
class MslFetcherProviderLoading extends MslFetcherProviderState {}

/// This class is emitted if there is an error with the request method
class MslFetcherProviderError extends MslFetcherProviderState {}

/// This class is emitted if everything worked and the data is available
class MslFetcherProviderDataAvailable<T> extends MslFetcherProviderState {

  /// The data that is available and received from the successful request
  final T data;

  MslFetcherProviderDataAvailable({required this.data});
}
