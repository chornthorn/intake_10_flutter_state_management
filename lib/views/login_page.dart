import 'package:flutter/material.dart';

import '../provider/authentication_change_notifier.dart';
import '../shared/change_notifier_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final authenticationProvider =
                ChangeNotifierProvider.of<AuthenticationChangeNotifier>(
                    context);
            authenticationProvider.login();
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
