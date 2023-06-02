/// This [Exception] is thrown if somehow no [MslFetcherProviderState] is available
///
/// That should actually never be the case, but in case of it will be handled
/// by this class.
class MslFetcherNoStateAvailable implements Exception {}
