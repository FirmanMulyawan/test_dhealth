# FLUTTER NEWS APP

Aplikasi **Flutter News** menggunakan **GetX** untuk state management dan dependency injection, dengan fitur:  
- **Beranda Berita**  
- **Pencarian Berita**  
- **Pencarian Berdasarkan Kategori Berita**  
- **Notifikasi**  

Seluruh list berita telah **support pagination**, sehingga data di-load bertahap untuk performa lebih baik.  
Dibangun dengan **Flutter 3.27.4**, mendukung **Firebase Messaging**, dan **SQLite**.

## 📦 DEPENDENCIES

```yaml
dependencies:
  get: ^4.7.2 
dio: ^5.8.0 
flutter_dotenv: ^5.2.1 
skeletonizer: ^1.4.3 
dropdown_button2: ^2.3.9 
sqflite: ^2.3.3+1 
path_provider: ^2.1.5
notification_center: ^1.0.2 
flutter_native_splash: ^2.4.4 
firebase_core: ^4.0.0 
firebase_messaging: ^16.0.0 
flutter_local_notifications: ^17.1.2 

⚙️ FITUR UTAMA
1. HOME NEWS (BERANDA)
Menampilkan daftar berita terbaru dari News API
Endpoint:
GET https://newsapi.org/v2/top-headlines?page=3&pageSize=10&apiKey=<YOUR_API_KEY>

2. SEARCH NEWS (PENCARIAN)
Mencari berita berdasarkan kata kunci dan kategory
Endpoint:
GET https://newsapi.org/v2/everything?q=technology&page=1&pageSize=10&apiKey=<YOUR_API_KEY>

3. Category
mencari berita berdasarkan kategory
https://newsapi.org/v2/top-headlines?category=technology&page=3&pageSize=10&apiKey

4. NOTIFIKASI
- Mendapatkan push notification via Firebase Cloud Messaging
- Menyimpan notifikasi ke SQLite lokal
- Menampilkan riwayat notifikasi di layar menggunakan GetX dan dapat menghapusnya

4. UI SKELETON
- Loading skeleton menggunakan skeletonizer
- Dropdown kustom dengan dropdown_button2
- Splash screen via flutter_native_splash
- Penyesuaian icon Aplikasi

🔧 SETUP & KONFIGURASI
1. CLONE REPOSITORY
git clone <YOUR_REPO_URL>
cd flutter_news_app

2. INSTALL DEPENDENCIES
flutter pub get
3. TAMBAHKAN API KEY
Buat file .env di root project
NEWS_API_KEY=your_api_key_here

4. FIREBASE SETUP
Tambahkan google-services.json (Android)

5. DATABASE SQLITE
Database otomatis dibuat saat aplikasi dijalankan
Tabel notifikasi disimpan di local storage (sqflite)
Gunakan NotificationController untuk menambah, menghapus dan membaca notifikasi

📱 Link
- Link video push notifications 
https://drive.google.com/file/d/1PRzEUBNHDnQTfG7C6tiLBf87bAFT6cf5/view?usp=sharing

- Link Apk
https://drive.google.com/file/d/1jyAvVSb0wRV4YJyJB00YVTJDWD0DrqIi/view?usp=sharing 

- Link video api news
https://drive.google.com/file/d/1ot5EZh9F15SSvkWTm4OUCgnAorNreqVK/view?usp=sharing


📊 FLOW DIAGRAM GetX + SQLite + FCM
flowchart TD
    A[Firebase Messaging] --> B[NotificationController (GetX)]
    B --> C[SQLite Database]
    C --> D[UI - Notification Screen (Obx)]
    A --> D[Optional Local Notification via flutter_local_notifications]
    E[News API] --> F[NewsController (GetX)]
    F --> G[UI - Home News & Search News (Obx)]

- Firebase Messaging → diterima oleh NotificationController → disimpan ke SQLite → di-observe di UI.
- News API → data diproses oleh NewsController → ditampilkan di UI menggunakan Obx (reactive).