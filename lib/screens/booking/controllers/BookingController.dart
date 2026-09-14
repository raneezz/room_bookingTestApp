import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/date_utils.dart';
import '../../../data/models/hotel_room.dart';
import '../../../data/models/room_booking.dart';
import '../../../data/repositories/room_repository.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingController>(
          () => BookingController(),
      fenix: true,
    );
  }
}

class BookingController extends GetxController {
  static BookingController get to => Get.put(BookingController());

  BookingController({RoomRepository? repository})
    : _repository = repository ?? RoomRepository();
  final RoomRepository _repository;
  late final List<HotelRoom> rooms;
  late final List<RoomBooking> bookings;
  final checkIn = Rxn<DateTime>(),
      checkOut = Rxn<DateTime>(),
      selectedRoomCode = RxnString();
  final adults = 2.obs,
      kids = 0.obs,
      validationMessage = RxnString(),
      validationIsError = false.obs;

  @override
  void onInit() {
    super.onInit();
    rooms = _repository.getRooms();
    bookings = _repository.getBookings();
  }

  int get totalGuests => adults.value + kids.value;

  int get nights => DateUtils.nightsBetween(checkIn.value, checkOut.value);

  HotelRoom? get selectedRoom {
    final code = selectedRoomCode.value;
    for (final _room in rooms) {
      if (_room.code == code) return _room;
    }
    return null;
  }

  int get subtotal =>
      selectedRoom == null ? 0 : nights * selectedRoom!.pricePerNight;

  bool get datesAreValid {
    final a = checkIn.value, b = checkOut.value;
    if (a == null || b == null) return false;
    return !DateUtils.dateOnly(
          a,
        ).isBefore(DateUtils.dateOnly(DateTime.now())) &&
        b.isAfter(a);
  }

  bool roomFitsGuests(HotelRoom r) => totalGuests <= r.maxGuests;

  bool isRoomBooked(HotelRoom r) {
    final a = checkIn.value, b = checkOut.value;
    if (a == null || b == null || !b.isAfter(a)) return false;
    return bookings.any(
      (x) =>
          x.roomCode == r.code &&
          a.isBefore(x.checkOut) &&
          b.isAfter(x.checkIn),
    );
  }

  void error(String m) {
    validationIsError.value = true;
    validationMessage.value = m;
  }

  void success(String m) {
    validationIsError.value = false;
    validationMessage.value = m;
  }

  void clearMessage() => validationMessage.value = null;

  Future<void> pickCheckIn(BuildContext context) async {
    clearMessage();
    final today = DateUtils.dateOnly(DateTime.now());
    final p = await showDatePicker(
      context: context,
      initialDate: _safeCheckIn(today),
      firstDate: today,
      lastDate: DateTime(today.year + 2, 12, 31),
      helpText: 'SELECT CHECK-IN DATE',
      builder: _pickerTheme,
    );
    if (p == null) return;
    checkIn.value = DateUtils.dateOnly(p);
    if (checkOut.value != null && !checkOut.value!.isAfter(checkIn.value!)) {
      checkOut.value = null;
      selectedRoomCode.value = null;
      error('Please select a check-out date after the new check-in date.');
      return;
    }
    validateDatesAndRoom();
  }

  Future<void> pickCheckOut(BuildContext context) async {
    clearMessage();
    if (checkIn.value == null) {
      error('Please select a check-in date first.');
      return;
    }
    final min = checkIn.value!.add(const Duration(days: 1));
    final p = await showDatePicker(
      context: context,
      initialDate: _safeCheckOut(min),
      firstDate: min,
      lastDate: DateTime(min.year + 2, 12, 31),
      helpText: 'SELECT CHECK-OUT DATE',
      builder: _pickerTheme,
    );
    if (p == null) return;
    checkOut.value = DateUtils.dateOnly(p);
    validateDatesAndRoom();
  }

  DateTime _safeCheckIn(DateTime today) =>
      checkIn.value != null &&
          !DateUtils.dateOnly(checkIn.value!).isBefore(today)
      ? DateUtils.dateOnly(checkIn.value!)
      : today;

  DateTime _safeCheckOut(DateTime min) =>
      checkOut.value != null && checkOut.value!.isAfter(checkIn.value!)
      ? DateUtils.dateOnly(checkOut.value!)
      : min;

  Widget _pickerTheme(BuildContext c, Widget? child) => Theme(
    data: Theme.of(c).copyWith(
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFFFA500),
        onPrimary: Colors.black,
        surface: Color(0xFF121A2A),
        onSurface: Colors.white,
      ),
    ),
    child: child!,
  );

  void selectRoom(HotelRoom r) {
    clearMessage();
    if (!datesAreValid) {
      error(
        'Select valid check-in and check-out dates before choosing a room.',
      );
      return;
    }
    if (isRoomBooked(r)) {
      selectedRoomCode.value = null;
      error('${r.code} is already booked for the selected dates.');
      return;
    }
    if (!roomFitsGuests(r)) {
      selectedRoomCode.value = null;
      error('${r.code} allows a maximum of ${r.maxGuests} guests.');
      return;
    }
    selectedRoomCode.value = r.code;
    success('${r.code} selected. Your stay is available.');
  }

  void incrementAdults() {
    if (adults.value < AppConstants.maxAdultCount) adults.value++;
    validateCapacity();
  }

  void decrementAdults() {
    if (adults.value > 1) adults.value--;
    validateCapacity();
  }

  void incrementKids() {
    if (kids.value < AppConstants.maxKidCount) kids.value++;
    validateCapacity();
  }

  void decrementKids() {
    if (kids.value > 0) kids.value--;
    validateCapacity();
  }

  void validateCapacity() {
    final r = selectedRoom;
    if (r != null && !roomFitsGuests(r)) {
      selectedRoomCode.value = null;
      error(
        'Selected room cannot accommodate $totalGuests guests. Please choose a larger room.',
      );
      return;
    }
    if (datesAreValid) validateDatesAndRoom();
  }

  void validateDatesAndRoom() {
    final a = checkIn.value, b = checkOut.value;
    if (a == null || b == null) {
      selectedRoomCode.value = null;
      clearMessage();
      return;
    }
    if (DateUtils.dateOnly(a).isBefore(DateUtils.dateOnly(DateTime.now()))) {
      selectedRoomCode.value = null;
      error('Check-in date cannot be in the past.');
      return;
    }
    if (!b.isAfter(a)) {
      selectedRoomCode.value = null;
      error('Check-out date must be after check-in date.');
      return;
    }
    final r = selectedRoom;
    if (r != null && isRoomBooked(r)) {
      selectedRoomCode.value = null;
      error('${r.code} is booked for at least one selected night.');
      return;
    }
    if (r != null && !roomFitsGuests(r)) {
      selectedRoomCode.value = null;
      error('${r.code} cannot accommodate $totalGuests guests.');
      return;
    }
    success(
      'Dates verified • $nights ${nights == 1 ? 'night' : 'nights'} available.',
    );
  }

  String formatDate(DateTime? value) {
    return DateUtils.formatDate(value);
  }

  void confirmReservation() {
    if (checkIn.value == null || checkOut.value == null) {
      error('Please select both check-in and check-out dates.');
      return;
    }
    if (!datesAreValid) {
      error(
        'Invalid dates. Check-out must be after check-in and check-in cannot be in the past.',
      );
      return;
    }
    final r = selectedRoom;
    if (r == null) {
      error('Please select one available room.');
      return;
    }
    if (isRoomBooked(r)) {
      selectedRoomCode.value = null;
      error('${r.code} is already booked for the selected dates.');
      return;
    }
    if (!roomFitsGuests(r)) {
      selectedRoomCode.value = null;
      error('The selected room cannot accommodate all guests.');
      return;
    }
    success('Reservation confirmed • ${r.code} • $nights nights • ₹$subtotal');
    Get.snackbar(
      'Reservation Confirmed',
      '${r.type} (${r.code}) • $nights nights • ₹$subtotal',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0B2A25),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
