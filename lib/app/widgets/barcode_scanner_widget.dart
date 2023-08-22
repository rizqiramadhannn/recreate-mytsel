import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerWidget extends StatelessWidget {
  final Function(String) onScanComplete;

  const BarcodeScannerWidget({required this.onScanComplete});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _scanBarcode(context),
      child: Text("Scan Barcode"),
    );
  }

  Future<void> _scanBarcode(BuildContext context) async {
    String res;
    try {
      res = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(res);
    } on PlatformException {
      res = 'Failed to get platform version.';
    }
    onScanComplete(res); // Pass the result back to the parent widget
  }
}
