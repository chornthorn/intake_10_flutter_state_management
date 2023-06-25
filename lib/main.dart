import 'package:flutter/material.dart';
import 'package:flutter_state_management/shared/change_notifier_provider.dart';

import 'provider/authentication_change_notifier.dart';
import 'provider/user_change_notifier.dart';
import 'views/counter_page.dart';
import 'views/login_page.dart';

void main() {
  final authProvider = AuthenticationChangeNotifier();
  final userChangeNotifier = UserChangeNotifier();
  runApp(
    ChangeNotifierProvider<AuthenticationChangeNotifier>(
      notifier: authProvider,
      child: ChangeNotifierProvider<UserChangeNotifier>(
        notifier: userChangeNotifier,
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final authentication =
    //     ChangeNotifierProvider.of<AuthenticationChangeNotifier>(context);
    return MaterialApp(
      home: NotifierBuilder<AuthenticationChangeNotifier>(
        notifier: ChangeNotifierProvider.of<AuthenticationChangeNotifier>(
          context,
        ),
        builder: (context, notifier, child) {
          return notifier.isAuthenticated ? CounterPage() : LoginPage();
        },
      ),
    );
  }
}
