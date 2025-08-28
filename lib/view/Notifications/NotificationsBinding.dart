import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../controller/NotificationsController.dart';

class NotificationsBindings extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(()=>NotificationController());
  }
}