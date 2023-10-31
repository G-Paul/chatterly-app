import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQRCode extends StatelessWidget {
  final String dataString;
  const ShowQRCode({super.key, required this.dataString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: QrImageView(
          data: dataString,
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(10),
          size: MediaQuery.of(context).size.width * 0.5,
          // embeddedImage: AssetImage('assets/images/chatterly.png'),
          eyeStyle: QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
