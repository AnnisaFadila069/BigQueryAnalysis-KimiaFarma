# 🧪 Kimia Farma Analytics

Proyek ini merupakan studi kasus analitik berbasis data Kimia Farma yang dilakukan menggunakan **Google BigQuery** untuk eksplorasi data dan **Looker Studio** untuk visualisasi interaktif. Tujuan dari proyek ini adalah mengidentifikasi **wawasan bisnis (insight)** yang dapat meningkatkan efisiensi operasional dan pengambilan keputusan strategis perusahaan.

## 🗂️ Struktur Dataset

Data bersumber dari 4 tabel utama:

| Dataset | Deskripsi |
|--------|-----------|
| `kf_final_transaction.csv` | Data transaksi pembelian produk oleh pelanggan |
| `kf_product.csv` | Detail produk seperti nama dan kategori |
| `kf_inventory.csv` | Informasi stok produk di tiap cabang |
| `kf_kantor_cabang.csv` | Informasi cabang, kota, dan rating cabang |

---

## 🧩 Fitur Proyek

✅ Transformasi data dan integrasi antar tabel  
✅ Perhitungan `nett_sales`, `nett_profit`, dan `gross_margin` berdasarkan aturan harga  
✅ Visualisasi interaktif dengan Looker Studio  
✅ Insight cabang dengan **rating tertinggi namun transaksi rendah**  
✅ Heatmap distribusi profit dan transaksi per kota

---

## 📊 Tools & Teknologi

- Google BigQuery (SQL)
- Google Looker Studio (Visualisasi)
- Spreadsheet / CSV
- GitHub (Manajemen versi)

---

---

## 📁 Struktur Repository

```bash
kimia-farma-analytics/
├── datasets/ #berisi dataset yang dibutuhkan
│   ├── kf_final_transaction.csv
│   ├── kf_product.csv
│   ├── kf_inventory.csv
│   └── kf_kantor_cabang.csv
├── transform_and_join.sql #proses query menggabungkan dataset ke tabel analisis
├── query_melihat hasil tabel.sql #melihat hasil tabel
├── kf_transformed.xlsx #hasil dari tabel analisis   
├── README.md
```