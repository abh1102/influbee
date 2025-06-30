import 'package:get/get.dart';
import '../../controller/Home_Controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
