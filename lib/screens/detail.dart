import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/controllers/detail.controller.dart';

class DetailScreen extends StatelessWidget {
  var image = Get.arguments[0];
  var name = Get.arguments[1];
  var species = Get.arguments[2];
  var type = Get.arguments[3];
  var showDuration = Get.arguments[4];

  @override
  Widget build(BuildContext context) {
    DetailController _detailController = Get.put(DetailController());

    return GetBuilder<DetailController>(builder: (_) {
      return Scaffold(
        body: Container(
          width: w,
          height: h,
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.4,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Hero(
                          tag: image,
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 20,
                      width: w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      width: w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            type,
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            species,
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Showtime: ${showDuration.toString().substring(2, 7)}',
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: w,
                  height: 400.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text('Detail'),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dummyText),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
