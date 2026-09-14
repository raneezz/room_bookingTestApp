import '../models/room_booking.dart';

class MockBookings {
  static final bookings = <RoomBooking>[
    RoomBooking(
      roomCode: 'R201',
      checkIn: DateTime(2026, 9, 18),
      checkOut:  DateTime(2026, 9, 20),
    ),
     RoomBooking(
      roomCode: 'R102',
      checkIn: DateTime(2026, 9, 20),
      checkOut: DateTime(2026, 9, 23),
    ),
  ];
}
