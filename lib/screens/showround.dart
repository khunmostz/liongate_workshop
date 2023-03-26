import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/controllers/showround.controller.dart';
import 'package:liongate_workshop/models/room.model.dart';
import 'package:liongate_workshop/models/round.model.dart';
import 'package:liongate_workshop/screens/widgets/sceen_painter.dart';
import 'package:collection/collection.dart';

class RoundScreen extends StatelessWidget {
  // const RoundScreen({super.key});

  ShowRoundController _showRoundController = Get.put(ShowRoundController());
  final box = GetStorage();
  Color seatColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowRoundController>(builder: (_) {
      return Scaffold(
        floatingActionButton: true
            ? FloatingActionButton.extended(
                onPressed: () {
                  var value = box.read('reservedSeats');
                  if (value != null) {
                    print('storage: ' + value.toString());
                    for (var element in value) {
                      // print(element);
                      _showRoundController.reserveSeatList.add(element);
                    }
                    box.write(
                        'reservedSeats', _showRoundController.reserveSeatList);
                  } else {
                    box.write(
                        'reservedSeats', _showRoundController.reserveSeatList);
                  }

                  // print(_showRoundController.reserveSeatList);

                  Get.offNamed('/qrcode', arguments: [
                    _showRoundController.totalPrice,
                  ]);
                },
                icon: Icon(Icons.money),
                label: Text("Payment"),
              )
            : null,
        body: Container(
          width: w,
          height: h,
          color: mainColor,
          child: Stack(
            children: [
              Positioned(
                top: -30 * (1 - _showRoundController.circleOffset),
                right: -150 *
                    (1 - _showRoundController.circleOffset * 0.2).clamp(0, 1),
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
                bottom: 100 * _showRoundController.circleOffset,
                left: (-50) * _showRoundController.circleOffset,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber.shade200,
                  ),
                ),
              ),
              Positioned(
                top: 100.h,
                left: w / 2 - 500.w / 2,
                child: Container(
                  width: 500.w,
                  height: 80.h,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    children: List.generate(
                      _showRoundController.roundCategory.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _showRoundController.onSelectRound(
                              index: index,
                              roundSelect:
                                  _showRoundController.roundCategory[index],
                            );
                          },
                          child: ZoomIn(
                            delay: Duration(milliseconds: 300 - (index * 100)),
                            child: Container(
                              width: 100.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: _showRoundController.selectRound == index
                                    ? Colors.amber
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  _showRoundController.roundCategory[index],
                                  style: TextStyle(
                                    color: _showRoundController.selectRound ==
                                            index
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
              ),
              Positioned(
                top: 180.h,
                child: GetBuilder<ShowRoundController>(
                    id: 'checkBox',
                    builder: (_) {
                      return FadeInUp(
                        delay: 500.milliseconds,
                        child: Container(
                          width: w,
                          height: 380.h,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (_showRoundController.roundValue ==
                                          'Round 1') ...[
                                        FadeInLeft(
                                          delay: 600.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 0,
                                            showId: _showRoundController
                                                .anmimalId[0],
                                            info_1: _showRoundController
                                                .animalName[0],
                                            info_2: _showRoundController
                                                .animalTime[0],
                                            info_3: _showRoundController
                                                .animalRoom[0],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 700.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                        FadeInLeft(
                                          delay: 800.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 1,
                                            showId: _showRoundController
                                                .anmimalId[1],
                                            info_1: _showRoundController
                                                .animalName[1],
                                            info_2: _showRoundController
                                                .animalTime[1],
                                            info_3: _showRoundController
                                                .animalRoom[1],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 900.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                        FadeInLeft(
                                          delay: 1000.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 2,
                                            showId: _showRoundController
                                                .anmimalId[2],
                                            info_1: _showRoundController
                                                .animalName[2],
                                            info_2: _showRoundController
                                                .animalTime[2],
                                            info_3: _showRoundController
                                                .animalRoom[2],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 1100.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                      ],
                                      if (_showRoundController.roundValue ==
                                          'Round 2') ...[
                                        FadeInLeft(
                                          delay: 600.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 0,
                                            showId: _showRoundController
                                                .anmimalId[3],
                                            info_1: _showRoundController
                                                .animalName[0],
                                            info_2: _showRoundController
                                                .animalTime[0],
                                            info_3: _showRoundController
                                                .animalRoom[0],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 700.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                        FadeInLeft(
                                          delay: 800.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 1,
                                            showId: _showRoundController
                                                .anmimalId[4],
                                            info_1: _showRoundController
                                                .animalName[1],
                                            info_2: _showRoundController
                                                .animalTime[1],
                                            info_3: _showRoundController
                                                .animalRoom[1],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 900.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                        FadeInLeft(
                                          delay: 1000.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 2,
                                            showId: _showRoundController
                                                .anmimalId[5],
                                            info_1: _showRoundController
                                                .animalName[2],
                                            info_2: _showRoundController
                                                .animalTime[2],
                                            info_3: _showRoundController
                                                .animalRoom[2],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 1100.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                      ],
                                      if (_showRoundController.roundValue ==
                                          'Round 3') ...[
                                        FadeInLeft(
                                          delay: 600.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 0,
                                            showId: _showRoundController
                                                        .anmimalId.length ==
                                                    6
                                                ? _showRoundController
                                                    .anmimalId[3]
                                                : _showRoundController
                                                    .anmimalId[6],
                                            info_1: _showRoundController
                                                .animalName[0],
                                            info_2: _showRoundController
                                                .animalTime[0],
                                            info_3: _showRoundController
                                                .animalRoom[0],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 700.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                        FadeInLeft(
                                          delay: 800.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 1,
                                            showId: _showRoundController
                                                        .anmimalId.length ==
                                                    6
                                                ? _showRoundController
                                                    .anmimalId[4]
                                                : _showRoundController
                                                    .anmimalId[7],
                                            info_1: _showRoundController
                                                .animalName[1],
                                            info_2: _showRoundController
                                                .animalTime[1],
                                            info_3: _showRoundController
                                                .animalRoom[1],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 900.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                        FadeInLeft(
                                          delay: 1000.milliseconds,
                                          child: _buildInfo(
                                            controller: _showRoundController,
                                            id: 2,
                                            showId: _showRoundController
                                                        .anmimalId.length ==
                                                    6
                                                ? _showRoundController
                                                    .anmimalId[5]
                                                : _showRoundController
                                                    .anmimalId[8],
                                            info_1: _showRoundController
                                                .animalName[2],
                                            info_2: _showRoundController
                                                .animalTime[2],
                                            info_3: _showRoundController
                                                .animalRoom[2],
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: 1100.milliseconds,
                                          child: _customDivinder(),
                                        ),
                                      ],
                                      GestureDetector(
                                        onTap: () {
                                          box.remove('reservedSeats');
                                        },
                                        child: FadeInUp(
                                          delay: 1200.milliseconds,
                                          child: Text(
                                            'Total: ${_showRoundController.totalPrice} Baht',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
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
                        ),
                      );
                    }),
              ),
              Positioned(
                top: 530.h,
                child: FadeInDown(
                  delay: 1400.milliseconds,
                  child: PainterScreenMovie(),
                ),
              ),
              Positioned(
                bottom: -10,
                child: Container(
                  width: w,
                  height: 400.h,
                  // decoration: BoxDecoration(border: Border.all()),
                  child: Scrollbar(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _showRoundController.checkBox_1 == false &&
                              _showRoundController.checkBox_2 == false &&
                              _showRoundController.checkBox_3 == false
                          ? Container()
                          : GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 30,
                              ),
                              itemCount: _showRoundController.seatsList.length,
                              itemBuilder: (context, index) {
                                final seat =
                                    _showRoundController.seatsList[index];
                                // final reservedSeats = box.read('reservedSeats') ?? [];

                                List allseatReserve = _showRoundController
                                    .reserveSeatList
                                    .map((e) => e['seatData'])
                                    .toList();

                                if (allseatReserve
                                    .any((element) => element == index)) {
                                  // ถ้าตำแหน่งนี้ถูกจองแล้ว
                                  seatColor = Colors.blue;
                                } else if (seat.isReserved) {
                                  // ถ้าตำแหน่งนี้กำลังถูกจองอยู่
                                  seatColor = Colors.red;
                                } else {
                                  // ถ้าตำแหน่งนี้ว่าง
                                  seatColor = Colors.white;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    var value = box.read('reservedSeats');
                                    bool isAlready = false;

                                    if (value != null) {
                                      (value as List)
                                          .forEachIndexed((i, element) {
                                        var roundElement = element['Round'];
                                        var showIdElement = element['showId'];
                                        var seatNum = element['seatData'];

                                        if (index == seatNum &&
                                            _showRoundController.roundValue ==
                                                roundElement &&
                                            _showRoundController.showIdValue ==
                                                showIdElement) {
                                          isAlready = true;
                                        }
                                      });
                                    }

                                    if (isAlready == false) {
                                      _showRoundController.reserveSeat(index,
                                          _showRoundController.showIdValue);
                                    }
                                  },
                                  child: FadeInUp(
                                    delay: Duration(
                                      milliseconds: 300 + (index * 100),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: seatColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _customDivinder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: w,
        height: 3,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildInfo(
      {required ShowRoundController controller,
      required String info_1,
      required String info_2,
      required String info_3,
      required String showId,
      required int id}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info_1,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              info_2,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              info_3,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        Checkbox(
          value: id == 0
              ? controller.checkBox_1
              : id == 1
                  ? controller.checkBox_2
                  : controller.checkBox_3,
          onChanged: (value) {
            var result = 0;
            var price = 0;

            if (id == 0) {
              controller.checkBox_1 = value as bool;

              print(showId);

              if (controller.checkBox_1 == true) {
                controller.checkBox_2 = false;
                controller.checkBox_3 = false;

                var idShow;

                for (var roundName in round.keys) {
                  var roundData = round[roundName];

                  if (roundData!['id'] == showId) {
                    final numSeats = room[roundData['Room']]!['seats']!;
                    final numPrice = room[roundData['Room']]!['baht']!;
                    result = numSeats;
                    price = numPrice;
                    idShow = roundData["id"];
                  }
                }

                controller.chooseShow(
                    number: result, price: price, showId: showId);
              } else {
                controller.chooseShow(number: 0, price: 0);
              }
            } else if (id == 1) {
              controller.checkBox_2 = value as bool;
              print(showId);
              if (controller.checkBox_2 == true) {
                controller.checkBox_1 = false;
                controller.checkBox_3 = false;

                var idShow;

                for (var roundName in round.keys) {
                  var roundData = round[roundName];

                  if (roundData!['id'] == showId) {
                    final numSeats = room[roundData['Room']]!['seats']!;
                    final numPrice = room[roundData['Room']]!['baht']!;
                    result = numSeats;
                    price = numPrice;
                    idShow = roundData["id"];
                  }
                }
                controller.chooseShow(
                    number: result, price: price, showId: showId);
              } else {
                controller.chooseShow(number: 0, price: 0);
              }
            } else {
              controller.checkBox_3 = value as bool;
              print(showId);
              if (controller.checkBox_3 == true) {
                controller.checkBox_2 = false;
                controller.checkBox_1 = false;

                var idShow;

                for (var roundName in round.keys) {
                  var roundData = round[roundName];

                  if (roundData!['id'] == showId) {
                    final numSeats = room[roundData['Room']]!['seats']!;
                    final numPrice = room[roundData['Room']]!['baht']!;
                    result = numSeats;
                    price = numPrice;
                    idShow = roundData["id"];
                  }
                }

                controller.chooseShow(
                    number: result, price: price, showId: showId);
              } else {
                controller.chooseShow(number: 0, price: 0);
              }
            }

            controller.onCheck();
          },
        )
      ],
    );
  }
}
