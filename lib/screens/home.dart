import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:video_audio_calls/common/widgets/top_bar.dart';
import 'package:video_audio_calls/common/widgets/user_card.dart';
import 'package:video_audio_calls/models/user.dart';
import 'package:video_audio_calls/services/firebase_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../common/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }

  Future<bool> _onPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to Logout?'),
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
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                TopBar(
                  upperTitle: 'Welcome back,',
                  title: FirebaseService.currentUser.name,
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseService.buildViews,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).shadowColor,
                          ),
                        );
                      }
                      final List<QueryDocumentSnapshot>? docs =
                          snapshot.data?.docs;
                      if (docs == null || docs.isEmpty) {
                        return const Text('No data');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final model = UserModel.fromJson(
                            docs[index].data() as Map<String, dynamic>,
                          );
                          if (model.username !=
                              FirebaseService.currentUser.username) {
                            return UserCard(userModel: model);
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: ElevatedButton(
            onPressed: () {
              onUserLogout();
              Navigator.pushNamed(
                context,
                PageRouteNames.login,
              );
            },
            child: Text(
              style: TextStyle(
                color: Theme.of(context).shadowColor,
              ),
              'Logout',
            ),
          ),
        ),
      ),
    );
  }
}
