import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.fetchUserData(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while data is being fetched
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            );
          } else {
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
                            text: controller.userName.value,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
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
                          height: Get.height * 0.37,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.phoneNumber.value,
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
                                          Obx(
                                            () => Text(
                                              controller.pulsa.value,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.amber),
                                              onPressed: () => {},
                                              child: Text(
                                                "Isi Pulsa",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Obx(
                                        () => RichText(
                                            text: TextSpan(
                                                text: "Berlaku sampai ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                                children: [
                                              TextSpan(
                                                text:
                                                    controller.numExpDate.value,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ])),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Telkomsel POIN ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                              ),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: Row(
                                  children: [
                                    Card(
                                      title: "Internet",
                                      data: controller.internet.value,
                                      satuan: "GB",
                                    ),
                                    Card(
                                      title: "Telpon",
                                      data: controller.telpon.value,
                                      satuan: "Min",
                                    ),
                                    Card(
                                      title: "SMS",
                                      data: controller.sms.value,
                                      satuan: "SMS",
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                          color: Colors.grey[200],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              //color: Colors.purple,
                              margin: EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kategori Paket",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_internet.png",
                                          title: "Internet"),
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_telpon.png",
                                          title: "Telpon"),
                                      RoundedMenu(
                                          img: "assets/elements/home_pesan.png",
                                          title: "SMS"),
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_roaming.png",
                                          title: "Roaming")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_hiburan.png",
                                          title: "Hiburan"),
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_unggulan.png",
                                          title: "Unggulan"),
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_tersimpan.png",
                                          title: "Tersimpan"),
                                      RoundedMenu(
                                          img:
                                              "assets/elements/home_riwayat.png",
                                          title: "Riwayat")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Terbaru dari Telkomsel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "Lihat Semua",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 150, // Adjust the height as needed
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.bannerUri
                                          .length, // Replace with the actual length of your banner URLs array
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: 248,
                                          height: 100,
                                          margin: EdgeInsets.only(right: 10),
                                          child: Image.network(
                                            controller.bannerUri[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Tanggap COVID-19",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 172, // Adjust the height as needed
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          width: 248,
                                          margin: EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                    112, // Adjust the width as needed
                                                child: Image.asset(
                                                    "assets/elements/banner_covid1.png"), // Replace with your first banner widget
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  "Diskon Spesial 25% Untuk Pelanggan Baru",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          width: 248,
                                          margin: EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                height:
                                                    112, // Adjust the width as needed
                                                child: Image.asset(
                                                    "assets/elements/banner_covid2.png"), // Replace with your first banner widget
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  "Bebas Kuota Akses Layanan Kesehatan",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
        });
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

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Container(height: 30, child: Icon(Icons.home))],
    );
  }
}

class Card extends StatelessWidget {
  const Card(
      {super.key,
      required this.title,
      required this.data,
      required this.satuan});
  final String title;
  final String data;
  final String satuan;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 3), // changes the position of the shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            SizedBox(
              height: 8,
            ),
            RichText(
                text: TextSpan(
                    text: data,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                    text: " " + satuan,
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}

class RoundedMenu extends StatelessWidget {
  const RoundedMenu({super.key, required this.img, required this.title});
  final String img;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Image.asset(img),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
