import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

import '../Storage/Credentials.dart';
import 'ScheduleController.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';

class HomeNewController extends GetxController {
  // User info (reactive from AuthService)
  var userName = "".obs;
  var userUrl = "".obs;
  var avatarUrl = "".obs;

  // Earnings (example placeholders, can come from API later)
  var totalEarnings = 7500.obs;
  var earningsGrowth = "+15% vs last month".obs;

  // KPIs
  var kpiEarnings = "\$310".obs;
  var kpiEarningsChange = "+5%".obs;

  var kpiFans = "6376".obs;
  var kpiFansChange = "+150".obs;

  var kpiEngagement = "20%".obs;
  var kpiEngagementChange = "-2%".obs;

  // On init, fetch user from AuthService
  @override
  void onInit() {
    super.onInit();

    final auth = AuthService.to;
    userName.value = auth.username ?? "Guest";
    userUrl.value = "influbee.io/${auth.username ?? 'guest'}";
    avatarUrl.value = auth.avatarUrl ?? "";
  }

  // Quick Actions
  void onUpload() {
    print("Upload tapped");
  }

  void onProfile() {
    print("Profile tapped");
  }

  // Bottom navigation
  var selectedIndex = 0.obs;

  void onBooking(BuildContext context) {
    final scheduleController = Get.put(ScheduleController());
    scheduleController.pickDate(context);
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}

