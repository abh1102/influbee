import 'dart:io';
import 'package:get/get.dart';

class PayoutController extends GetxController {
  // Step tracking
  var currentStep = 1.obs;

  // Aadhar
  var aadharNumber = "".obs;
  var aadharFront = Rx<File?>(null);   // ✅ reactive
  var aadharBack = Rx<File?>(null);    // ✅ reactive

  // PAN
  var panNumber = "".obs;
  var panFile = Rx<File?>(null);       // ✅ reactive

  // Bank
  var accountNumber = "".obs;
  var ifscCode = "".obs;
  var bankName = "".obs;

  void setAadhar(String number) => aadharNumber.value = number;
  void setAadharFront(File file) => aadharFront.value = file;
  void setAadharBack(File file) => aadharBack.value = file;
  void setPan(String number) => panNumber.value = number;
  void setPanFile(File file) => panFile.value = file;
  void setBankDetails(String account, String ifsc, String bank) {
    accountNumber.value = account;
    ifscCode.value = ifsc;
    bankName.value = bank;
  }
}
