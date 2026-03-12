<h1 align="center">Dotfiles — Global Codespaces Bootstrap :octocat: :octocat:</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Node.js-20.x-339933?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js 20" />
  <img src="https://img.shields.io/badge/npm-10.x-CB3837?style=for-the-badge&logo=npm&logoColor=white" alt="npm 10" />
  <img src="https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash" />
  <img src="https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=zsh&logoColor=white" alt="Zsh" />
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git" />
  <img src="https://img.shields.io/badge/GitHub_Codespaces-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Codespaces" />
</p>

Konfigurasi lingkungan pengembangan yang berjalan **otomatis** di setiap GitHub Codespace, tanpa perlu pengaturan berulang per-repositori.

> [!TIP]
> <mark>Baca baca disini</mark> https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles

---

## 🚨 Masalah yang Diselesaikan

Jika Anda sering mengalami salah satu dari kondisi berikut di GitHub Codespaces:

| Gejala | Penyebab |
|---|---|
| `An error occurred while setting up chat` | State autentikasi Copilot korup |
| `End of central directory record signature not found` | Unduhan VSIX extension terpotong/gagal |
| Node.js tiba-tiba kembali ke versi lama (16.x) | Image universal tidak memiliki default Node 20 |
| Harus konfigurasi manual setiap membuka Codespace baru | Tidak ada bootstrap global |

Repositori ini menyelesaikan seluruh permasalahan tersebut **satu kali untuk selamanya**, berlaku di semua repositori dan semua Codespace di akun Anda.

---

## 📁 Struktur Repositori

```
dotfiles/
├── install.sh           # Entry point — dieksekusi otomatis oleh Codespaces saat pertama start
├── .bashrc              # Node 20 aktif di setiap sesi bash
├── .zshrc               # Node 20 aktif di setiap sesi zsh
├── .npmrc               # Timeout unduhan diperpanjang + registry resmi (mencegah truncated error)
├── .gitconfig           # Konfigurasi git global + HTTP timeout
├── .gitignore_global    # Aturan ignore yang berlaku secara global
└── README.md            # Panduan ini
```

---

## ⚙️ Cara Setup — Cukup Dilakukan Sekali

### Langkah 1 — Fork atau Clone ke Akun Sendiri

> [!NOTE]
> ⚠️ **Wajib:** Dotfiles harus berada di repositori milik akun GitHub Anda sendiri. GitHub Codespaces hanya akan mengeksekusi dotfiles dari repositori yang dimiliki oleh akun yang sedang login.

**Opsi A — Fork (direkomendasikan, lebih cepat):**

1. Klik tombol **Fork** di pojok kanan atas halaman repositori ini
2. Pilih akun GitHub Anda sebagai tujuan fork
3. Pastikan nama repositori hasil fork adalah `dotfiles`

**Opsi B — Clone manual dan push ke repositori baru:**

```bash
# Clone repositori ini
git clone https://github.com/arcxteam/dotfiles.git
cd dotfiles

# Ganti remote ke repositori Anda sendiri
git remote set-url origin https://github.com/USERNAME_ANDA/dotfiles.git

# Push ke akun Anda
git push -u origin main
```

> Ganti `USERNAME_ANDA` dengan username GitHub Anda yang sebenarnya.

---

### Langkah 2 — Aktifkan di GitHub Settings

1. Buka → **[github.com/settings/codespaces](https://github.com/settings/codespaces)**
2. Scroll ke bagian **Dotfiles**
3. Pada dropdown, pilih repositori `USERNAME_ANDA/dotfiles`
4. Centang **✅ Automatically install dotfiles**
5. Klik **Save**

<img width="766" height="154" alt="image" src="https://github.com/user-attachments/assets/cb9eef8e-48c1-489f-aa17-0366bde5e4d1" />

---

### Langkah 3 — Buat Codespace Baru

Buat Codespace baru dari repositori manapun. Script `install.sh` akan berjalan otomatis di background saat startup, melakukan:

- [x] Instalasi dan aktivasi Node.js 20 via `nvm`/`nvs`
- [x] Penghapusan cache extension VS Code yang berpotensi korup
- [x] Symlink semua file konfigurasi ke direktori `$HOME`
- [x] Konfigurasi npm dengan timeout yang lebih panjang
- [x] Pembersihan environment variable proxy yang mengganggu

> Untuk Codespace yang **sudah ada**: tekan `Ctrl+Shift+P` → jalankan `Codespaces: Rebuild Container`

---

> [!IMPORTANT]
> ❓ FAQ

<details>
<summary><strong>Apakah aman dijadikan repositori publik?</strong></summary>

**Ya, sepenuhnya aman.** File-file dalam repositori ini tidak mengandung token, password, API key, atau informasi sensitif apapun. Menjadikan dotfiles sebagai repositori publik adalah praktik yang sangat umum di komunitas developer.

</details>

<details>
<summary><strong>Apakah nama repositori harus "dotfiles"?</strong></summary>

Tidak wajib, namun **sangat disarankan**. GitHub Codespaces akan secara otomatis mendeteksi repositori bernama `dotfiles` di akun Anda. Jika menggunakan nama lain, Anda tetap bisa memilihnya secara manual di halaman Settings Codespaces.

</details>

<details>
<summary><strong>Apakah ini hanya untuk proyek Node.js?</strong></summary>

**Tidak.** Node.js 20 diprioritaskan karena versi runtime ini sering menjadi penyebab utama kegagalan instalasi extension di Codespaces. Namun file `.gitconfig`, `.npmrc`, `.bashrc`, dan `.zshrc` berlaku universal untuk semua jenis proyek — Next.js, Python, Go, Ruby, PHP, dan lain-lain.

</details>

<details>
<summary><strong>Apakah perlu menambahkan file ini ke setiap repositori?</strong></summary>

**Tidak perlu sama sekali.** Repositori dotfiles ini bekerja di level akun GitHub, bukan per-repositori. Sekali diaktifkan, seluruh Codespace yang dibuat dari akun Anda akan secara otomatis menggunakan konfigurasi ini.

</details>

<details>
<summary><strong>Bagaimana memverifikasi bahwa dotfiles berhasil dijalankan?</strong></summary>

Setelah Codespace baru terbuka, jalankan perintah berikut di terminal:

```bash
node -v   # harus menampilkan v20.x.x atau lebih baru
npm -v    # harus menampilkan versi yang kompatibel
```

Jika hasilnya sesuai, instalasi dotfiles berhasil.

</details>

---

## 📋 Kompatibilitas

| Lingkungan | Status |
|---|---|
| GitHub Codespaces (Universal Image) | ✅ Didukung |
| GitHub Codespaces (Custom Image) | ✅ Didukung |
| Dev Container lokal (VS Code) | ✅ Didukung sebagian |
| Mesin lokal (Linux/macOS) | ⚠️ Dapat digunakan manual |

## Check Manual di codespace
```
node -v     # harus v20.x.x
npm -v      # harus v10.x.x
cat ~/.nvmrc  # harus isi "20"
```

---

<sub>Dibuat untuk mengatasi masalah instalasi extension secara permanen di GitHub Codespaces.</sub>
