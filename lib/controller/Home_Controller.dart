import 'package:get/get.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var earnings = 2500.obs;
  var newFans = 15.obs;
  var bookings = 3.obs;
  var messages = 5.obs;

  final greeting = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _updateGreeting();
  }

  void _updateGreeting() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    if (hour < 12) {
      greeting.value = 'Good morning';
    } else if (hour < 16 || (hour == 16 && minute <= 30)) {
      greeting.value = 'Good afternoon';
    } else {
      greeting.value = 'Good evening';
    }
  }
}

