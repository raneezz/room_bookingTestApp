import '../models/hotel_room.dart';

class MockRooms {
  //MockRooms();

  static const rooms = <HotelRoom>[
    HotelRoom(
      code: 'R101',
      type: 'Deluxe Room',
      pricePerNight: 3500,
      maxGuests: 2,
      subtitle: 'Balcony view & King Bed',
      imageAsset: 'assets/rooms/deluxe.png',
    ),
    HotelRoom(
      code: 'R102',
      type: 'Deluxe Room',
      pricePerNight: 3500,
      maxGuests: 2,
      subtitle: 'Garden view & Work Desk',
      imageAsset: 'assets/rooms/deluxe.png',
    ),
    HotelRoom(
      code: 'R201',
      type: 'Executive Suite',
      pricePerNight: 5800,
      maxGuests: 3,
      subtitle: 'Living room lounge & Bathtub',
      imageAsset: 'assets/rooms/executive.png',
      badge: 'LUXE',
    ),
    HotelRoom(
      code: 'R202',
      type: 'Executive Suite',
      pricePerNight: 5800,
      maxGuests: 3,
      subtitle: 'High Floor Skyline Panorama',
      imageAsset: 'assets/rooms/executive.png',
    ),
    HotelRoom(
      code: 'R301',
      type: 'Family Room',
      pricePerNight: 4200,
      maxGuests: 4,
      subtitle: '2 Queen Beds & Dining Area',
      imageAsset: 'assets/rooms/family.png',
      badge: 'SPACIOUS',
    ),
    HotelRoom(
      code: 'R302',
      type: 'Family Room1',
      pricePerNight: 4400,
      maxGuests: 5,
      subtitle: '3 Queen Beds & Dining Area',
      imageAsset: 'assets/rooms/family.png',

    ),
    HotelRoom(
      code: 'R303',
      type: 'Family Room2',
      pricePerNight: 4400,
      maxGuests: 6,
      subtitle: '3 Queen Beds & Dining Area',
      imageAsset: 'assets/rooms/deluxe.png',

    ),
    HotelRoom(
      code: 'R304',
      type: 'Family Room3',
      pricePerNight: 4502,
      maxGuests: 8,
      subtitle: '4 Queen Beds & Dining Area',
      imageAsset: 'assets/rooms/family.png',

    ),

  ];
}
