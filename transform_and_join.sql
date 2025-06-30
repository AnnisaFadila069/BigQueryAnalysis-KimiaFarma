-- Membuat atau menggantikan tabel bernama kf_transformed di dataset kimia_farma
CREATE OR REPLACE TABLE `rakamin-kf-analytics-464415.kimia_farma.kf_transformed` AS

-- Menggunakan Common Table Expressions (CTE) untuk modularisasi query
WITH

-- Ambil data transaksi dasar dari tabel transaksi
transaksi_dasar AS (
  SELECT
    ft.transaction_id,                -- ID unik transaksi
    ft.date,                          -- Tanggal transaksi
    ft.branch_id,                     -- ID cabang tempat transaksi dilakukan
    ft.customer_name,                 -- Nama pelanggan
    ft.product_id,                    -- ID produk yang dibeli
    ft.price AS actual_price,         -- Harga sebelum diskon
    ft.discount_percentage,           -- Persentase diskon yang diberikan (0-1)
    ft.rating AS rating_transaksi     -- Penilaian terhadap transaksi
  FROM `rakamin-kf-analytics-464415.kimia_farma.kf_final_transaction` ft
),

-- Ambil informasi produk dari tabel produk
produk_detail AS (
  SELECT
    product_id,                       -- ID produk
    product_name                      -- Nama produk
  FROM `rakamin-kf-analytics-464415.kimia_farma.kf_product`
),

-- Ambil informasi kantor cabang dari tabel kantor cabang
cabang_detail AS (
  SELECT
    branch_id,                        -- ID cabang
    branch_name,                      -- Nama cabang
    kota,                             -- Kota cabang
    provinsi,                         -- Provinsi cabang
    rating AS rating_cabang           -- Rating terhadap cabang
  FROM `rakamin-kf-analytics-464415.kimia_farma.kf_kantor_cabang`
),

-- Gabungkan data dari transaksi, produk, dan cabang
gabungan AS (
  SELECT
    td.transaction_id,
    td.date,
    td.branch_id,
    cd.branch_name,
    cd.kota,
    cd.provinsi,
    cd.rating_cabang,
    td.customer_name,
    td.product_id,
    pd.product_name,
    td.actual_price,
    td.discount_percentage,

    -- Hitung persentase gross laba berdasarkan harga
    CASE 
      WHEN td.actual_price <= 50000 THEN 0.10       -- Jika harga <= 50.000, laba 10%
      WHEN td.actual_price <= 100000 THEN 0.15      -- Jika harga <= 100.000, laba 15%
      WHEN td.actual_price <= 300000 THEN 0.20      -- Jika harga <= 300.000, laba 20%
      WHEN td.actual_price <= 500000 THEN 0.25      -- Jika harga <= 500.000, laba 25%
      ELSE 0.30                                      -- Jika harga > 500.000, laba 30%
    END AS persentase_gross_laba,

    td.rating_transaksi
  FROM transaksi_dasar td
  JOIN produk_detail pd ON td.product_id = pd.product_id   -- Gabungkan data produk
  JOIN cabang_detail cd ON td.branch_id = cd.branch_id     -- Gabungkan data cabang
)

-- Lakukan perhitungan akhir dan ekspor hasil ke tabel
SELECT
  *,  -- Ambil semua kolom hasil gabungan
  -- Hitung nett_sales = harga setelah diskon
  ROUND(actual_price * (1 - discount_percentage), 2) AS nett_sales,

  -- Hitung nett_profit = nett_sales * persentase_gross_laba
  ROUND(
    (actual_price * (1 - discount_percentage)) * persentase_gross_laba,
    2
  ) AS nett_profit
FROM gabungan;