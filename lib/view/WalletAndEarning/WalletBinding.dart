import 'package:get/get.dart';
import '../../controller/Home_Controller.dart';
import '../../controller/wallet_controller.dart';

class Walletbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>WalletController());
  }
}
