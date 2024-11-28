<p align="center" width="100%">
    <img width="100%" src="https://github.com/YuniaHasnataeni/Tugas-Dashboard/blob/main/Gambar/Dairy Goods.png">
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
## Aplikasi Dashboard Penjualan Produk Susu
Aplikasi ini bertujuan untuk melakukan analisis deskriptif, regresi linier sederhana, dan analisis tren terhadap data penjualan produk susu. Dashboard ini menyediakan visualisasi interaktif untuk mempermudah pengguna dalam menganalisis distribusi, hubungan antar variabel, dan tren yang terjadi pada data penjualan susu.

## Statistik Deskriptif
Statistik deskriptif digunakan untuk menggambarkan data secara ringkas dan memberikan gambaran umum mengenai distribusi serta karakteristik utama dari data. Beberapa elemen statistik deskriptif yang penting antara lain:
### 1. Nilai Rata-rata (Mean)
Nilai rata-rata adalah nilai pusat data yang diperoleh dari jumlah seluruh data dibagi dengan jumlah data. Rata-rata memberikan gambaran umum mengenai tingkat pusat distribusi data.
### 2. Median
Median adalah nilai tengah dalam dataset yang telah diurutkan. Jika dataset memiliki jumlah elemen yang ganjil, median adalah nilai yang berada di tengah. Jika jumlah elemen genap, median dihitung sebagai rata-rata dari dua nilai tengah.
### 3. Nilai Minimal dan Maksimal
Nilai minimal menunjukkan nilai terkecil dalam dataset, sementara nilai maksimal menunjukkan nilai terbesar. Keduanya memberikan gambaran mengenai rentang data yang ada.
### 4. Kuartil (Q1 dan Q3)
Kuartil membagi data yang telah diurutkan menjadi empat bagian yang sama besar:
- **Kuartil pertama (Q1)**: Nilai yang memisahkan 25% data pertama.
- **Kuartil ketiga (Q3)**: Nilai yang memisahkan 75% data pertama.
### 5. Rentang Interkuartil (IQR)
IQR adalah selisih antara Q3 dan Q1 dan memberikan gambaran tentang penyebaran data. Rentang ini mengabaikan pengaruh pencilan (outliers) karena hanya melibatkan data antara Q1 dan Q3.

---

## Regresi Linier Sederhana

Regresi linier sederhana digunakan untuk menganalisis hubungan antara satu variabel independen (X) dan satu variabel dependen (Y). Tujuannya adalah untuk memodelkan hubungan linier antara kedua variabel tersebut dan membuat prediksi berdasarkan hubungan yang teridentifikasi.

### Model Regresi Linier Sederhana
Model regresi linier sederhana dapat dituliskan sebagai:

            Y = β₀ + β₁X + ϵ 


Di mana:
- **Y** = Variabel dependen (terikat)
- **X** = Variabel independen (bebas)
- **β₀** = Intersep (nilai Y ketika X = 0)
- **β₁** = Koefisien regresi (kemiringan garis yang menunjukkan perubahan Y per perubahan satu unit X)
- **ϵ** = Sisaan (residual) atau error term, yang merepresentasikan variasi dalam Y yang tidak dijelaskan oleh X

### Asumsi Model Regresi Linier
Model regresi linier sederhana mengasumsikan bahwa:
1. **Bentuk Hubungan Linier**: Hubungan antara variabel dependen (Y) dan independen (X) bersifat linier.
2. **Sisaan (Residual)** adalah peubah acak yang bebas terhadap nilai X, yang berarti tidak ada pola tertentu antara sisaan dan nilai X.
3. **Normalitas Sisaan**: Sisaan (ϵ) menyebar secara normal dengan rata-rata nol dan varians yang konstan (homoskedastisitas). Hal ini penting untuk memastikan bahwa hasil uji signifikansi model dapat dipercaya.
4. **Tidak Ada Autokorelasi**: Sisaan tidak berkorelasi satu sama lain (tidak ada pola yang muncul pada sisaan di waktu atau urutan tertentu).

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

## :blue_book: Dokumentasi

### Penjelasan Mengenai Library yang Digunakan

Aplikasi ini menggunakan beberapa library R untuk manipulasi data, visualisasi, dan analisis statistik:

1. **`shiny`**: Library utama untuk membangun aplikasi web interaktif menggunakan R. `shiny` memungkinkan pembuatan antarmuka pengguna (UI) dan logika server dalam satu aplikasi yang dapat digunakan secara real-time.
2. **`shinythemes`**: Menyediakan berbagai tema untuk aplikasi Shiny, memungkinkan tampilan UI yang lebih menarik dan konsisten tanpa memerlukan CSS tambahan. `shinythemes` memudahkan desain antarmuka dengan memilih tema siap pakai seperti "flatly", "cerulean", dan lainnya.
3. **`dplyr`**: Salah satu package dalam **tidyverse** yang sangat berguna untuk manipulasi data. `dplyr` menyediakan fungsi yang efisien dan intuitif untuk memfilter, mengurutkan, mengelompokkan, dan merangkum data dalam bentuk yang mudah dipahami.
4. **`highcharter`**: Library untuk membuat visualisasi interaktif menggunakan grafik Highcharts. `highcharter` memungkinkan pembuatan berbagai jenis grafik interaktif yang dapat digunakan di aplikasi Shiny untuk memvisualisasikan data secara dinamis.
5. **`DT`**: Paket untuk menampilkan data dalam bentuk tabel interaktif menggunakan **DataTables**. Tabel ini mendukung fitur pencarian, pengurutan, dan penyesuaian kolom secara langsung dalam antarmuka pengguna.
6. **`lubridate`**: Package yang sangat berguna untuk manipulasi dan analisis data waktu (tanggal dan waktu). `lubridate` memungkinkan pemrosesan tanggal dan waktu dengan cara yang lebih mudah dan efisien dibandingkan dengan fungsi dasar R.
7. **`lmtest`**: Paket untuk melakukan uji statistik pada model regresi. `lmtest` digunakan untuk menguji asumsi-asumsi dalam model regresi, seperti uji heteroskedastisitas, normalitas residual, dan lain-lain.
8. **`car`**: Paket untuk analisis regresi dan evaluasi asumsi model. `car` menyediakan berbagai fungsi untuk uji diagnostik regresi, seperti uji multikolinearitas, uji linearitas, dan alat lainnya untuk mengevaluasi kualitas model regresi.

---

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


## :link: Demo

Berikut merupakan link untuk shinnyapps atau dashboard dari project kami: 


---

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







