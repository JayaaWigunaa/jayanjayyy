#  Jay TopUp

> Aplikasi top up game mobile berbasis Flutter dengan desain dark gaming aesthetic.  
> Mendukung Mobile Legends, Free Fire, PUBG Mobile, Genshin Impact, Valorant, dan Honor of Kings.

---

## 📱 Preview Screens

| Login | Dashboard | Pilih Game |
|-------|-----------|------------|
| Form login dengan animasi fade | Saldo, menu cepat, grid game | 6 game tersedia |

| Top Up | Order | Sukses |
|--------|-------|--------|
| Pilih nominal dengan badge HOT/BONUS | Konfirmasi + metode bayar | Halaman sukses animasi |

---

## ✨ Fitur

- 🔐 **Login & Lupa Password** — validasi input, loading state, animasi fade
- 🏠 **Dashboard** — kartu saldo, menu cepat, grid game, riwayat transaksi terakhir
- 🎮 **Top Up Game** — input ID game, grid nominal (dilengkapi badge HOT & BONUS)
- 🛒 **Order & Pembayaran** — konfirmasi order, pilih metode (Dana, OVO, GoPay, Transfer Bank)
- ✅ **Halaman Sukses** — ringkasan transaksi setelah pembayaran
- 📋 **Riwayat Transaksi** — filter berdasarkan status (Semua / Sukses / Gagal)
- 🎁 **Promo & Diskon** — daftar promo dengan tombol klaim
- 🎧 **Support** — FAQ accordion, form kirim pesan, tombol WhatsApp/Email/Telegram
- 👤 **Profil** — statistik user, menu pengaturan, logout

---

## 🎮 Data Game (Dummy)

| Game | Jumlah Paket | Range Harga | Foto |
|------|-------------|-------------|------|
| Mobile Legends | 20 paket | Rp 3.000 – Rp 1.210.000 | ✅ |
| Free Fire | 13 paket | Rp 1.000 – Rp 322.000 | ✅ |
| PUBG Mobile | 7 paket | Rp 12.000 – Rp 1.350.000 | ❌ (icon) |
| Genshin Impact | 6 paket | Rp 14.000 – Rp 1.500.000 | ✅ |
| Valorant | 6 paket | Rp 38.000 – Rp 775.000 | ❌ (icon) |
| Honor of Kings | 6 paket | Rp 7.500 – Rp 275.000 | ❌ (icon) |

> Gambar game disimpan dalam format **base64** langsung di dalam kode — tidak perlu setup folder `assets/`.

---

## 🚀 Cara Menjalankan

### Prasyarat

- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`
- Android Studio / VS Code dengan Flutter extension

### Langkah

```bash
# 1. Buat project Flutter baru
flutter create jay_topup
cd jay_topup

# 2. Replace file main
cp main.dart lib/main.dart

# 3. Jalankan aplikasi
flutter run
```

> ⚠️ Tidak perlu menambahkan apapun di `pubspec.yaml` — semua asset gambar sudah di-embed sebagai base64.

---

## 🧭 Navigasi & Routes

| Route | Screen | Keterangan |
|-------|--------|------------|
| `/login` | LoginScreen | Halaman awal |
| `/forgot` | ForgotPasswordScreen | Reset password |
| `/dashboard` | DashboardScreen | Halaman utama |
| `/topup` | TopUpScreen | Butuh argument: `GameProduct` |
| `/order` | OrderScreen | Butuh argument: `Map {game, item}` |
| `/riwayat` | RiwayatScreen | Standalone |
| `/promo` | PromoScreen | Standalone |
| `/support` | SupportScreen | Standalone |
| `/profil` | ProfilScreen | Standalone |

---

## 🎨 Design System

### Warna

| Nama | Hex | Digunakan untuk |
|------|-----|-----------------|
| `kPrimary` | `#00E5FF` | Aksen utama, Mobile Legends |
| `kGold` | `#FFD700` | Free Fire, highlight |
| `kPurple` | `#7C4DFF` | PUBG Mobile |
| `kGreen` | `#00E676` | Genshin Impact, sukses |
| `kRed` | `#FF5252` | Valorant, error |
| `kBg` | `#0D0D0F` | Background utama |
| `kCard` | `#131320` | Background card |
| `kInput` | `#1E1E30` | Background input field |

### Komponen

- **Rounded corners** — `BorderRadius.circular(12–24)`
- **Glow effect** — `BoxShadow` dengan warna `withOpacity(0.4–0.5)`
- **Gradient** — `LinearGradient` untuk card dan tombol
- **Animasi** — `AnimatedContainer` untuk seleksi item
- **Scroll** — `CustomScrollView` + Slivers untuk performa optimal

---

## 🔌 Integrasi (Rencana)

Aplikasi ini menggunakan **dummy data**. Untuk produksi, integrasikan dengan:

- **Backend API** — Ganti `AppData` dengan HTTP request ke REST API
- **Midtrans** — Untuk payment gateway (Dana, OVO, GoPay, Transfer Bank)
- **Digiflaz** — Untuk supplier top up game otomatis
- **Firebase Auth** — Untuk autentikasi user yang sesungguhnya

---

## 👨‍💻 Developer

**Jay (I Komang Jaya Wiguna)**  
Mahasiswa Institut Bisnis dan Teknologi Indonesia (Instiki)  
Konsentrasi: Web Development & UI/UX Design

> Brand: **Jay.ID** — Layanan top up game & aplikasi premium

---

## 📄 Lisensi

Project ini dibuat untuk keperluan pembelajaran dan portofolio pribadi.  
© 2025 Jay.ID — All rights reserved.
