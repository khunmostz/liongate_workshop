import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/controllers/home.controller.dart';
import 'package:liongate_workshop/models/animal.model.dart';

class HomeScreen extends StatelessWidget {
  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            return Container(
              width: w,
              height: h,
              child: Stack(
                children: [
                  Container(
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
                          top: -30 * (1 - _homeController.circleOffset),
                          right: -150 *
                              (1 - _homeController.circleOffset * 0.2)
                                  .clamp(0, 1),
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
                          bottom: 100 * _homeController.circleOffset,
                          left: (-50) * _homeController.circleOffset,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.amber.shade200,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: SafeArea(
                      child: Container(
                        width: w,
                        height: h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 100),

                              // title
                              Align(
                                alignment: Alignment.centerLeft,
                                child: FadeInRight(
                                  duration: 500.milliseconds,
                                  child: Text(
                                    'lion gate'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // Category
                              Container(
                                width: w,
                                height: 60,
                                // decoration: BoxDecoration(border: Border.all()),ช
                                child: Row(
                                  children: List.generate(
                                    _homeController.animalCategory
                                        .toSet()
                                        .length,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        // print(
                                        //   _homeController.animalCategory[index],
                                        // );
                                        _homeController.onSelected(
                                          index: index,
                                          typeSelect: _homeController
                                              .animalCategory[index],
                                        );
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: FadeInRight(
                                          duration: Duration(
                                              milliseconds:
                                                  500 - (index * 100)),
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              // border: Border.all(),
                                              color: _homeController
                                                          .selectedCategory ==
                                                      index
                                                  ? Colors.amber.shade400
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Text(
                                                _homeController
                                                    .animalCategory[index],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Animal List

                              Container(
                                width: w,
                                height: h * 0.4,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      _homeController.filterAnimal.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/detail', arguments: [
                                            _homeController
                                                .filterAnimal[index].image,
                                            _homeController
                                                .filterAnimal[index].name,
                                            _homeController
                                                .filterAnimal[index].species,
                                            _homeController
                                                .filterAnimal[index].type,
                                            _homeController.filterAnimal[index]
                                                .showDuration,
                                          ]);
                                        },
                                        child: FadeInRight(
                                          duration: Duration(
                                              milliseconds:
                                                  500 - (index * 100)),
                                          child: Hero(
                                            tag: _homeController
                                                .filterAnimal[index].image,
                                            child: Container(
                                              width: w * 0.6,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    _homeController
                                                        .filterAnimal[index]
                                                        .image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: w,
                                                    height: h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.black54,
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 20,
                                                    left: 20,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            _homeController
                                                                .filterAnimal[
                                                                    index]
                                                                .name,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            _homeController
                                                                .filterAnimal[
                                                                    index]
                                                                .species,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // fontWeight:
                                                              // FontWeight.bold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Choose round
                              // Container(
                              //   width: w,
                              //   height: 60,
                              //   // decoration: BoxDecoration(border: Border.all()),
                              //   child: Row(
                              //     children: List.generate(
                              //       _homeController.roundCategory.length,
                              //       (index) => FadeInRight(
                              //         duration: Duration(
                              //             milliseconds: 500 - (index * 100)),
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             _homeController.onSelectRound(
                              //               index: index,
                              //               roundSelect: _homeController
                              //                   .roundCategory[index],
                              //             );
                              //           },
                              //           child: Padding(
                              //             padding:
                              //                 const EdgeInsets.only(right: 8.0),
                              //             child: Container(
                              //               width: 100,
                              //               height: 40,
                              //               decoration: BoxDecoration(
                              //                 color:
                              //                     _homeController.selectRound ==
                              //                             index
                              //                         ? Colors.amber.shade400
                              //                         : Colors.transparent,
                              //                 borderRadius:
                              //                     BorderRadius.circular(12),
                              //               ),
                              //               child: Center(
                              //                 child: Text(
                              //                   _homeController
                              //                       .roundCategory[index],
                              //                   style: TextStyle(
                              //                     color: Colors.black,
                              //                     fontSize: 18,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              // show Info

                              FadeInUp(
                                delay: 500.milliseconds,
                                child: Container(
                                  width: w,
                                  height: h * 0.15,
                                  decoration: BoxDecoration(
                                      // border: Border.all(),
                                      ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/showround');
                                          },
                                          child: Container(
                                            width: 200.w,
                                            height: 50.h,
                                            // color: Colors.amber,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Round to show >',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // SizedBox(height: 20),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //     horizontal: 20,
                                        //   ),
                                        //   child: Text(
                                        //     'Infomation',
                                        //     style: TextStyle(
                                        //       fontSize: 18,
                                        //       fontWeight: FontWeight.bold,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //     _buildInfo(
                                        //       info_1:
                                        //           _homeController.animalName[0],
                                        //       info_2:
                                        //           _homeController.animalTime[0],
                                        //       info_3:
                                        //           _homeController.animalRoom[0],
                                        //     ),
                                        //     _buildInfo(
                                        //       info_1:
                                        //           _homeController.animalName[1],
                                        //       info_2:
                                        //           _homeController.animalTime[1],
                                        //       info_3:
                                        //           _homeController.animalRoom[1],
                                        //     ),
                                        //     _buildInfo(
                                        //       info_1:
                                        //           _homeController.animalName[2],
                                        //       info_2:
                                        //           _homeController.animalTime[2],
                                        //       info_3:
                                        //           _homeController.animalRoom[2],
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // nav

                  // Positioned(
                  //   bottom: 30,
                  //   left: w / 2 - w * 0.6 / 2,
                  //   child: Container(
                  //     width: w * 0.6,
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //       color: mainColor,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Text(
                  //           'USER',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //         Text(
                  //           'ADMIN',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
    );
  }

  
}
