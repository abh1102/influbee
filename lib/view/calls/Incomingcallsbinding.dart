import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../controller/CallController.dart';
import '../../controller/VoiceController.dart';

class Incomingcalls extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CallController>(() =>CallController());
  }
}