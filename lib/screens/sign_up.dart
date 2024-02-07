import 'package:flutter/material.dart';

import 'package:video_audio_calls/common/widgets/loading_holder.dart';
import 'package:video_audio_calls/common/widgets/top_bar.dart';
import 'package:video_audio_calls/services/firebase_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final nameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final passwordConfirmFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<bool> _onPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
                'Go back to Login and cancel the data entered? (if you have entered anything).'),
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
          nameFocusNode.unfocus();
          usernameFocusNode.unfocus();
          passwordFocusNode.unfocus();
          passwordConfirmFocusNode.unfocus();
          emailFocusNode.unfocus();
        },
        child: Scaffold(
          body: LoadingHolder(
            isLoading: isLoading,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const TopBar(title: 'Sign up', upperTitle: ''),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Create a New Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController,
                          focusNode: nameFocusNode,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Mike Johnson',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: usernameController,
                          focusNode: usernameFocusNode,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'mike_johnson',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
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
                          height: 15,
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
                          height: 15,
                        ),
                        TextFormField(
                          focusNode: passwordConfirmFocusNode,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Password doesn't match";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
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
                            const Text("Already have an account?"),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                style: TextStyle(
                                  color: Theme.of(context).shadowColor,
                                ),
                                'Log in',
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
                              final isValid = formKey.currentState?.validate();
                              if (isValid != true) {
                                return;
                              }
                              setState(() {
                                isLoading = true;
                              });

                              final bool result = await FirebaseService.signUp(
                                email: emailController.text,
                                name: nameController.text,
                                username: usernameController.text,
                                password: passwordController.text,
                              );

                              if (result) {
                                await showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Registration Completed!'),
                                        content: const Text(
                                          "You can log in with your email and password now!",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                            },
                                            child: Text(
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .shadowColor,
                                                ),
                                                'OK'),
                                          )
                                        ],
                                      );
                                    });
                                if (mounted) Navigator.pop(context);
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
                                'Sign up'),
                          ),
                        )
                      ],
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
