import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

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
        centerTitle: false,
        title: RichText(
          text: TextSpan(
              text: "Hai, ",
              style: TextStyle(
                fontSize: 18,
              ),
              children: [
                TextSpan(
                    text: "Muhammad",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ]),
        ),
        actions: [
          GestureDetector(
            onTap: () => {},
            child: Container(
              child: Image.asset("assets/logo/barcode.png"),
              width: 50,
              height: 50,
            ),
          )
        ],
        backgroundColor: Color(0xFFEC2028),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: 250,
            width: Get.width,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/elements/header_home.png",
                fit: BoxFit
                    .cover, // Cover the entire width while maintaining aspect ratio
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.4,
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: ClipInfoClass(),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(colors: [
                                Color(0xFFE52D27),
                                Color(0xFFB31217)
                              ])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "085229952534",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Image.asset("assets/logo/simpati.png")
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Sisa pulsa anda",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rp23.000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber),
                                      onPressed: () => {},
                                      child: Text(
                                        "Isi Pulsa",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Berlaku sampai ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      children: [
                                    TextSpan(
                                      text: "23 Desember 2023",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ])),
                              SizedBox(
                                height: 6,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Telkomsel POIN ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  children: [
                                    WidgetSpan(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.circular(
                                              4), // Adjust the radius as needed
                                        ),
                                        child: Text(
                                          "172",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 5,
                  color: Colors.grey[200],
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.purple,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // body: Container(
      //   alignment: Alignment.center,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       BarcodeScannerWidget(onScanComplete: _handleScanComplete),
      //       Text('Scan result: $_scanBarcodeResult\n'),
      //     ],
      //   ),
      // ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 80, size.height);
    path.lineTo(size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
