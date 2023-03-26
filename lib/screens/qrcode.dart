import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/controllers/qrcode.controller.dart';

import 'package:qr_flutter/qr_flutter.dart';

class QrcodeScreen extends StatelessWidget {
  const QrcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QrcodeController _qrcodeController = Get.put(QrcodeController());

    var total = Get.arguments[0].toString();
    return Scaffold(
        body: Container(
      width: w,
      height: h,
      child: GetBuilder<QrcodeController>(
          init: QrcodeController(),
          builder: (_) {
            return Container(
              width: w,
              height: h * 0.45,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -30 * (1 - _qrcodeController.circleOffset),
                    right: -150 *
                        (1 - _qrcodeController.circleOffset * 0.2).clamp(0, 1),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber.shade200,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100 * _qrcodeController.circleOffset,
                    left: (-50) * _qrcodeController.circleOffset,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber.shade200,
                      ),
                    ),
                  ),
                  Container(
                    width: w,
                    height: h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: w * 0.9,
                          height: h * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              QrImage(
                                data: total,
                                size: 200.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                "Generate QR Code for $total baht",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.offNamed('/home');
                                },
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'HOME',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    ));
  }
}
