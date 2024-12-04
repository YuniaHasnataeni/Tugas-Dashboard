<p align="center" width="100%">
    <img width="100%" src="https://github.com/YuniaHasnataeni/Tugas-Dashboard/blob/main/Gambar/Dairy Goods.png">
</p>

<div align="center">
            
# Dashboard Analisis Penjualan Produk Susu (DAPS)

[Tentang](#information_source-tentang)
•
[Library](#blue_book-Library_yang_Digunakan)
•
[Dataset](#bar_chart-Dataset)
•
[Demo](#link-Demo)
•
[Referensi](#bookmark_tabs-Referensi)
•
[Tim Pengembang](#busts_in_silhouette-tim-pengembang)
•

</div>

# :information_source: Tentang
## Aplikasi Dashboard Penjualan Produk Susu
Aplikasi ini bertujuan untuk melakukan analisis deskriptif, regresi linier sederhana, dan analisis tren terhadap data penjualan produk susu. Dashboard ini menyediakan visualisasi interaktif untuk mempermudah pengguna dalam menganalisis distribusi, hubungan antar variabel, dan tren yang terjadi pada data penjualan susu.

---

## Statistik Deskriptif

Statistik deskriptif digunakan untuk merangkum data dan memberikan gambaran umum tentang distribusi dan karakteristik utama dari dataset. Elemen utama meliputi:

1. **Rata-rata (Mean)**: Nilai pusat yang dihitung dari jumlah total data dibagi jumlah data.
2. **Median**: Nilai tengah dari dataset yang telah diurutkan.
3. **Nilai Minimum & Maksimum**: Nilai terkecil dan terbesar dalam dataset.
4. **Kuartil (Q1 & Q3)**: Membagi data menjadi empat bagian yang sama besar, dengan Q1 memisahkan 25% data pertama dan Q3 memisahkan 75%.
5. **Rentang Interkuartil (IQR)**: Selisih antara Q3 dan Q1, menggambarkan penyebaran data tanpa pengaruh outliers.

---

## Analisis Korelasi
Analisis korelasi adalah metode statistik yang digunakan untuk mengukur dan menggambarkan kekuatan serta arah hubungan antara dua variabel. Korelasi mengukur sejauh mana dua variabel bergerak bersama, apakah mereka berhubungan secara positif (kedua variabel meningkat atau menurun bersama) atau negatif (satu variabel meningkat sementara yang lain menurun).

Nilai korelasi berkisar antara -1 hingga 1:
- **+1**: Korelasi positif sempurna, artinya kedua variabel bergerak dalam arah yang sama.
- **-1**: Korelasi negatif sempurna, artinya kedua variabel bergerak dalam arah yang berlawanan.
- **0**: Tidak ada korelasi, artinya tidak ada hubungan linier antara kedua variabel.

### Jenis Korelasi
1. **Korelasi Positif**: Ketika satu variabel meningkat, variabel lainnya juga meningkat.
2. **Korelasi Negatif**: Ketika satu variabel meningkat, variabel lainnya menurun.
3. **Korelasi Nol**: Tidak ada hubungan linier antara kedua variabel.

---

## Regresi Linier Berganda

Regresi linier berganda adalah metode statistik yang digunakan untuk menganalisis hubungan antara satu variabel dependen (Y) dan dua atau lebih variabel independen (X₁, X₂, ..., Xn). Tujuan dari analisis ini adalah untuk memodelkan hubungan linier antara variabel-variabel tersebut dan membuat prediksi berdasarkan data yang ada.

### Model
Model regresi linier berganda dapat dituliskan sebagai:

Y = β₀ + β₁X₁ + β₂X₂ + ... + βnXn + ϵ

Di mana:
- **Y** = Variabel dependen (terikat)
- **X₁, X₂, ..., Xn** = Variabel independen (bebas)
- **β₀** = Intersep (nilai Y ketika semua X = 0)
- **β₁, β₂, ..., βn** = Koefisien regresi (menunjukkan pengaruh masing-masing X terhadap Y)
- **ϵ** = Sisaan (error term) yang merepresentasikan variasi dalam Y yang tidak dijelaskan oleh variabel X.

### Asumsi
Beberapa asumsi dalam regresi linier berganda yang perlu dipenuhi untuk memperoleh hasil yang valid:
1. **Linearitas**: Hubungan antara variabel dependen dan independen bersifat linier.
2. **Independensi**: Observasi atau data yang digunakan harus independen satu sama lain.
3. **Homoskedastisitas**: Variansi sisaan harus konstan di seluruh rentang nilai X.
4. **Normalitas Sisaan**: Sisaan (ϵ) harus terdistribusi normal.
5. **Tidak ada multikolinearitas**: Tidak ada hubungan linier yang kuat antar variabel independen.

---

## Analisis Tren

Analisis tren digunakan untuk mempelajari perubahan data seiring waktu guna mengidentifikasi pola atau arah pergerakan data. Analisis ini dapat membantu dalam meramalkan nilai masa depan berdasarkan tren yang teridentifikasi dalam data historis.

### Jenis-jenis Analisis Tren:
- **Tren Naik**: Data yang menunjukkan peningkatan secara konsisten seiring waktu.
- **Tren Turun**: Data yang menunjukkan penurunan secara konsisten seiring waktu.
- **Fluktuasi**: Perubahan yang tidak mengikuti pola tetap, tetapi menunjukkan variasi acak.

### Aplikasi Analisis Tren
Analisis tren sering digunakan untuk memproyeksikan permintaan produk susu dan turunannya berdasarkan data penjualan historis. Selain itu, analisis tren dapat digunakan untuk memprediksi perubahan harga per unit produk susu di masa depan, memberikan wawasan yang relevan untuk pengambilan keputusan bisnis dalam rantai pasok dan pemasaran produk-produk dairy.

---

# :blue_book: Library yang Digunakan
### Penjelasan Mengenai Library yang Digunakan

Berikut adalah beberapa library R yang digunakan dalam aplikasi ini:

1. **`shiny`**: Library utama untuk membuat aplikasi web interaktif di R. `shiny` memungkinkan pembuatan antarmuka pengguna (UI) dan logika server dalam satu aplikasi.
2. **`shinydashboard`**: Digunakan untuk membuat antarmuka dashboard di aplikasi Shiny, memberikan tampilan yang lebih terstruktur dan profesional dengan elemen-elemen seperti sidebar dan box.
3. **`dplyr`**: Salah satu package dalam **tidyverse** yang digunakan untuk manipulasi data secara efisien. `dplyr` menyediakan fungsi untuk memfilter, mengurutkan, mengelompokkan, dan merangkum data.
4. **`highcharter`**: Library untuk membuat visualisasi interaktif menggunakan grafik Highcharts. `highcharter` memungkinkan pembuatan berbagai jenis grafik interaktif untuk aplikasi Shiny.
5. **`DT`**: Paket untuk menampilkan data dalam bentuk tabel interaktif menggunakan **DataTables**. Fitur-fitur seperti pencarian, pengurutan, dan penyesuaian kolom dapat dilakukan langsung dalam antarmuka pengguna.
6. **`lubridate`**: Memudahkan manipulasi dan analisis data waktu (tanggal dan waktu) di R, memungkinkan pemrosesan tanggal dan waktu secara lebih efisien.
7. **`car`**: Paket untuk analisis regresi dan evaluasi asumsi model. `car` menyediakan fungsi untuk uji diagnostik regresi, seperti uji multikolinearitas dan linearitas.
8. **`ggalluvial`**: Digunakan untuk membuat visualisasi alur (flow) atau diagram alur dengan menggunakan prinsip dari grafik **ggplot2**, cocok untuk menganalisis data dengan banyak kategori atau struktur.
9. **`reshape2`**: Library untuk merubah bentuk data, misalnya mengubah data dari format lebar ke panjang dan sebaliknya. Mempermudah proses reshaping data dalam analisis.
10. **`lmtest`**: Paket untuk melakukan uji statistik pada model regresi. `lmtest` digunakan untuk menguji asumsi dalam model regresi, seperti uji heteroskedastisitas dan normalitas residual.
11. **`Metrics`**: Digunakan untuk menghitung berbagai metrik evaluasi model, seperti **VIF (Variance Inflation Factor)** untuk mengidentifikasi masalah multikolinearitas pada regresi linier.
12. **`leaflet`**: Digunakan untuk membuat peta interaktif di aplikasi web. `leaflet` memudahkan integrasi peta berbasis data geografis dalam aplikasi Shiny.
13. **`tidygeocoder`**: Library untuk geocoding, yang memungkinkan konversi alamat menjadi koordinat geografis (latitude, longitude) dan sebaliknya.

---

# :bar_chart: Dataset
## Dataset Penjualan Produk Susu

**Dataset Penjualan Produk Susu** adalah kumpulan data yang komprehensif yang berisi informasi detail mengenai peternakan sapi perah, produk susu, penjualan, dan manajemen persediaan. Dataset ini dapat digunakan untuk analisis tren, peramalan permintaan, dan optimasi persediaan. Berikut adalah fitur dan karakteristik dari dataset ini:

### **Variabel yang Digunakan**

### **Variabel Terikat**
**Nilai Total**  
- Deskripsi: Total nilai produk susu berdasarkan kuantitas yang tersedia.  
- **Tipe**: Numerik (kontinu).  
Variabel ini menjadi target analisis untuk memahami faktor-faktor yang memengaruhi nilai total produk susu.
### **Variabel Bebas**

| **Variabel**                        | **Deskripsi**                                                                                      |
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

# :link: Demo

Berikut merupakan link untuk shinnyapps atau dashboard dari project kami: [tautan ini](https://yunia-hasnataeni.shinyapps.io/Tugas-Visdat-Kelompok4/).

---

# :bookmark_tabs: Referensi
2. Munawir, S. (2010), “Analisa Laporan Keuangan”. Yogyakarta: Liberty 
3. Rifai, A. (2019). "Penerapan Statistik Deskriptif dalam Analisis Data Penjualan Produk". Jurnal Ilmu dan Teknologi 4(1), 45-52.
4. Suraj. (2021). Dairy Goods Sales Dataset. Kaggle. https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset
5. Utari, Dina Tri. (2019). Analisis Regresi Terapan dengan R. Yogyakarta. Universitas Islam Indonesia

# :busts_in_silhouette: Tim Pengembang
### Dosen Pengampu :
1. Dr. Anwar Fitrianto, S.Si., M.Sc.
2. Dr. Ir. Erfiani, M.Si
4. L.M Risman Dwi Jumansyah S.Stat
### Kelompok Mahasiswa :
1. Yunia Hasnataeni (G1501231001)
2. Kevin Alifviansyah (G1501231018)
3. Rafika Aristawidya (G1501231065)







