<img width="1098" height="558" alt="image" src="https://github.com/user-attachments/assets/3c7c5cc3-c447-45d4-8911-9bbb462e691a" />





# Tools (Bug Bounty & Recon Environment)

Script installer otomatis buat nyiapin *environment recon* dan *bug bounty* di Kali Linux atau VPS dengan cepat dan tanpa ribet.

---

## Ringkasan

Proyek ini dibuat untuk memangkas waktu instalasi awal saat mau melakukan *pentesting*. Kamu tidak perlu repot install tools satu per satu atau ngurusin error dependensi karena semuanya sudah otomatis dirakit dalam satu kali eksekusi script.

---

## Daftar Lengkap Tools & Fungsinya

### 1. Kategori Pencarian Subdomain (Subdomain Enumeration)
* **Subfinder**: Tools untuk mencari subdomain target dari berbagai sumber pasif secara cepat.
* **Amass**: Framework mendalam untuk pemetaan jaringan dan pengumpulan subdomain secara aktif maupun pasif.
* **Assetfinder**: Tools sederhana dan cepat untuk menemukan domain dan subdomain dari berbagai sumber publik.
* **Findomain**: Alat pencari subdomain tercepat berbasis *cross-platform* yang menggunakan teknik pemindaian mandiri.
* **Chaos**: Tools resmi dari ProjectDiscovery untuk mengambil data subdomain dari basis data ProjectDiscovery Cloud.

### 2. Kategori Pengecekan Web & Crawling (HTTP Probing & Archiving)
* **Httpx**: Tools untuk melakukan probing pada daftar URL, mengecek status HTTP (*live check*), melihat judul halaman, dan teknologi web.
* **Hakrawler**: *Web crawler* sederhana untuk menemukan tautan (*endpoints*) dan script di dalam sebuah website.
* **Katana**: *Web crawler* generasi berikutnya yang sangat cepat dan mendukung *headless browser* untuk mengumpulkan endpoint.
* **Gau (Get All URLs)**: Mengambil semua URL yang pernah tercatat untuk sebuah domain dari arsip publik seperti Wayback Machine.
* **Waybackurls**: Mengambil arsip URL dari Wayback Machine secara spesifik berdasarkan target domain.
* **Gospider**: *Web spider* cepat yang ditulis dengan Go untuk merayapi situs dan mengumpulkan tautan penting.

### 3. Kategori Pencarian Direktori & Fuzzing (Directory Bruteforcing)
* **Ffuf**: *Fuzzer* web berbasis Go yang sangat cepat untuk mencari direktori, file tersembunyi, atau parameter web.
* **Gobuster**: Tools klasik untuk menebak direktori/file, DNS sub-domain, dan *bucket* Amazon S3 menggunakan metode *brute-force*.
* **Dirsearch**: Skrip pemindai jalur web (*path scanner*) untuk menemukan direktori dan file tersembunyi di server target.

### 4. Kategori Pemindaian Kerentanan & Port (Vulnerability Scanning)
* **Nuclei**: Pemindai kerentanan berbasis *template* buatan komunitas untuk mendeteksi berbagai celah keamanan secara otomatis.
* **Naabu**: Pemindai port (*port scanner*) jaringan yang cepat dan andal untuk mendeteksi port terbuka pada target.
* **Nuclei-Templates**: Koleksi file template resmi yang mendukung operasional Nuclei dalam mendeteksi celah.

### 5. Kategori Pengolahan Data & Utilitas (Utilities & Parsing)
* **Anew**: Tools untuk membandingkan data baru dengan data lama, sangat berguna untuk menyaring baris unik saja.
* **Qsreplace**: Tools untuk mengganti nilai parameter di dalam sebuah URL dengan string kustom.
* **Uro**: Tools Python untuk membersihkan dan menyaring daftar URL dari duplikat yang tidak penting.
* **Interlace**: Tools automasi untuk menjalankan perintah secara *multi-threaded* dan terstruktur.
* **Gf**: Pembungkus pola regex untuk mencari pola tertentu (seperti XSS, SSRF, SQLi) dari kumpulan URL.
* **Waymore**: Tools untuk mengambil URL dari arsip Wayback Machine dengan hasil yang jauh lebih melimpah.
* **XnLinkFinder**: Tools untuk mengekstrak *endpoint* dan tautan tersembunyi dari file JavaScript maupun HTML.
* **Arjun**: Tools otomatis untuk mendeteksi parameter HTTP tersembunyi pada suatu halaman web.

---

## Cara Instalasi Singkat

Cukup jalankan perintah ini di terminal kamu:

```bash
git clone [https://github.com/bobriva/tools-umkm.git](https://github.com/bobriva/tools-umkm.git)
cd tools-umkm
sudo ./install.sh
```

Developed with ❤️ by Bob Riva

Bug Bounty Pemula
