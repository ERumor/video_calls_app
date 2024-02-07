import 'package:flutter/material.dart';
import 'package:video_audio_calls/common/constants.dart';
import 'package:video_audio_calls/common/routes.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'package:video_audio_calls/common/widgets/top_bar.dart';
import 'package:video_audio_calls/common/widgets/loading_holder.dart';
import 'package:video_audio_calls/services/firebase_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  /// on App's user login
  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: ZegoConsts.appID /*input your AppID*/,
      appSign: ZegoConsts.appSign /*input your AppSign*/,
      userID: FirebaseService.currentUser.username,
      userName: FirebaseService.currentUser.username,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  Future<bool> _onPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: Text(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    'No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: Text(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    'Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
        child: Scaffold(
          body: LoadingHolder(
            isLoading: isLoading,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const TopBar(title: "Login", upperTitle: ''),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Log Into Your Account',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            cursorColor: Theme.of(context).primaryColor,
                            controller: emailController,
                            focusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'example@domain.com',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: '********',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text("Don't have an account?"),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    PageRouteNames.signup,
                                  );
                                },
                                child: Text(
                                  style: TextStyle(
                                    color: Theme.of(context).shadowColor,
                                  ),
                                  'Sign up',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState?.validate();
                                if (isValid != true ||
                                    emailController.text.isEmpty ||
                                    passwordController.text.isEmpty) {
                                  return;
                                }
                                setState(() {
                                  isLoading = true;
                                });

                                final bool result = await FirebaseService.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                if (result && mounted) {
                                  onUserLogin();
                                  Navigator.pushNamed(
                                    context,
                                    PageRouteNames.home,
                                  );
                                } else {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Something went wrong!"),
                                      ),
                                    );
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text(
                                style: TextStyle(
                                  color: Theme.of(context).shadowColor,
                                ),
                                'Sign in',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
