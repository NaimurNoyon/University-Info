import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No Internet Connection"),
      ),
      body: Center(
        child: Text("Please check your internet connection."),
      ),
    );
  }
}
