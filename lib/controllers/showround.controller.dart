import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/models/round.model.dart';
import 'package:liongate_workshop/models/seats.model.dart';
import 'package:collection/collection.dart';

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
  List anmimalId = [];
  List reserveSeatList = [];

  late RxList seatsList;

  List time = [];

  int selectedTime = 0;
  int priceSeat = 0;
  String showIdValue = '';

  bool checkBox_1 = false;
  bool checkBox_2 = false;
  bool checkBox_3 = false;

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
    checkBox_1 = false;
    checkBox_2 = false;
    checkBox_3 = false;
    update();
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
        // print(round[roundName]);
        animalName.add(round[roundName]!['Animal']);
        animalTime.add(round[roundName]!['Time']);
        animalRoom.add(round[roundName]!['Room']);
        anmimalId.add(round[roundName]!['id']);
        print(round[roundName]!['id']);
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

  void chooseShow(
      {required int number, required int price, String showId = ''}) {
    reserveSeatList.clear();
    // print(showId);
    showIdValue = showId;
    print(roundValue);

    var value = box.read('reservedSeats');

    // print(value);

    seatsList =
        List.generate(number, (index) => Seat(id: index, isReserved: false))
            .obs;

    if (value != null) {
      (value as List).forEachIndexed((index, element) {
        var roundElement = element['Round'];
        var showIdElement = element['showId'];
        var seatNum = element['seatData'];

        seatsList.forEachIndexed((i, e) {
          if (i == seatNum &&
              roundValue == roundElement &&
              showId == showIdElement) {
            e.isReserved = true;
          }
        });
      });
    }

    seatsList.forEachIndexed((index, element) {
      print("=====" * 20);
      print(index);
      print(element.isReserved);
    });

    priceSeat = price;
    update();
  }

  void reserveSeat(int seatId, String showId) {
    final seat = seatsList[seatId];
    seat.toggleReservation();
    seatsList[seatId] = seat;

    final reservedSeats = box.read('reservedSeats') ?? [];

    print(showId);

    if (reservedSeats.contains(seatsList[seatId].id)) {
      print('ตำแหน่งนี้ถูกจองแล้ว');
      return;
    } else if (seatsList[seatId].isReserved) {
      // reserveSeatList.add(seatsList[seatId].id);

      reserveSeatList.add({
        'Round': roundValue,
        'showId': showId,
        'seatData': seatsList[seatId].id
      });

      print(reserveSeatList);

      print(totalPrice);

      // print(
      //     'จองตำแหน่ง ${seatsList[seatId].id} สถานะ ${seatsList[seatId].isReserved}');
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
