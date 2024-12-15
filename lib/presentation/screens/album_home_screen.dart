import 'package:flutter/material.dart';

class AlbumHomeScreen extends StatelessWidget {
  const AlbumHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Albums")), body: Center(child: const Text("Home Screen",style: TextStyle(fontSize: 32),)));
  }
}
