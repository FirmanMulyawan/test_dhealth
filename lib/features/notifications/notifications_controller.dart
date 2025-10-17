import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../component/database/database.dart';
import '../../component/model/notification_model.dart';

class NotificationController extends GetxController {
  // database notification
  DatabaseManager database = DatabaseManager.instance;
  final notifications = <NotificationModel>[].obs;

  NotificationController();

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> addNotification(String title, String body) async {
    Database db = await database.db;

    await db.insert("notification", {
      "title": title,
      "body": body,
      "date": DateTime.now().toIso8601String(),
    });

    await loadNotifications();
  }

  Future<void> loadNotifications() async {
    Database db = await database.db;
    List<Map<String, dynamic>> data =
        await db.query('notification', orderBy: 'id DESC');

    // convert from Map to NotificationModel
    final list = data.map((e) => NotificationModel.fromMap(e)).toList();

    notifications.assignAll(list);
  }

  void deleteNotification(int id) async {
    Database db = await database.db;
    await db.delete("notification", where: "id = $id");
    Get.snackbar("Success", "Succes delete Notification id = $id",
        colorText: Colors.white);
    await loadNotifications();
  }

  Future<void> clearNotifications() async {
    Database db = await database.db;
    await db.delete('notification');
  }
}
