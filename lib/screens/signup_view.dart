import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daily_flutter/widgets/text_input_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  bool _signUpComplete = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _username.dispose();
    _password.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await Amplify.Auth.signUp(
        username: _username.text,
        password: _password.text,
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: _email.text,
          },
        ),
      );
      setState(() {
        _signUpComplete = result.isSignUpComplete;
      });
    } on AuthException catch (e) {
      safePrint(e.message);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            TextInputField(
              textEditingController: _email,
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 18,
            ),
            TextInputField(
              textEditingController: _username,
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 18,
            ),
            TextInputField(
              textEditingController: _password,
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            const SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: signUpUser,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  color: Colors.blue,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
