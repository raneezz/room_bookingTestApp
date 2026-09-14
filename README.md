# Room Booking App

A Flutter hotel room booking app built with GetX. It supports date selection, room selection, guest counts, availability validation, booking conflict detection, and reservation confirmation.

## How to run

### Requirements
- Flutter SDK installed and configured
- Dart SDK (included with Flutter)
- Android Studio /VS CODE- Android SDK or Xcode for the target platform

### Steps

1. Extract the project.
2. Open the project folder in Android Studio, VS Code, or another Flutter-compatible IDE.
3. Run:



The app uses local mock data, so no API key, backend, or database setup is required.

## Stack / Framework

- **Flutter** - UI and application framework
- **Dart** - programming language
- **GetX** - state management and dependency injection
- **Material Design** - UI components and theming
- **Local mock data** - sample rooms and existing bookings for the assignment

## Project architecture

The project uses a feature-based, multi-file structure:

```text
lib/
├── app/
├── core/
├── data/
│   ├── models/
│   ├── mock/
│   └── repositories/
└── features/
    └── booking/
        ├── controllers/
        ├── pages/
        └── widgets/
```

`BookingController` handles booking state and validation, while models, repository/mock data, and UI widgets are separated into their own files.

## Booking behavior

- Check-in cannot be in the past.
- Check-out must be after check-in.
- Rooms with overlapping existing bookings cannot be selected.
- The calculation view appears only after a room is selected.
- Total price is calculated as `number of nights × price per night`.
- After confirming a reservation, the selected room is added to the in-memory bookings and becomes unavailable for overlapping dates.


