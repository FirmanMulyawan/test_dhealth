import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

Future<void> requestLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Cek apakah GPS aktif
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Get.snackbar('Error', 'Layanan lokasi tidak aktif');
    return;
  }

  // Cek izin lokasi
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar('Error', 'Izin lokasi ditolak oleh pengguna');
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Get.snackbar('Error',
        'Izin lokasi ditolak permanen. Silakan aktifkan di Pengaturan > Privasi > Lokasi');
    return;
  }

  // Kalau sampai sini, izin diberikan ✅
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  Get.snackbar('Lokasi Berhasil',
      'Lat: ${position.latitude}, Lng: ${position.longitude}');
}
