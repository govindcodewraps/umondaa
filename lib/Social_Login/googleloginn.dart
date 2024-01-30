import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class HomePagegogle extends StatefulWidget {
  // HomePagegogle(key: key);

  @override
  State<HomePagegogle> createState() => _HomePagegogleState();
}

class _HomePagegogleState extends State<HomePagegogle> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _user;
  String accessToken;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google SignIn"),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google",
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_user.photoURL),
              ),
            ),
          ),
          Text(_user.email),
          Text(_user.displayName ?? ""),
          Text(_user.uid ?? ""),
          Text(accessToken ?? "null"),
          MaterialButton(
            color: Colors.red,
            child: const Text("Sign Out"),
            onPressed: _auth.signOut,
          )
        ],
      ),
    );
  }

  void _handleGoogleSignIn() async{
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
      var result = await _auth.signInWithPopup(_googleAuthProvider);

      // Access the Google Access Token
      var googleAccessToken = await result.credential.accessToken;

      setState(() {
        _user = result.user;
      });
      accessToken=googleAccessToken;
      print("Google Access Token: $googleAccessToken");
    } catch (error) {
      print(error);
    }
  }
}
