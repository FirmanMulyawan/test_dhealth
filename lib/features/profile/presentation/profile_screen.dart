import 'package:flutter/material.dart';

import '../../../component/config/app_style.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 130,
            ),
            Text(
              "Cooming Soon",
              style: AppStyle.bold(size: 50, textColor: AppStyle.black),
            )
          ],
        ),
      ),
    );
  }
}
