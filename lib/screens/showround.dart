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

class RoundScreen extends StatelessWidget {
  // const RoundScreen({super.key});

  ShowRoundController _showRoundController = Get.put(ShowRoundController());
  final box = GetStorage();
  Color seatColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowRoundController>(builder: (_) {
      return Scaffold(
        floatingActionButton: _showRoundController.totalPrice != 0
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
                                  color:
                                      _showRoundController.selectRound == index
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
              Positioned(
                top: 180.h,
                child: GetBuilder<ShowRoundController>(
                    id: 'checkBox',
                    builder: (_) {
                      return Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfo(
                                      controller: _showRoundController,
                                      id: 0,
                                      info_1:
                                          _showRoundController.animalName[0],
                                      info_2:
                                          _showRoundController.animalTime[0],
                                      info_3:
                                          _showRoundController.animalRoom[0],
                                    ),
                                    _customDivinder(),
                                    _buildInfo(
                                      controller: _showRoundController,
                                      id: 1,
                                      info_1:
                                          _showRoundController.animalName[1],
                                      info_2:
                                          _showRoundController.animalTime[1],
                                      info_3:
                                          _showRoundController.animalRoom[1],
                                    ),
                                    _customDivinder(),
                                    _buildInfo(
                                      controller: _showRoundController,
                                      id: 2,
                                      info_1:
                                          _showRoundController.animalName[2],
                                      info_2:
                                          _showRoundController.animalTime[2],
                                      info_3:
                                          _showRoundController.animalRoom[2],
                                    ),
                                    _customDivinder(),
                                    GestureDetector(
                                      onTap: () {
                                        box.remove('reservedSeats');
                                      },
                                      child: Text(
                                        'Total: ${_showRoundController.totalPrice} Baht',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
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
                    }),
              ),
              Positioned(
                top: 530.h,
                child: PainterScreenMovie(),
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
                      child: GridView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 30,
                        ),
                        itemCount: _showRoundController.seatsList.length,
                        itemBuilder: (context, index) {
                          final seat = _showRoundController.seatsList[index];
                          final reservedSeats =
                              box.read('reservedSeats')?.cast<int>() ?? [];
                          if (_showRoundController.reserveSeatList
                              .contains(seat.id)) {
                            // ถ้าตำแหน่งนี้ถูกจองแล้ว
                            seatColor = Colors.blue;
                          } else if (reservedSeats.contains(
                              _showRoundController.seatsList[index].id)) {
                            // ถ้าตำแหน่งนี้กำลังถูกจองอยู่
                            seatColor = Colors.red;
                          } else {
                            // ถ้าตำแหน่งนี้ว่าง
                            seatColor = Colors.white;
                          }

                          return GestureDetector(
                            onTap: () {
                              _showRoundController.reserveSeat(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: seatColor,
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

              if (controller.checkBox_1 == true) {
                controller.checkBox_2 = false;
                controller.checkBox_3 = false;
                var name = 'Tiger';
                for (var roundName in round.keys) {
                  var roundData = round[roundName];
                  if (roundData!['Animal'] == name) {
                    final numSeats = room[roundData['Room']]!['seats']!;
                    final numPrice = room[roundData['Room']]!['baht']!;
                    result = numSeats;
                    price = numPrice;
                  }
                }

                controller.chooseShow(number: result, price: price);
              } else {
                controller.chooseShow(number: 0, price: 0);
              }
              print(price);
              print(result);
            } else if (id == 1) {
              controller.checkBox_2 = value as bool;
              if (controller.checkBox_2 == true) {
                controller.checkBox_1 = false;
                controller.checkBox_3 = false;

                var name = 'Monkey';
                for (var roundName in round.keys) {
                  var roundData = round[roundName];
                  if (roundData!['Animal'] == name) {
                    final numSeats = room[roundData['Room']]!['seats']!;
                    final numPrice = room[roundData['Room']]!['baht']!;
                    result = numSeats;
                    price = numPrice;
                  }
                }

                controller.chooseShow(number: result, price: price);
              } else {
                controller.chooseShow(number: 0, price: 0);
              }
            } else {
              controller.checkBox_3 = value as bool;

              if (controller.checkBox_3 == true) {
                controller.checkBox_2 = false;
                controller.checkBox_1 = false;

                var name = 'Dolphin';
                for (var roundName in round.keys) {
                  var roundData = round[roundName];
                  if (roundData!['Animal'] == name) {
                    final numSeats = room[roundData['Room']]!['seats']!;
                    final numPrice = room[roundData['Room']]!['baht']!;
                    result = numSeats;
                    price = numPrice;
                  }
                }

                controller.chooseShow(number: result, price: price);

                // final reservedSeats =
                //     box.read('reservedSeats')?.cast<int>() ?? [];

                // controller.seatsList.forEach((element) {
                //   if (element.isReserved) {
                //     print('เจอ');
                //     // ถ้าตำแหน่งนี้กำลังถูกจองอยู่
                //     seatColor = Colors.red;
                //   } else {
                //     print('ไม่ทำงาน');
                //   }
                // });
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
