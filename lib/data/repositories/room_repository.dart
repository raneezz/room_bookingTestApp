import '../mock/mock_bookings.dart';
import '../mock/mock_rooms.dart';
import '../models/hotel_room.dart';
import '../models/room_booking.dart';
class RoomRepository {
  List<HotelRoom> getRooms()=>MockRooms.rooms;
  List<RoomBooking> getBookings()=>MockBookings.bookings;
}
