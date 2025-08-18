import 'package:get/get.dart';
import '../../controller/Home_Controller.dart';
import '../../controller/TransactionController.dart';
import '../../controller/wallet_controller.dart';

class Transaction extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>TransactionController());
  }
}
