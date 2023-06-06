import 'package:flutter/material.dart';
import 'package:msl_fetcher/msl_fetcher.dart';

/// This widget is displayed if the [MslFetcher] got an error and no
/// other error [Widget] is passed to it
class MslFetcherDefaultErrorWidget extends StatelessWidget {
  const MslFetcherDefaultErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'An error has occurred',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Text(
          'An error occurred while loading the data. Please try again.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5.0,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.refresh,
          ),
        ),
      ],
    );
  }
}
