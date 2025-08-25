import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../controller/Pin_Controller.dart';

class setpin extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PinController>(() => PinController());
  }
}