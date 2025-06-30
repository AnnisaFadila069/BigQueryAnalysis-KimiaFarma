-- Melihat isi tabel berdasarkan tanggal terbaru
SELECT *
FROM `rakamin-kf-analytics-464415.kimia_farma.kf_transformed`
ORDER BY date DESC
LIMIT 100;