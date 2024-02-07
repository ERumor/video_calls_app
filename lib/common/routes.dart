import 'package:flutter/material.dart';

import 'package:video_audio_calls/screens/home.dart';
import 'package:video_audio_calls/screens/login.dart';
import 'package:video_audio_calls/screens/sign_up.dart';

class PageRouteNames {
  static const String login = '/login';
  static const String home = '/home';
  static const String signup = '/sign_up';
}

const TextStyle textStyle = TextStyle(
  color: Colors.black,
  fontSize: 13.0,
  decoration: TextDecoration.none,
);

Map<String, WidgetBuilder> routes = {
  PageRouteNames.login: (context) => const Login(),
  PageRouteNames.home: (context) => const Home(),
  PageRouteNames.signup: (context) => const SignUp(),
};
