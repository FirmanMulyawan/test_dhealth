import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Absensi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang, ${controller.username.value}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.currentTime.value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )),
            const SizedBox(height: 24),

            // Tombol absen
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.addAbsensi("Absen Masuk"),
                    child: const Text("Absen Masuk"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.addAbsensi("Absen Pulang"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: const Text("Absen Pulang"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Riwayat Absensi:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: Obx(() {
                if (controller.absensiList.isEmpty) {
                  return const Center(child: Text('Belum ada data absen.'));
                }
                return ListView.builder(
                  itemCount: controller.absensiList.length,
                  itemBuilder: (context, index) {
                    final item = controller.absensiList[index];
                    return Card(
                      child: ListTile(
                        title: Text('${item['type']} - ${item['time']}'),
                        subtitle: Text(
                            '${item['date']} | Lokasi: (${item['lat'].toStringAsFixed(4)}, ${item['lng'].toStringAsFixed(4)})'),
                        leading: Icon(
                          item['type'] == 'Absen Masuk'
                              ? Icons.login
                              : Icons.logout,
                          color: item['type'] == 'Absen Masuk'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
