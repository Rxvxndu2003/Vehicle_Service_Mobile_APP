import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vehicle_app/widgets/navbar_roots.dart';  // Import the url_launcher package

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  bool isScanCompleted = false;

  // Function to launch the URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  void onDetect(BarcodeCapture barcode) {
    if (!isScanCompleted) {
      setState(() {
        isScanCompleted = true;
      });

      final String qrCodeResult = barcode.barcodes.first.rawValue ?? "No QR code detected!";

      // Check if the result is a valid URL
      if (Uri.tryParse(qrCodeResult)?.hasAbsolutePath ?? false) {
        // Launch the URL directly
        _launchURL(qrCodeResult);
      } else {
        // If not a URL, handle it in other ways or show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid QR code or not a URL: $qrCodeResult')),
        );

        // Reset scan to allow scanning again
        setState(() {
          isScanCompleted = false;
        });
      }
    }
  }

  @override 
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp,
          size: 28, 
          color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                            ),
          onPressed: () {
           Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavbarRoots(initialIndex: 4,),
              ),
            );
          },
        ),
        title: Text(
          'QR Scanner',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: 28, // Size of the notification icon
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                         ? Colors.white
                         : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Scanning will be started automatically",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                         ? Colors.white
                         : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: MobileScanner(
                onDetect: onDetect,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
