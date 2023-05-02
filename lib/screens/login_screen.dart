import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_auth_methods.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Login Screen'),
        //   centerTitle: true,
        // ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: Image.asset(
                        'assets/login_logo.png',
                        scale: 1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Let's get started!",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FloatingActionButton.extended(
                        onPressed: () {
                          context
                              .read<FirebaseAuthMethods>()
                              .signInWithGoogle(context);
                        },
                        label: Text('Sign in with Google'),
                        icon: Image.asset(
                          'assets/google_logo.png',
                          scale: 8,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
