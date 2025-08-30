import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String type;
  final String category;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });
}

class WalletController extends GetxController {
  // Bottom navigation index
  var currentIndex = 3.obs;

  // Transaction filter
  var selectedFilter = 'All'.obs;

  // Dummy transactions
  final allTransactions = <Transaction>[
    Transaction(
      title: 'Funds Added',
      subtitle: 'From Bank Account',
      amount: '+\$250.00',
      date: 'Oct 30, 2023',
      type: 'deposit',
      category: 'funds',
    ),
    Transaction(
      title: 'Withdrawal',
      subtitle: 'To Bank Account',
      amount: '-\$50.00',
      date: 'Oct 30, 2023',
      type: 'withdrawal',
      category: 'funds',
    ),
    Transaction(
      title: 'Call with @user123',
      subtitle: 'Earning',
      amount: '+\$25.00',
      date: 'Oct 30, 2023',
      type: 'earning',
      category: 'calls',
    ),
    Transaction(
      title: 'Message from @sarah',
      subtitle: 'Content Purchase',
      amount: '+\$15.00',
      date: 'Oct 29, 2023',
      type: 'earning',
      category: 'messages',
    ),
    Transaction(
      title: 'Content Sale',
      subtitle: 'Photo sold to @mike',
      amount: '+\$35.00',
      date: 'Oct 29, 2023',
      type: 'earning',
      category: 'content',
    ),
  ].obs;

  // Computed filtered list
  List<Transaction> get filteredTransactions {
    if (selectedFilter.value == 'All') return allTransactions;
    return allTransactions
        .where((t) => t.category.toLowerCase() == selectedFilter.value.toLowerCase())
        .toList();
  }

  void updateFilter(String filter) {
    selectedFilter.value = filter;
  }
}
