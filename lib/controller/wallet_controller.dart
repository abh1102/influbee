import 'package:get/get.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var totalEarnings = 0.0.obs;

  // Mock Transactions
  var transactions = <String>[].obs;

  void addFunds(double amount) {
    totalEarnings.value += amount;
    transactions.add("Added \$$amount");
  }

  void withdraw(double amount) {
    if (amount <= totalEarnings.value) {
      totalEarnings.value -= amount;
      transactions.add("Withdrew \$$amount");
    }
  }

  void send(double amount) {
    if (amount <= totalEarnings.value) {
      totalEarnings.value -= amount;
      transactions.add("Sent \$$amount");
    }
  }
}
