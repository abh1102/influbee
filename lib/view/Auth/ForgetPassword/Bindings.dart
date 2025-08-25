import 'package:get/get.dart';

import '../../../controller/ForgetPasswordController.dart';

class ForgetBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(ForgotPasswordController());

  }
}