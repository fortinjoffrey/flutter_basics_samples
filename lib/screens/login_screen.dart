import 'dart:io';

import 'package:basics_samples/auth/auth_provider.dart';
import 'package:basics_samples/models/login_method.dart';
import 'package:basics_samples/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.authProvider,
  });

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SignInButton(
                backgroundColor: Color(0xFF3b5998),
                leadingIcon: SvgPicture.asset('assets/logos/facebook_simple.svg', color: Colors.white, height: 24),
                onPressed: () async {
                  final credentials = await authProvider.signInWithFacebook();

                  if (credentials != null) {
                    pushHomeScreen(context, authProvider.userEmail, authProvider.loginMethod);
                  }
                },
                title: 'Sign in with Facebook',
              ),
              const SizedBox(height: 16),
              _SignInButton(
                backgroundColor: Color(0xFFDE5246),
                leadingIcon: SvgPicture.asset('assets/logos/google_simple.svg', color: Colors.white, height: 24),
                onPressed: authProvider.signInWithGoogle,
                title: 'Sign in with Google',
              ),
              const SizedBox(height: 16),
              if (Platform.isIOS)
                _SignInButton(
                  backgroundColor: Colors.black,
                  leadingIcon: SvgPicture.asset('assets/logos/apple_simple.svg', color: Colors.white, height: 24),
                  onPressed: authProvider.signInWithApple,
                  title: 'Sign in with Apple',
                ),
            ],
          ),
        ),
      ),
    );
  }

  void pushHomeScreen(BuildContext context, String? email, LoginMethod loginMethod) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          userEmail: email,
          loginMethod: loginMethod,
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    required this.onPressed,
    required this.leadingIcon,
    required this.title,
    required this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Widget leadingIcon;
  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                leadingIcon,
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Card(
    //   color: backgroundColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(32.0),
    //   ),
    //   child: InkWell(
    //     borderRadius: BorderRadius.circular(32.0),
    //     onTap: onPressed,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16.0),
    //       child: Row(
    //         children: [
    //           leadingIcon,
    //           const SizedBox(width: 16),
    //           Expanded(
    //             child: Text(
    //               title,
    //               style: const TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w600,
    //                 fontSize: 17,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
