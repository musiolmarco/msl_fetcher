# msl_fetcher 🌐
With msl_fetcher you can fetch and handle data easily. Handle all states (Loading, Error, Data available) within a minute.🕚

## Getting started 🚀
Add this lines to your pubspec.yaml dependencies.
```yaml
dependencies:
  msl_fetcher:
    hosted:
      url: https://github.com/musiolmarco/msl_fetcher
      ref: main
```

## Fetching, displaying data & handling states 🗂
The main `Widget` of this package is the `MslFetcher` widget.
```dart
MslFetcher<List<Todo>>(
            fetchData: () => _todosRepository.getExampleTodosFromApi(),
            dataAvailableWidget: (List<Todo> availableData) => Expanded(
              child: TodoListView(
                todos: availableData,
              ),
            ),
            fetchingErrorWidget: const Text('Error while fetching...'),
            loadingWidget: const Text('Loading...'),
          ),
```

### `fetchData` 📂
This method should fetch & return the available data coming from the backend. It is important that it matches the generic from the `MslFetcher`. In this case it's `<List<Todo>>`.

### `dataAvailableWidget` ⬇️
This `Widget` is displayed if the data is fetched and returned. You can access the downloaded data by the `availableData`.

### `fetchingErrorWidget` ⚠️
This `Widget` is displayed if there was an error while fetching and returning the data. Here you can for example display an error message that says "An error occured. Please try again".

### `loadingWidget` 🕑
This `Widget` is displayed while the data is being fetched.

## Other parameters ⚒
Here you can find a code snipped from the source code that explains everything you can pass into the `MslFetcher` widget.
```dart
  /// The method that fetches and returns the data
  final Future<T> Function() fetchData;

  /// This [Widget] is displayed while the data is being fetched
  final Widget loadingWidget;

  /// This [Widget] is displayed if the data is available
  final Widget Function(T availableData) dataAvailableWidget;

  /// Tis [Widget] is displayed if there was an error while fetching the data
  final Widget fetchingErrorWidget;

  /// Pass [showErrorLog] as true if you want to log errors into the console
  final bool? showErrorLogs;
```
