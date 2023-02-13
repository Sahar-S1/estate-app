import 'package:estate/components/AppDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estate"),
      ),
      body: Container(),
      drawer: AppDrawer(),
    );
  }
}
