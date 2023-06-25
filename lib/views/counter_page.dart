import 'package:flutter/material.dart';

import '../configs/value_notifier.dart';
import '../provider/authentication_change_notifier.dart';
import '../shared/change_notifier_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // mutable state
  int _counter = 0;

  void _counterIncrement() {
    setState(() {
      _counter++; // _counter = _counter + 1
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return ChangeNotifierProvider(
      notifier: AuthenticationChangeNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: counterNotifier,
            builder: (context, myValue, child) {
              return Text(
                'Counter notifier: $myValue',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                final authenticationProvider =
                    ChangeNotifierProvider.of<AuthenticationChangeNotifier>(
                        context);

                authenticationProvider.logout();
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_counter',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _counterIncrement(),
                child: const Text('Increment'),
              ),
              const Divider(),
              Text(
                'Counter notifier: ${counterNotifier.value}',
                style: TextStyle(fontSize: 20),
              ),
              // ValueListenableBuilder(
              //   valueListenable: counterNotifier,
              //   builder: (context, myValue, child) {
              //     return CounterWidget();
              //   },
              // ),
              CounterWidget(),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text("Increment notifier"),
                onPressed: () {
                  counterNotifier.value++;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    super.key,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  // on changed
  void _onChanged() {
    setState(() {
      _counter = counterNotifier.value;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      counterNotifier.addListener(_onChanged);
    });
  }

  @override
  void dispose() {
    counterNotifier.removeListener(_onChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Counter notifier: $_counter',
          style: TextStyle(fontSize: 20),
        ),
        const Divider(),
        ElevatedButton(
          onPressed: () {
            final authenticationProvider =
                ChangeNotifierProvider.of<AuthenticationChangeNotifier>(
                    context);

            authenticationProvider.logout();
          },
          child: Text("Logout"),
        ),
      ],
    );
  }
}
