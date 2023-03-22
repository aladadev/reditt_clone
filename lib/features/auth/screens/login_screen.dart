import 'package:flutter/material.dart';
import 'package:reditt_clone/core/common/sign_in_button.dart';
import 'package:reditt_clone/core/constants/picture_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          PictureConstants.logo,
          height: 35,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Dive into anything',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              PictureConstants.loginEmote,
              height: 400,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const LoginButton(),
        ],
      ),
    );
  }
}
