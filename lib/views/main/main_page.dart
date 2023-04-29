import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_SW.png',
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(),
      ),
    );
  }
}
