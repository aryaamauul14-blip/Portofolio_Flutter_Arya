# Aplikasi Portofolio Pribadi

Aplikasi portofolio pribadi berbasis Flutter untuk tugas praktikum Pemrograman Mobile.

## Fitur

- Layout responsif untuk desktop, tablet, dan ponsel
- Hero dengan foto asli, tipografi Manrope / DM Sans, dan tema biru muda
- Navigasi About Me, Porto, dan Contact dengan smooth scrolling
- Filter proyek Web, IoT, dan Game serta ilustrasi konsep untuk setiap proyek
- Halaman detail portfolio dengan transisi `Hero` dan `Navigator.push`
- Tautan email, telepon, GitHub, LinkedIn, dan tombol salin email
- Animasi entrance dan hover/focus yang mengikuti preferensi reduced motion
- Font dan ilustrasi lokal, tanpa layanan gambar eksternal

## Fitur Pengembangan yang Dipakai

- A: Halaman detail portfolio baru
- C: Tema warna biru muda

## Asset

- `assets/Foto Profil Naufal Arya.jpeg`
- `assets/fonts/` — Manrope dan DM Sans, beserta lisensi SIL Open Font License
- `web/icons/brand.svg` — sumber ikon web

Ilustrasi proyek adalah interpretasi visual, bukan screenshot produk.

## Cara Menjalankan

Flutter 3.35.7 (Dart 3.9.2) digunakan untuk pengembangan ini.

```sh
flutter pub get
flutter run
```

Untuk web:

```sh
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

## Pemeriksaan

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web --release --no-web-resources-cdn
```

Hasil build berada di `build/web`. Sajikan direktori tersebut melalui HTTP.
Untuk hosting di subdirektori, tambahkan `--base-href /nama-subdirektori/`
pada perintah build.

## Mengubah konten

Informasi profil, tautan kontak, dan proyek berada di `lib/portfolio_data.dart`.
Warna dan tipografi berada di `lib/portfolio_theme.dart`. Tautan kontak
menggunakan `url_launcher`; jika perangkat tidak dapat membukanya, dialog
menyediakan tautan yang bisa disalin.

## Catatan

- Project ini dibuat untuk dikumpulkan sebagai tugas praktikum.
- Screenshot dan file laporan perlu dimasukkan ke folder pengumpulan sesuai instruksi dosen.
