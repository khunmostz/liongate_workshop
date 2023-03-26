class Seat {
  late int id;
  late bool isReserved;

  Seat({required this.id, this.isReserved = false});

  void toggleReservation() {
    isReserved = !isReserved;
  }
}
