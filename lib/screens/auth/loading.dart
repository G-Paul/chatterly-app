import 'package:flutter/material.dart';

//make a simple scaffold with a circular progress indicator in the center in the primary color
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return a Scaffold with a circular progress indicator in the center in the primary color
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 5,
            ),
            SizedBox(height: 20),
            Text(
              '   Loading...',
              style: TextStyle(
                fontSize: 15,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
