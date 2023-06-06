# msl_fetcher 🌐
With msl_fetcher you can fetch and handle data easily. Handle all states (Loading, Error, Data available) within a minute.🕚

## Getting started 🚀
Add this lines to your pubspec.yaml dependencies.
```yaml
dependencies:
  msl_fetcher:
    git:
      url: https://github.com/musiolmarco/msl_fetcher
      ref: main
```

## Setup your own default widgets (optional) 👷
```dart
void main() {

  MslFetcher.setup(
    defaultErrorWidget: (error, onRefresh) => const Text('An error has occured...'),
    defaultLoadingWidget: const CircularProgressIndicator(),
  );

  runApp(const MyApp());
}
```
You can use the `MslFetcher.setup()` method in the `void main()` method to setup your own default widgets. This widgets will be displayed by default if you don't provide any other widgets into the `MslFetcher()`.

## Fetching, displaying data & handling states 🗂
The main `Widget` of this package is the `MslFetcher` widget.
```dart
MslFetcher<List<Todo>>(
            showErrorLogs: true,
            fetchData: () => _todosRepository.getExampleTodosFromApi(),
            dataAvailableWidget: (List<Todo> availableData) => TodoListView(
              todos: availableData,
            ),
            fetchingErrorWidget: (error, onRefresh) =>
                const Text('Error while fetching...'),
            loadingWidget: const Text('Loading...'),
          ),
```

### Important ❗️
The `fetchingErrorWidget` and `loadingWidget` widgets are optional. If you wont pass them it will use the default widgets of the package.

### `fetchData` 📂
This method should fetch & return the available data coming from the backend. It is important that it matches the generic from the `MslFetcher`. In this case it's `<List<Todo>>`.

### `dataAvailableWidget` ⬇️
This `Widget` is displayed if the data is fetched and returned. You can access the downloaded data by the `availableData`.

### `fetchingErrorWidget` ⚠️
This `Widget` is displayed if there was an error while fetching and returning the data. Here you can for example display an error message that says "An error occured. Please try again". You can also use the `error` `Object` if you want to handle something based on what error has been catched. The `onRefresh` method makes it available to redo the fetching process if you want to implement a "try again" button for example. 

### `loadingWidget` 🕑
This `Widget` is displayed while the data is being fetched.

## Other parameters ⚒
Here you can find a code snipped from the source code that explains everything you can pass into the `MslFetcher` widget.
```dart
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
  /// 
  /// [onRefresh] is the function that will redo the fetch again
  final Widget Function(Object error, VoidCallback onRefresh)?
      fetchingErrorWidget;

  /// Pass [showErrorLog] as true if you want to log errors into the console
  final bool? showErrorLogs;
```
