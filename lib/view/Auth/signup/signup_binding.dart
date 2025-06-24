import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/SignUpController.dart';
class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}