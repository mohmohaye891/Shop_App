import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/view/login/login_view.dart';

import '../../common/preference_util.dart';
import '../home/home_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeNavigationScreen(),
              ),
            );
          },
        ),
        title: const Center(child: Text('Profile')),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 40.0,
            ),
            alignment: Alignment.center,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            child: const Text('Logout'),
            onPressed: () async {
              String? token = await PreferencesUtil.getLoginUserData();
              debugPrint("Profile Screen Token : $token");
              PreferencesUtil.removeLoginUserData();
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => const LoginScreen()),
                (_) => false,
              );
            },
          )
        ],
      )),
    );
  }
}
