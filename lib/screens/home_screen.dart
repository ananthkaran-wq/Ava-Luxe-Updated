import 'package:flutter/material.dart';
import '../widgets/avatar_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          AvatarView(size: 220),
          SizedBox(height: 16),
          Text('Welcome to Ava Luxe ✨'),
        ],
      ),
    );
  }
}
