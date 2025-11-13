import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../component/util/permisssion.dart';

class DashboardController extends GetxController {
  var username = ''.obs;
  var currentTime = ''.obs;
  var absensiList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    username.value = Get.arguments ?? 'User';
    requestLocationPermission();
    updateTime();
    loadAbsensi();
    _startClock();
  }

  void _startClock() {
    Future.doWhile(() async {
      updateTime();
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  void updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('EEEE, dd MMM yyyy HH:mm:ss').format(now);
  }

  Future<void> loadAbsensi() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('absensiList');
    if (data != null) {
      absensiList.value = List<Map<String, dynamic>>.from(json.decode(data));
    }
  }

  Future<void> _saveAbsensi() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('absensiList', json.encode(absensiList));
  }

  Future<void> addAbsensi(String type) async {
    try {
      final now = DateTime.now();
      final today = DateFormat('dd-MM-yyyy').format(now);

      // 🔍 Validasi: cek apakah user sudah absen dengan tipe yang sama hari ini
      bool alreadyAbsenToday = absensiList
          .any((item) => item['type'] == type && item['date'] == today);

      if (alreadyAbsenToday) {
        Get.snackbar('Peringatan', 'Anda sudah melakukan $type hari ini!');
        return;
      }

      // ✅ Ambil lokasi jika belum absen
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final newData = {
        'type': type,
        'time': DateFormat('HH:mm:ss').format(now),
        'date': today,
        'lat': position.latitude,
        'lng': position.longitude,
      };

      absensiList.insert(0, newData);
      await _saveAbsensi();

      Get.snackbar('Berhasil', '$type dicatat!');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mendapatkan lokasi: $e');
    }
  }
}
