import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reditt_clone/core/constants/picture_constants.dart';
import 'package:reditt_clone/features/auth/controller/auth_controller.dart';
import 'package:reditt_clone/theme/colors_palette.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});
  void SignInWithGoogle(WidgetRef ref) {
    ref.read(authControllerProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => SignInWithGoogle(ref),
        icon: Image.asset(
          PictureConstants.googleLogo,
          width: 40,
        ),
        label: const Text(
          'Continue with Google!',
        ),
      ),
    );
  }
}
