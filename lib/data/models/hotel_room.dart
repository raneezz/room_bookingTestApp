class HotelRoom {
  final String code, type, subtitle, imageAsset;
  final int pricePerNight, maxGuests;
  final String? badge;

  const HotelRoom({
    required this.code,
    required this.type,
    required this.pricePerNight,
    required this.maxGuests,
    required this.subtitle,
    required this.imageAsset,
    this.badge,
  });
}
