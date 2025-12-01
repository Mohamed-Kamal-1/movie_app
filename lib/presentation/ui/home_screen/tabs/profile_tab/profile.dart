import 'package:flutter/material.dart';
import 'package:movie_app/ui/user_profile_Screen/user_profile_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return UserProfileScreen();
  }
}
