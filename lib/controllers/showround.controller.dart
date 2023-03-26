import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/models/round.model.dart';
import 'package:liongate_workshop/models/seats.model.dart';

class ShowRoundController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;
  final box = GetStorage();
  double circleOffset = 0.0;

  String roundValue = '';

  int selectRound = 0;

  List roundCategory = ['Round 1', 'Round 2', 'Round 3'];
  List animalName = [];
  List animalTime = [];
  List animalRoom = [];
  List reserveSeatList = [];

  late RxList seatsList;

  List time = [];

  int selectedTime = 0;
  int priceSeat = 0;

  bool checkBox_1 = false;
  bool checkBox_2 = false;
  bool checkBox_3 = false;

  // ShowRoundController(int numSeats, int price) {
  //   seatsList =
  //       List.generate(20, (index) => Seat(id: index, isReserved: false)).obs;

  //   // priceSeat = price;
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..forward()
      ..addListener(circlelistener);

    onSelectRound();

    seatsList =
        List.generate(0, (index) => Seat(id: index, isReserved: false)).obs;
  }

  circlelistener() {
    circleOffset = animationController.value;
    // print(circleOffset);
    update();
  }

  clearList() {
    animalName.clear();
    animalTime.clear();
    animalRoom.clear();
  }

  onCheck() {
    update(['checkBox']);
  }

  onSelectRound({int index = 0, String roundSelect = 'Round 1'}) {
    clearList();
    selectRound = index;
    print(roundSelect);
    roundValue = roundSelect;
    for (var roundName in round.keys) {
      if (roundName.contains(roundSelect)) {
        print(round[roundName]);
        animalName.add(round[roundName]!['Animal']);
        animalTime.add(round[roundName]!['Time']);
        animalRoom.add(round[roundName]!['Room']);
      }
    }

    update();
  }

  void chooseRound({required String animal}) {
    time.clear();
    for (var roundName in round.keys) {
      var roundData = round[roundName];
      if (roundData!['Animal'] == animal) {
        time.add(roundData['Time']);
      }
    }
    update();
  }

  void chooseShow({required int number, required int price}) {
    reserveSeatList.clear();
    seatsList =
        List.generate(number, (index) => Seat(id: index, isReserved: false))
            .obs;

    priceSeat = price;
    update();
  }

  void reserveSeat(int seatId) {
    final seat = seatsList[seatId];
    seat.toggleReservation();
    seatsList[seatId] = seat;

    final reservedSeats = box.read('reservedSeats')?.cast<int>() ?? [];

    if (reservedSeats.contains(seatsList[seatId].id)) {
      print('ตำแหน่งนี้ถูกจองแล้ว');
      return;
    } else if (seatsList[seatId].isReserved) {
      reserveSeatList.add(seatsList[seatId].id);
      print(
          'จองตำแหน่ง ${seatsList[seatId].id} สถานะ ${seatsList[seatId].isReserved}');
    } else {
      print('ลบตำแหน่ง ${seatsList[seatId].id} ออก');
      reserveSeatList.removeLast();
    }
    update();
  }

  int get totalPrice {
    return seatsList.fold<int>(
        0, (total, seat) => seat.isReserved ? total + priceSeat : total);
  }

  onSelectedTime({int index = 0}) {
    selectedTime = index;
    update();
  }
}
