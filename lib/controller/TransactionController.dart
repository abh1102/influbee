import 'package:get/get.dart';

import '../Model/TransactionsDetails.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  // Tabs
  var selectedMainTab = "All Calls".obs;
  var selectedSubTab = "Audio".obs;

  // Dummy Transactions
  final transactions = <TransactionModel>[
    TransactionModel(userName: "AJ", type: "Audio", amount: 200000, date: "2025-08-13", category: "All Calls"),
    TransactionModel(userName: "Keshav", type: "Video", amount: 50000, date: "2025-08-12", category: "All Calls"),
    TransactionModel(userName: "Vishal", type: "Exclusive", amount: 100000, date: "2025-08-13", category: "All Calls"),
    TransactionModel(userName: "Virat Kohli", type: "Message", amount: 15000, date: "2025-08-14", category: "All Calls"),
    TransactionModel(userName: "Robert Downey Jr.", type: "Audio", amount: 250000, date: "2025-08-21", category: "Scheduled"),
    TransactionModel(userName: "Elizabeth Olsen", type: "Video", amount: 400000, date: "2025-08-16", category: "History"),
  ].obs;

  // Change main tab
  void changeMainTab(String tab) {
    selectedMainTab.value = tab;
  }

  // Change sub tab
  void changeSubTab(String tab) {
    selectedSubTab.value = tab;
  }

  // Get filtered transactions based on selected tabs
  List<TransactionModel> get filteredTransactions {
    List<TransactionModel> filtered;

    if (selectedMainTab.value == "All Calls") {
      filtered = transactions
          .where((tx) => tx.category == "All Calls" && tx.type == selectedSubTab.value)
          .toList();
    } else {
      filtered = transactions
          .where((tx) => tx.category == selectedMainTab.value)
          .toList();
    }

    // ✅ Sort by date (latest first)
    filtered.sort((a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));

    return filtered;
  }
  // Count for main tabs
  int getMainTabCount(String tab) {
    return transactions.where((tx) => tx.category == tab).length;
  }

  // Count for sub tabs
  int getSubTabCount(String tab) {
    return transactions.where((tx) => tx.category == "All Calls" && tx.type == tab).length;
  }
}

//
// class TransactionController extends GetxController {
//   var transactions = <TransactionModel>[].obs;
//   var selectedTab = "All".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadDummyData();
//   }
//
//   void loadDummyData() {
//     transactions.value = [
//       TransactionModel(
//           userName: "AJ", type: "Audio", amount: 2000000, date: "12 Aug 2025"),
//       TransactionModel(
//           userName: "Keshav", type: "Video", amount: 5000000, date: "11 Aug 2025"),
//       TransactionModel(
//           userName: "Vishal", type: "Message", amount: 100000, date: "10 Aug 2025"),
//       TransactionModel(
//           userName: "Virat Kohli", type: "Exclusive", amount: 100000, date: "09 Aug 2025"),
//     ];
//   }
//
//   List<TransactionModel> get filteredTransactions {
//     if (selectedTab.value == "All") return transactions;
//     return transactions.where((t) => t.type == selectedTab.value).toList();
//   }
//
//   void changeTab(String tab) {
//     selectedTab.value = tab;
//   }
// }
