import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:umonda/Social_Login/yyyy.dart';

class loginapple extends StatefulWidget {
  @override
  State<loginapple> createState() => _loginappleState();
}

class _loginappleState extends State<loginapple> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up with Apple ID'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Platform.isIOS
                ? Padding(
              padding: const EdgeInsets.all(18.0),
              child: SignInWithAppleButton(
                onPressed: () async {
                  print('Before getAppleIDCredential');
                  print(SignInWithApple.getAppleIDCredential);

                  final appleIdCredential =
                  await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );
                  print(appleIdCredential);
                  print('After getAppleIDCredential');

                  final credential = OAuthCredential(
                    providerId: 'apple.com',
                    signInMethod: 'oauth',
                    accessToken: appleIdCredential.authorizationCode,
                    idToken: appleIdCredential.identityToken,
                  );
                  await FirebaseAuth.instance
                      .signInWithCredential(credential);
                  print("_____________________");
                  print(credential);
                  print("_____________________");
                },
              ),
            )
                : Text('It is android.'),
            youtubePromotion()
          ],
        ),
      ),
    );
  }
}
