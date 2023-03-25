import 'package:daily_flutter/screens/login_view.dart';
import 'package:daily_flutter/screens/signup_view.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daily'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Log In',
              ),
              Tab(
                text: 'Sign up',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            LoginScreen(),
            SignUpScreen(),
          ],
        ),
      ),
    );
  }
}
