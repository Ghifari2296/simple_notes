# Simple Notes App – Assessment I Pemrograman Mobile

## Anggota Tim
- Ghifari Alif Auladi (NIM: 2310130006)

## Tema Aplikasi
**Simple Notes App** – Aplikasi untuk mencatat ide, tugas, atau hal penting dalam bentuk catatan singkat yang terdiri dari **judul** dan **deskripsi opsional**.

## Deskripsi Fitur
Aplikasi ini memungkinkan pengguna untuk:
- ✅ Menambah catatan baru melalui form input (judul wajib, deskripsi opsional)
- ✅ Menampilkan daftar catatan di halaman utama dengan desain kartu berwarna pastel
- ✅ Menghapus catatan dengan ikon hapus atau gesek ke kiri (swipe to delete)
- ✅ Mendapatkan notifikasi saat menambah/menghapus catatan
- ✅ Membatalkan penghapusan dengan fitur **Undo** pada notifikasi

Aplikasi menggunakan **tema hijau-teal** yang elegan dan antarmuka yang responsif serta user-friendly.

## Pembagian Tugas
- **Ghifari Alif Auladi (2310130006)**:  
  Merancang UI/UX, mengimplementasikan logika Dart, mengelola struktur data, membuat dokumentasi, dan melakukan testing.

## Screenshot
![Daftar Catatan](screenshots/daftar_catatan.png)  
*Halaman utama menampilkan daftar catatan*

![Form Tambah Catatan](screenshots/form_tambah.png)  
*Dialog untuk menambah catatan baru dengan judul dan deskripsi*

> 💡 Pastikan folder `screenshots/` berisi kedua file gambar tersebut saat di-upload ke GitHub.

## Penjelasan Penggunaan List
Data catatan disimpan dalam variabel `List<Note>` di dalam state `_MyHomePageState`, di mana setiap elemen adalah objek dari class `Note` yang memiliki dua properti: `title` (judul) dan `description` (deskripsi).

- Saat menambah catatan, metode `_addNote()` memanggil `setState()` dan menambahkan objek `Note` baru ke dalam list menggunakan `notes.insert(0, ...)` agar catatan terbaru muncul di atas.
- Saat menghapus, `notes.removeAt(index)` digunakan untuk menghapus data berdasarkan posisi, lalu `setState()` dipanggil agar tampilan diperbarui secara otomatis.
- Data **hanya disimpan di memori** selama aplikasi berjalan dan **tidak disimpan ke database**, sesuai ketentuan soal.

Struktur ini memenuhi semua kriteria assessment: penggunaan `List`, manipulasi data dengan `setState()`, dan interaksi pengguna yang lengkap.