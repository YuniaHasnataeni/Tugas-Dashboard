<p align="center" width="80%">
    <img width="100%" src="https://github.com/YuniaHasnataeni/Tugas-Dashboard/blob/main/Gambar/Logo.png">
</p>

<div align="center">
            
# Statistika Deskriptif - Regresi Linier Sederhana - Analisis Tren

[Tentang](#information_source-tentang)
•
[Dokumentasi](#blue_book-dokumentasi)
•
[Dataset](#bar_chart-Dataset)
•
[Demo](#link-Demo)
•
[Referensi](#bookmark_tabs-Referensi)
•
[Tim Pengembang](#busts_in_silhouette-tim)
•

</div>

## :information_source: Tentang
Statistik Deskriptif bertujuan untuk menggambarkan data secara ringkas dan memberikan gambaran umum mengenai distribusi dan karakteristik utama data, antara lain: nilai Mean, Median, nilai Minimal dan Maksimal, kuartil (Q1 dan Q3), dan Rentang Interkuartil (IQR).
- Nilai Rata-rata (Mean): Merupakan nilai pusat data yang diperoleh dari jumlah seluruh data dibagi jumlah data.
- Median: Nilai tengah dalam dataset yang telah diurutkan.
- Nilai Minimal dan Maksimal: Menunjukkan nilai terkecil dan terbesar dalam data, memberikan gambaran mengenai rentang data.
- Kuartil (Q1 dan Q3): Membagi data yang telah diurutkan menjadi empat bagian yang sama besar. Kuartil pertama (Q1) menunjukkan nilai pada 25% pertama data, sementara kuartil ketiga (Q3) menunjukkan nilai pada 75% pertama data.
- Rentang Interkuartil (IQR): Selisih antara Q3 dan Q1 yang menggambarkan penyebaran data tanpa dipengaruhi oleh pencilan (outliers).

Regresi linier sederhana digunakan untuk menganalisis hubungan antara satu variabel independen (bebas) dengan satu variabel dependen (terikat). Tujuan dari regresi linier sederhana adalah untuk memodelkan hubungan linier antara dua variabel dan membuat prediksi berdasarkan hubungan tersebut.
Model Regresi Linier Sederhana:
            Y = β₀ + β₁X + ϵ
Asumsi Model Linier:
- Bentuk hubungannya linier
- Sisaan adalah peubah acak yang bebas terhadap nilai X
- Sisaan merupakan peubah acak yang menyebar Normal dengan rataan nol dan ragam yang konstan (homoskedastisitas).
- Sisaan tidak berkorelasi satu sama lain.

Analisi tren berfokus pada mempelajari perubahan data seiring waktu untuk mengidentifikasi pola atau arah pergerakan data. Teknik ini digunakan untuk menganalisis bagaimana suatu variabel berubah dari waktu ke waktu dan untuk meramalkan nilai masa depan berdasarkan tren yang teridentifikasi.
Jenis Analisis Tren:
* Tren Naik: Data yang menunjukkan peningkatan secara konsisten.
* Tren Turun: Data yang menunjukkan penurunan secara konsisten.
* Fluktuasi: Perubahan yang tidak mengikuti pola tetap, tetapi menunjukkan variasi yang terjadi secara acak.
Aplikasi: Analisis tren sering digunakan untuk memproyeksikan permintaan produk susu dan turunannya berdasarkan data penjualan historis. Selain itu, analisis tren dapat digunakan untuk memprediksi perubahan harga per unit produk di masa depan, memberikan wawasan yang relevan untuk pengambilan keputusan bisnis dalam rantai pasok dan pemasaran produk-produk dairy.

## :blue_book: Dokumentasi

### Penjelasan singkat masing-masing library yang digunakan:

**1. shiny:**

* Paket shiny digunakan untuk membuat aplikasi web interaktif dengan R. Anda dapat membuat berbagai macam aplikasi, seperti dashboard, visualisasi data, dan alat interaktif lainnya.

**2. sjPlot:**

* Paket sjPlot adalah extension dari ggplot2 untuk membuat grafik dan visualisasi data statistik yang lebih spesifik. Sangat berguna untuk membuat publikasi ilmiah, presentasi, dan laporan.

**3. plotly:**

* Paket plotly digunakan untuk membuat visualisasi data interaktif menggunakan JavaScript library. Grafik yang dihasilkan dapat di-zoom, dipan, dan diputar untuk melihat data dari berbagai sudut.

**4. rhandsontable:**

* Paket rhandsontable menyediakan fungsi untuk membuat spreadsheet interaktif yang dapat digunakan dalam aplikasi web shiny. Spreadsheet ini dapat diedit oleh pengguna, dan perubahan yang dibuat akan direfleksikan di data yang diproses oleh aplikasi.

**5. tidyverse:**

* Tidyverse adalah kumpulan paket yang bekerja bersama-sama untuk manipulasi, cleaning, dan analisis data. Paket ini menyediakan berbagai fungsi untuk membuat kode R lebih ringkas dan mudah dibaca.

**6. epitoools:**

* Paket epitoools adalah kumpulan fungsi untuk epidemiologi dan statistik kesehatan. Paket ini menyediakan berbagai fungsi untuk menghitung ukuran asosiasi, uji hipotesis, dan analisis data epidemiologi.

**7. markdown:**

* Paket markdown digunakan untuk menulis dokumen yang dapat dikonversi ke berbagai format, seperti HTML, PDF, dan Word. Ini berguna untuk membuat laporan, presentasi, dan dokumentasi.

**8. knitr:**

* Paket knitr adalah ekstensi dari markdown untuk menulis dokumen yang menggabungkan kode R dan teks. Kode R akan dieksekusi dan hasilnya akan ditampilkan dalam dokumen output. Ini berguna untuk membuat laporan, presentasi, dan blog yang berisi kode R dan hasil eksekusi.

## :bar_chart: Dataset
### Dataset Penjualan Produk Susu

**Dataset Penjualan Produk Susu** adalah kumpulan data yang komprehensif yang berisi informasi detail mengenai peternakan sapi perah, produk susu, penjualan, dan manajemen persediaan. Dataset ini dapat digunakan untuk analisis tren, peramalan permintaan, dan optimasi persediaan. Berikut adalah fitur dan karakteristik dari dataset ini:

### **Variabel yang Digunakan**

### **Variabel Terikat**
**Nilai Total**  
- Deskripsi: Total nilai produk susu berdasarkan kuantitas yang tersedia.  
- **Tipe**: Numerik (kontinu).  
Variabel ini menjadi target analisis untuk memahami faktor-faktor yang memengaruhi nilai total produk susu.
### **Variabel Bebas**

| **Fitur**                        | **Deskripsi**                                                                                      |
|----------------------------------|----------------------------------------------------------------------------------------------------|
| **Lokasi**                       | Lokasi geografis peternakan sapi perah                                                          |
| **Nama Produk**                  | Nama produk susu (misalnya, susu, yogurt, keju)                                                  |
| **Merek**                        | Nama merek yang memproduksi produk susu                                                          |
| **Jumlah (liter/kg)**            | Jumlah produk susu yang tersedia                                                                 |
| **Harga per Unit**               | Harga satuan produk susu                                                                         |
| **Jumlah Terjual (liter/kg)**    | Kuantitas produk susu yang telah terjual                                                         |
| **Harga per Unit (terjual)**     | Harga aktual produk susu pada saat penjualan                                                     |
| **Jumlah Stok (liter/kg)**       | Kuantitas produk susu yang masih tersedia di gudang                                              |
| **Batas Minimum Stok (liter/kg)**| Batas minimum stok untuk menghindari kekurangan produk                                           |
| **Date**                         | Tanggal pencatatan data                                                                  |
| **Ukuran Peternakan (sq.km)**     | Ukuran fisik peternakan dalam kilometer persegi.                        |
| **Kondisi Penyimpanan**       | Kondisi penyimpanan yang disarankan untuk produk susu.        |
| **Luas Lahan (acre)**         | Luas total lahan yang ditempati oleh peternakan sapi perah.   |
| **Saluran Penjualan**         | Saluran melalui mana produk susu dijual (Retail, Grosir, Online). |
| **Jumlah Sapi**               | Jumlah sapi yang ada di peternakan sapi perah.                |

---

### Cara Mengakses Dataset
Dataset ini dapat diakses melalui [tautan ini](https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset).

---


## :linkk: Demo

Berikut merupakan link untuk shinnyapps atau dashboard dari project kami:

https://rismandwij.shinyapps.io/AsosiasiDuaPeubahKategorik/


## :bookmark_tabs: Referensi
1. Iskandar, I., & Sutrisno, A. (2021). "Analisis Pengaruh Harga dan Pendapatan terhadap Permintaan Barang dengan Regresi Linier Sederhana". Jurnal Ekonomi dan Manajemen 15(3), 234-245.
2. Kusuma, P. D., & Nugroho, B. (2018). "Analisis Tren Penurunan Tingkat Pengangguran di Indonesia Menggunakan Metode Peramalan". Jurnal Analisis Sosial dan Ekonomi 7(1), 99-109.
3. Rifai, A. (2019). "Penerapan Statistik Deskriptif dalam Analisis Data Penjualan Produk". Jurnal Ilmu dan Teknologi 4(1), 45-52.
4. Suraj. (2021). Dairy Goods Sales Dataset. Kaggle. https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset 



## :busts_in_silhouette: Tim Pengembang
### Dosen Pengampu :
1. Dr. Anwar Fitrianto, S.Si., M.Sc.
2. Dr. Ir. Erfiani, M.Si
4. L.M Risman Dwi Jumansyah S.Stat
### Kelompok Mahasiswa :
1. Yunia Hasnataeni (G1501231001)
2. Kevin Alifviansyah (G1501231018)
3. Rafika Aristawidya (G1501231065)







