import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

import 'ScheduleController.dart';

class HomeNewController extends GetxController {
  // User info
  var userName = "Honey Bee".obs;
  var userUrl = "influbee.io/honeybee".obs;

  // Earnings
  var totalEarnings = 7500.obs;
  var earningsGrowth = "+15% vs last month".obs;

  // KPIs
  var kpiEarnings = "\$310".obs;
  var kpiEarningsChange = "+5%".obs;

  var kpiFans = "6376".obs;
  var kpiFansChange = "+150".obs;

  var kpiEngagement = "20%".obs;
  var kpiEngagementChange = "-2%".obs;

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

