import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:mytsel/app/widgets/barcode_scanner_widget.dart'; // Import the barcode scanner widget

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _scanBarcodeResult = '';

  void _handleScanComplete(String result) {
    setState(() {
      _scanBarcodeResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeScannerWidget(onScanComplete: _handleScanComplete),
            Text('Scan result: $_scanBarcodeResult\n'),
          ],
        ),
      ),
    );
  }
}
