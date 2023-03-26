class Animal {
  late String name, species, type, image;
  late Duration showDuration;
  Animal(
      {required this.name,
      required this.species,
      required this.type,
      required this.image,
      required this.showDuration});
}

List<Animal> animal = [
  Animal(
    name: 'Tiger',
    species: 'Bigcat',
    type: 'Carnivore',
    image: 'assets/images/animal_01.jpeg',
    showDuration: Duration(minutes: 10),
  ),
  Animal(
    name: 'Monkey',
    species: 'Chimpanzee',
    type: 'Herbivore',
    image: 'assets/images/animal_02.jpeg',
    showDuration: Duration(minutes: 20),
  ),
  Animal(
    name: 'Dolphin',
    species: 'Odontoceti',
    type: 'Carnivore',
    image: 'assets/images/animal_03.jpeg',
    showDuration: Duration(minutes: 20),
  ),
];
