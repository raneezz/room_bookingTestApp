import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/date_utils.dart';

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
  }

  int get totalGuests => adults.value + kids.value;

  int get nights => DateUtils.nightsBetween(checkIn.value, checkOut.value);

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

  void validateCapacity() {}
}
