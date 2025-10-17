import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../component/config/app_style.dart';
import 'notifications_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.black,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => controller.clearNotifications(),
          )
        ],
        title: Text(
          "Notifications",
          style: AppStyle.bold(size: 20, textColor: Colors.white),
        ),
      ),
      body: SafeArea(bottom: false, child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(() {
                  if (controller.notifications.isEmpty) {
                    return const Center(child: Text('Belum ada notifikasi'));
                  }
                  return ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final notif = controller.notifications[index];
                      return ListTile(
                        onTap: () =>
                            controller.deleteNotification(notif.id ?? 0),
                        title: Text(notif.title),
                        subtitle: Text(notif.body),
                        trailing: Text(
                          notif.date.substring(0, 16),
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  );
                }),
              )
            ]));
  }
}
