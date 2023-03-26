import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:liongate_workshop/models/animal.model.dart';
import 'package:liongate_workshop/models/round.model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  List animalCategory = ['All'];
  
  List<Animal> filterAnimal = [];


  int selectedCategory = 0;


  String role = 'USER';

  late AnimationController animationController;

  double circleOffset = 0.0;

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

    animal.forEach((element) {
      animalCategory.add(element.type);
    });
    filterAnimal = List.from(animal);

  }

  circlelistener() {
    circleOffset = animationController.value;
    // print(circleOffset);
    update();
  }

  selectRole(){
  
  }

  onSelected({required int index, required String typeSelect}) {
    filterAnimal.clear();
    print(typeSelect);
    selectedCategory = index;
    switch (selectedCategory) {
      case 0:
        filterAnimal = List.from(animal);
        break;
      case 1:
        filterAnimal =
            animal.where((element) => element.type == typeSelect).toList();
        break;
      case 2:
        filterAnimal =
            animal.where((element) => element.type == typeSelect).toList();
        break;
      case 3:
        filterAnimal =
            animal.where((element) => element.type == typeSelect).toList();
        break;
      default:
    }
    update();
  }



  
}
