# Load necessary libraries
library(shiny)
library(shinydashboard)
library(dplyr)
library(highcharter)
library(DT)
library(lubridate)
library(car)
library(ggalluvial)
library(reshape2)
library(lmtest)  # For Breusch-Pagan test
library(Metrics)  # For VIF function
library(leaflet)
library(tidygeocoder)

# Read dataset from a file
data <- read.csv("https://raw.githubusercontent.com/YuniaHasnataeni/Tugas-Dashboard/main/Data/dairy_dataset.csv", row.names = NULL)

# Convert Date column to Date format
data$Date <- as.Date(data$Date, format = "%Y-%m-%d")

# Add additional columns (year, month, week)
data <- data %>% 
  mutate(
    Year = year(Date),
    Month = month(Date, label = TRUE),
    Week = week(Date)
  )


# UI Dashboard
ui <- dashboardPage(
  dashboardHeader(
    title = div(
      style = "display: flex; align-items: center; justify-content: flex-start;", 
      tags$img(
        src = "https://www.zarla.com/images/zarla-trenav-1x1-2400x2400-20230329-by3bpqvk9cjtghjmjy3w.png?crop=1:1,smart&width=250&dpr=2", 
        width = "80px", 
        style = "margin-right: 10px;"
      ), 
      tags$span(
        style = "font-size: 24px; font-weight: bold; color: white;",
        "Dairy Sales Dashboard"
      )
    ), 
    titleWidth = 250
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Analisis Deskriptif", tabName = "deskriptif", icon = icon("dashboard")),
      menuItem("Analisis Tren", tabName = "tren", icon = icon("line-chart")),
      menuItem("Analisis Regresi", tabName = "regression", icon = icon("chart-line")),
      menuItem("Analisis Korelasi", tabName = "correlation", icon = icon("search")),
      menuItem("Production Flow", tabName = "production_flow", icon = icon("sitemap")),
      menuItem("Informasi", tabName = "information", icon = icon("info-circle")), # New Information Tab
      selectInput("location", "Location", choices = c("All", unique(data$Location))),
      selectInput("sales_channel", "Sales Channel", choices = c("All", unique(data$Sales.Channel))),
      selectizeInput("product_input", "Product", choices = c("All", unique(data$Product.Name)), selected = "All", multiple = TRUE),
      radioButtons("time_aggregation", "Time Aggregation", choices = c("Year" = "Year", "Month" = "Month", "Week" = "Week"), selected = "Year")
    ),
    tags$head(tags$style(HTML("
      .sidebar {background-color: #333333; color: white;}
      .sidebar .user-panel a {color: white;}
      .sidebar-menu > li > a {color: white; font-weight: bold;}
      .sidebar-menu > li > a:hover {background-color: #4CAF50;}
      .sidebar-menu > li.active > a {background-color: #4CAF50;}
    ")))
  ),
  dashboardBody(
    tags$head(tags$style(HTML("
      .content-wrapper {background-color: #f4f4f9;}
      .box {border-radius: 10px; box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);}
      .box-primary {border-color: #4CAF50;}
    "))),
    tabItems(
      # Tab for Descriptive Analysis
      tabItem(
        tabName = "deskriptif",
        fluidRow(
          valueBoxOutput("total_sales_value", width = 4),
          valueBoxOutput("total_quantity_sold", width = 4),
          valueBoxOutput("total_of_Cows", width = 4)
        ),
        fluidRow(
          box(
            title = "Date Range", 
            status = "primary", solidHeader = TRUE, width = 12,
            sliderInput("date", "Date Range", min = min(data$Date), max = max(data$Date), value = c(min(data$Date), max(data$Date)), timeFormat = "%Y-%m-%d")
          )
        ),
        fluidRow(
          box(
            title = "Sales Overview (Bar Plot)",
            status = "primary", solidHeader = TRUE, width = 6,
            highchartOutput("barplot")
          ),
          box(
            title = "Brand Distribution (Donut Chart)",
            status = "primary", solidHeader = TRUE, width = 6,
            highchartOutput("donutchart")
          )
        ),
        fluidRow(
          box(
            title = "Sales by Product (Pie Chart)",
            status = "primary", solidHeader = TRUE, width = 6,
            highchartOutput("piechart")
          ),
          fluidRow(
            box(
              title = "Sales by Storage Condition (Bar Chart)",
              status = "primary",
              solidHeader = TRUE,
              width = 6,
              highchartOutput("sales_by_storage_condition")
            )
          ),
          box(
            title = "Detailed Sales Data",
            status = "primary", solidHeader = TRUE, width = 12,
            DTOutput("sales_data")
          )
        )
      ),
      # Tab for Trend Analysis (Updated with Insight Column)
      tabItem(
        tabName = "tren",
        fluidRow(
          box(
            title = "Total Revenue Trend (Line Plot)",
            status = "primary", solidHeader = TRUE, width = 10,
            highchartOutput("trendplot")
          ),
          box(
            title = "Insight",
            status = "primary", solidHeader = TRUE, width = 2,
            textOutput("insight_trendplot")
          )
        ),
        fluidRow(
          # Grafik untuk perbandingan total revenue berdasarkan Location
          box(
            title = "Perbandingan Total Revenue berdasarkan Location",
            status = "primary", solidHeader = TRUE, width = 10,
            highchartOutput("trend_by_location")
          ),
          box(
            title = "Insight",
            status = "primary", solidHeader = TRUE, width = 2,
            textOutput("insight_trend_by_location")
          )
        ),
        fluidRow(
          # Grafik untuk perbandingan total revenue berdasarkan Product
          box(
            title = "Perbandingan Total Revenue berdasarkan Produk",
            status = "primary", solidHeader = TRUE, width = 10,
            highchartOutput("trend_by_product")
          ),
          box(
            title = "Insight",
            status = "primary", solidHeader = TRUE, width = 2,
            textOutput("insight_trend_by_product")
          )
        ),
        fluidRow(
          # Grafik untuk perbandingan total revenue berdasarkan Sales Channel
          box(
            title = "Perbandingan Total Revenue berdasarkan Sales Channel",
            status = "primary", solidHeader = TRUE, width = 10,
            highchartOutput("trend_by_sales_channel")
          ),
          box(
            title = "Insight",
            status = "primary", solidHeader = TRUE, width = 2,
            textOutput("insight_trend_by_sales_channel")
          )
        )
      ),
      # Tab for Regression Analysis
      tabItem(
        tabName = "regression",
        fluidRow(
          box(
            title = "Pilih Variabel Dependen dan Independen",
            status = "primary", solidHeader = TRUE, width = 4,
            selectInput("dependent_var", "Variabel Dependen:", 
                        choices = names(data)[sapply(data, is.numeric)], 
                        selected = "Total.Value"),
            selectInput("independent_vars", "Variabel Independen:", 
                        choices = names(data)[sapply(data, is.numeric)], 
                        multiple = TRUE,
                        selected = c("Price.per.Unit", "Quantity.Sold..liters.kg."))
          )
        ),
        fluidRow(
          box(
            title = "Hasil Analisis Regresi Berganda",
            status = "primary", solidHeader = TRUE, width = 12,
            verbatimTextOutput("regression_output")
          )
        ),
        fluidRow(
          box(
            title = "Hasil Uji Asumsi Regresi",
            status = "primary", solidHeader = TRUE, width = 12,
            verbatimTextOutput("assumption_tests")
          )
        ),
        fluidRow(
          box(
            title = "Keputusan dan Kesimpulan",
            status = "primary", solidHeader = TRUE, width = 12,
            DTOutput("conclusion")  # Using DTOutput to render the table
          )
        )
      ),
      # Tab for Correlation Analysis
      tabItem(
        tabName = "correlation",
        fluidRow(
          box(
            title = "Pilih Variabel Respon",
            status = "primary", solidHeader = TRUE, width = 4,
            selectInput("response_var", "Variabel Respon:", 
                        choices = names(data)[sapply(data, is.numeric)], 
                        selected = "Total.Value")
          ),
          box(
            title = "Pilih Variabel Bebas",
            status = "primary", solidHeader = TRUE, width = 4,
            selectInput("independent_vars", "Variabel Bebas:",
                        choices = names(data)[sapply(data, is.numeric)], 
                        selected = c("Price.per.Unit", "Quantity.Sold..liters.kg."),
                        multiple = TRUE)
          )
        ),
        fluidRow(
          box(
            title = "Heatmap Korelasi",
            status = "primary", solidHeader = TRUE, width = 12,
            plotOutput("correlation_heatmap")
          )
        ),
        fluidRow(
          box(
            title = "Hasil Korelasi",
            status = "primary", solidHeader = TRUE, width = 12,
            verbatimTextOutput("correlation_output")
          )
        ),
        # Menampilkan kesimpulan korelasi
        fluidRow(
          box(
            title = "Kesimpulan Korelasi",
            status = "primary", solidHeader = TRUE, width = 12,
            verbatimTextOutput("correlation_conclusion")
          )
        )
      ),
      tabItem(
        tabName = "production_flow",
        fluidRow(
          box(
            title = "Pilih Tahun",
            status = "primary", solidHeader = TRUE, width = 4,
            selectInput(
              "year_input", 
              "Tahun:", 
              choices = unique(data$Year), 
              selected = max(data$Year)
            )
          )
        ),
        fluidRow(
          box(
            title = "Production Flow Alluvial Plot",
            status = "primary", solidHeader = TRUE, width = 12,
            plotOutput("alluvial_plot", height = "600px")
          )
        ),
        fluidRow(
          # Add a new box for the travel map
          box(
            title = "Map Perjalanan Produk",
            status = "primary", solidHeader = TRUE, width = 12,
            selectInput("product_name_map", "Pilih Produk", choices = unique(data$Product.Name)),
            leafletOutput("product_map", height = "400px")
          )
        )
      ),
      # Add a new tabItem for Information content in the tabItems
      tabItem(
        tabName = "information",
        fluidRow(
          box(
            title = "Dashboard Analisis Penjualan Produk Susu (DAPS)",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p align="center" width="100%">
             <img width="100%" src="https://github.com/YuniaHasnataeni/Tugas-Dashboard/blob/main/Gambar/Dairy%20Goods.png?raw=true">
           </p>'),
            
            HTML('<div align="center">
              <h3>Dashboard Analisis Penjualan Produk Susu (DAPS)</h3>
              <p><a href="#information_source-tentang">Tentang</a> • 
                 <a href="#blue_book-Library_yang_Digunakan">Library</a> • 
                 <a href="#bar_chart-Dataset">Dataset</a> • 
                 <a href="#bookmark_tabs-Referensi">Referensi</a> • 
                 <a href="#busts_in_silhouette-tim">Tim Pengembang</a>
              </p>
            </div>'
            )
          ),
          box(
            title = "Tentang Aplikasi",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p><strong>Aplikasi Dashboard Penjualan Produk Susu:</strong><br>
            <p>Aplikasi ini bertujuan untuk melakukan analisis deskriptif, regresi linier sederhana, dan analisis tren terhadap data penjualan produk susu. Dashboard ini menyediakan visualisasi interaktif untuk mempermudah pengguna dalam menganalisis distribusi, hubungan antar variabel, dan tren yang terjadi pada data penjualan susu.</p>')
          ),
          box(
            title = "Statistik Deskriptif",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p>Statistik deskriptif digunakan untuk merangkum data dan memberikan gambaran umum tentang distribusi dan karakteristik utama dari dataset. Elemen utama meliputi:</p>
            <ul>
              <li><strong>Rata-rata (Mean)</strong>: Nilai pusat yang dihitung dari jumlah total data dibagi jumlah data.</li>
              <li><strong>Median</strong>: Nilai tengah dari dataset yang telah diurutkan.</li>
              <li><strong>Nilai Minimum & Maksimum</strong>: Nilai terkecil dan terbesar dalam dataset.</li>
              <li><strong>Kuartil (Q1 & Q3)</strong>: Membagi data menjadi empat bagian yang sama besar, dengan Q1 memisahkan 25% data pertama dan Q3 memisahkan 75%.</li>
              <li><strong>Rentang Interkuartil (IQR)</strong>: Selisih antara Q3 dan Q1, menggambarkan penyebaran data tanpa pengaruh outliers.</li>
            </ul>')
          ),
          box(
            title = "Analisis Korelasi",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p>Analisis korelasi adalah metode statistik yang digunakan untuk mengukur dan menggambarkan kekuatan serta arah hubungan antara dua variabel. Korelasi mengukur sejauh mana dua variabel bergerak bersama, apakah mereka berhubungan secara positif (kedua variabel meningkat atau menurun bersama) atau negatif (satu variabel meningkat sementara yang lain menurun).</p>')
          ),
          box(
            title = "Regresi Linier Berganda",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p>Regresi linier berganda adalah metode statistik yang digunakan untuk menganalisis hubungan antara satu variabel dependen (Y) dan dua atau lebih variabel independen (X₁, X₂, ..., Xn). Tujuan dari analisis ini adalah untuk memodelkan hubungan linier antara variabel-variabel tersebut dan membuat prediksi berdasarkan data yang ada.</p>
            <p><strong>Model:</strong><br>
              Y = β₀ + β₁X₁ + β₂X₂ + ... + βnXn + ϵ</p>
            <p>Di mana:
              <ul>
                <li><strong>Y</strong> = Variabel dependen (terikat)</li>
                <li><strong>X₁, X₂, ..., Xn</strong> = Variabel independen (bebas)</li>
                <li><strong>β₀</strong> = Intersep (nilai Y ketika semua X = 0)</li>
                <li><strong>β₁, β₂, ..., βn</strong> = Koefisien regresi (menunjukkan pengaruh masing-masing X terhadap Y)</li>
                <li><strong>ϵ</strong> = Sisaan (error term) yang merepresentasikan variasi dalam Y yang tidak dijelaskan oleh variabel X.</li>
              </ul>
            <p><strong>Uji Asumsi:</strong><br>
              <ul>
              <li><strong>Linearitas</strong>: Hubungan antara variabel dependen dan independen bersifat linier.</li>
              <li><strong>Independensi</strong>: Data yang digunakan harus independen satu sama lain.</li>
              <li><strong>Homoskedastisitas</strong>: Variansi sisaan harus konstan di seluruh rentang nilai X.</li>
              <li><strong>Normalitas Sisaan</strong>: Sisaan harus terdistribusi normal.</li>
              <li><strong>Multikolinearitas</strong>: Tidak ada hubungan linier yang kuat antar variabel independen.</li>
              </ul>
              </p>')
          ),
          box(
            title = "Analisis Tren",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p>Analisis tren digunakan untuk mempelajari perubahan data seiring waktu guna mengidentifikasi pola atau arah pergerakan data. Analisis ini dapat membantu dalam meramalkan nilai masa depan berdasarkan tren yang teridentifikasi dalam data historis.</p>
            <p><strong>Jenis-jenis Analisis Tren:</strong><br>
              <ul>
                <li><strong>Tren Naik</strong>: Data yang menunjukkan peningkatan secara konsisten seiring waktu.</li>
                <li><strong>Tren Turun</strong>: Data yang menunjukkan penurunan secara konsisten seiring waktu.</li>
                <li><strong>Fluktuasi</strong>: Perubahan yang tidak mengikuti pola tetap, tetapi menunjukkan variasi acak.</li>
              </ul>
            </p>')
          ),
          box(
            title = "Library yang Digunakan",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p><strong>Library yang Digunakan</strong>:<br>Berikut adalah beberapa library R yang digunakan dalam aplikasi ini:</p>
            <ul>
              <li><strong>shiny</strong>: Library utama untuk membuat aplikasi web interaktif di R.</li>
              <li><strong>shinydashboard</strong>: Digunakan untuk membuat antarmuka dashboard di aplikasi Shiny.</li>
              <li><strong>dplyr</strong>: Untuk manipulasi data efisien.</li>
              <li><strong>highcharter</strong>: Untuk membuat visualisasi interaktif dengan grafik Highcharts.</li>
              <li><strong>DT</strong>: Untuk menampilkan data dalam tabel interaktif.</li>
              <li><strong>lubridate</strong>: Memudahkan manipulasi data waktu.</li>
              <li><strong>car</strong>: Untuk analisis regresi dan uji diagnostik.</li>
              <li><strong>ggalluvial</strong>: Untuk membuat visualisasi alur.</li>
              <li><strong>reshape2</strong>: Untuk merubah bentuk data.</li>
              <li><strong>lmtest</strong>: Untuk melakukan uji statistik pada model regresi.</li>
              <li><strong>Metrics</strong>: Untuk menghitung metrik evaluasi model.</li>
              <li><strong>leaflet</strong>: Untuk membuat peta interaktif.</li>
              <li><strong>tidygeocoder</strong>: Untuk geocoding (mengonversi alamat ke koordinat).</li>
            </ul>')
          ),
          box(
            title = "Dataset",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p><strong>Dataset Penjualan Produk Susu:</strong><br>Dataset ini berisi informasi mengenai peternakan sapi perah, produk susu, penjualan, dan manajemen persediaan. Dataset ini dapat digunakan untuk analisis tren, peramalan permintaan, dan optimasi persediaan. Berikut adalah fitur dan karakteristik dari dataset ini:</p>
            <p><strong>Variabel Terikat:</strong><br>
              <ul>
                <li><strong>Nilai Total</strong> : Total nilai produk susu berdasarkan kuantitas yang tersedia.</p>
              </ul>
            <p><strong>Variabel Bebas:</strong><br>
              <ul>
                <li><strong>Lokasi</strong>: Lokasi geografis peternakan sapi perah yang dapat mempengaruhi faktor-faktor seperti cuaca, pasokan, dan permintaan produk susu.</li>
                <li><strong>Nama Produk</strong>: Nama produk susu yang dijual, seperti susu segar, yogurt, keju, atau produk turunannya.</li>
                <li><strong>Merek</strong>: Nama merek yang memproduksi produk susu, yang dapat mempengaruhi preferensi konsumen dan harga jual.</li>
                <li><strong>Jumlah (liter/kg)</strong>: Jumlah total produk susu yang tersedia untuk dijual dalam satuan liter atau kilogram.</li>
                <li><strong>Harga per Unit</strong>: Harga satuan untuk produk susu yang ditetapkan pada saat penjualan.</li>
                <li><strong>Jumlah Terjual (liter/kg)</strong>: Kuantitas produk susu yang telah terjual selama periode tertentu, diukur dalam liter atau kilogram.</li>
                <li><strong>Harga per Unit (terjual)</strong>: Harga aktual produk susu pada saat penjualan, bisa lebih rendah atau lebih tinggi dari harga standar per unit.</li>
                <li><strong>Jumlah Stok (liter/kg)</strong>: Kuantitas produk susu yang masih tersedia di gudang atau tempat penyimpanan.</li>
                <li><strong>Batas Minimum Stok (liter/kg)</strong>: Batas stok minimum untuk menghindari kekurangan produk dan memastikan ketersediaan pasokan yang stabil.</li>
                <li><strong>Date</strong>: Tanggal pencatatan data, menunjukkan waktu transaksi atau pengukuran stok produk susu.</li>
                <li><strong>Ukuran Peternakan (sq.km)</strong>: Ukuran fisik peternakan dalam satuan kilometer persegi, yang berhubungan dengan kapasitas produksi susu.</li>
                <li><strong>Kondisi Penyimpanan</strong>: Kondisi penyimpanan yang disarankan untuk produk susu, seperti suhu dan kelembapan, yang mempengaruhi kualitas dan umur simpan produk.</li>
                <li><strong>Luas Lahan (acre)</strong>: Luas total lahan yang ditempati oleh peternakan sapi perah, yang berhubungan langsung dengan volume produksi susu dan jumlah sapi.</li>
                <li><strong>Saluran Penjualan</strong>: Saluran melalui mana produk susu dijual (Retail, Grosir, Online), yang mempengaruhi strategi pemasaran dan distribusi.</li>
                <li><strong>Jumlah Sapi</strong>: Jumlah sapi yang ada di peternakan sapi perah, yang berhubungan langsung dengan volume produksi susu.</li>
              </ul>
              </p>
            <p><strong>Cara Mengakses Dataset:</strong> Dataset ini dapat diakses melalui <a href="https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset">tautan ini</a>.</p>')
          ),
          box(
            title = "Referensi",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p><strong>Referensi:</strong><br>
            <ol>
              <li>Munawir, S. (2010), “Analisa Laporan Keuangan”. Yogyakarta: Liberty.</li>
              <li>Rifai, A. (2019). "Penerapan Statistik Deskriptif dalam Analisis Data Penjualan Produk". Jurnal Ilmu dan Teknologi 4(1), 45-52.</li>
              <li>Suraj. (2021). Dairy Goods Sales Dataset. Kaggle. <a href="https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset">https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset</a></li>
              <li>Utari, Dina Tri. (2019). Analisis Regresi Terapan dengan R. Yogyakarta. Universitas Islam Indonesia</li>
            </ol>')
          ),
          box(
            title = "Tim Pengembang",
            status = "primary", solidHeader = TRUE, width = 12,
            HTML('<p><strong>Dosen Pengampu:</strong><br>Dr. Anwar Fitrianto, S.Si., M.Sc.<br>Dr. Ir. Erfiani, M.Si.<br>L.M Risman Dwi Jumansyah S.Stat</p>
            <p><strong>Kelompok Mahasiswa:</strong><br>Yunia Hasnataeni (G1501231001)<br>Kevin Alifviansyah (G1501231018)<br>Rafika Aristawidya (G1501231065)</p>')
          )
        )
      )
    )
  )
)



# Server function
server <- function(input, output, session) {
  
  # Filter data based on selected year for alluvial plot
  filtered_data <- reactive({
    data %>% filter(Year == input$year_input)
  })
  
  # Alluvial plot
  # Render Alluvial plot
  output$alluvial_plot <- renderPlot({
    req(nrow(filtered_data()) > 0)
    alluvial_data <- filtered_data() %>%
      select(Location, Farm.Size, Product.Name, Customer.Location, Sales.Channel) %>%
      mutate(
        Farm.Size = as.factor(Farm.Size),
        Product.Name = as.factor(Product.Name),
        Customer.Location = as.factor(Customer.Location),
        Sales.Channel = as.factor(Sales.Channel)
      )
    
    # Membuat Alluvial plot
    ggplot(data = alluvial_data, aes(axis1 = Location, axis2 = Farm.Size, axis3 = Product.Name, axis4 = Customer.Location, axis5 = Sales.Channel)) +
      geom_alluvium(aes(fill = Location), alpha = 0.75) +
      geom_stratum() +
      geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
      scale_x_discrete(
        limits = c("Location", "Farm Size", "Product Name", "Customer Location", "Sales Channel"),
        expand = c(0.1, 0.1)
      ) +
      theme_minimal() +
      labs(
        title = "Production Flow",
        x = "Flow Components",
        y = "Frequency",
        fill = "Location"
      )
  })
  
  # Map perjalanan produk
  output$product_map <- renderLeaflet({
    req(input$product_name_map)
    
    # Filter data berdasarkan nama produk (untuk map), sales channel, dan rentang tanggal
    filtered_data_map <- data %>%
      filter(Product.Name == input$product_name_map)
    
    # Geocode lokasi jika belum ada koordinat (gunakan tidygeocoder)
    geocoded_data <- filtered_data_map %>%
      distinct(Location) %>%
      geocode(Location, method = "osm")  # Geocoding menggunakan OpenStreetMap
    
    # Gabungkan koordinat kembali ke data
    mapped_data <- filtered_data_map %>%
      left_join(geocoded_data, by = "Location")
    
    # Warna untuk garis berdasarkan produk atau lokasi
    color_palette <- colorFactor(palette = "Set1", domain = mapped_data$Location)
    
    # Buat peta menggunakan leaflet
    leaflet(mapped_data) %>%
      addTiles() %>%
      addMarkers(
        lng = ~long, lat = ~lat,
        popup = ~paste("Location:", Location, "<br>",
                       "Quantity Sold:", Quantity.Sold..liters.kg.)
      ) %>%
      addPolylines(
        lng = ~long, lat = ~lat, group = ~Product.Name,
        color = ~color_palette(Location), weight = 2  # Gunakan warna berbeda
      )
  })
  
  
  # Korelasi
  # Reactive data untuk memilih variabel respon dan bebas
  filtered_data <- reactive({
    data %>%
      filter(
        (Location == input$location | input$location == "All"),
        (Date >= input$date[1] & Date <= input$date[2]),
        (Sales.Channel == input$sales_channel | input$sales_channel == "All"),
        (Product.Name == input$product_input | input$product_input == "All")
      )
  })
  
  # Korelasi dan heatmap
  output$correlation_output <- renderPrint({
    # Menyiapkan data untuk korelasi
    data_for_corr <- filtered_data()[, c(input$response_var, input$independent_vars)]
    # Menghitung korelasi antar variabel
    correlation_matrix <- cor(data_for_corr, use = "complete.obs")
    print(correlation_matrix)
  })
  
  # Membuat heatmap korelasi
  output$correlation_heatmap <- renderPlot({
    library(ggplot2)
    library(reshape2)
    
    # Menyiapkan data untuk korelasi
    data_for_corr <- filtered_data()[, c(input$response_var, input$independent_vars)]
    correlation_matrix <- cor(data_for_corr, use = "complete.obs")
    
    # Merubah data menjadi format yang sesuai untuk heatmap
    melted_corr <- melt(correlation_matrix)
    
    # Membuat heatmap dengan ggplot2
    ggplot(melted_corr, aes(Var1, Var2, fill = value)) +
      geom_tile() +
      scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1)) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Heatmap Korelasi", x = "Variabel", y = "Variabel")
  })
  
  # Filter data berdasarkan input pengguna
  filtered_data <- reactive({
    data %>%
      filter(
        (Location == input$location | input$location == "All"),
        (Date >= input$date[1] & Date <= input$date[2]),
        (Sales.Channel == input$sales_channel | input$sales_channel == "All"),
        (Product.Name %in% input$product_input | "All" %in% input$product_input)
      )
  })
  
  # Hasil Korelasi dan Kesimpulan Korelasi
  output$correlation_conclusion <- renderPrint({
    # Menyiapkan data untuk korelasi
    data_for_corr <- filtered_data()[, c(input$response_var, input$independent_vars)]
    
    # Menghitung korelasi antar variabel
    correlation_matrix <- cor(data_for_corr, use = "complete.obs")
    
    # Menambahkan kesimpulan korelasi
    correlation_conclusion <- sapply(1:ncol(correlation_matrix), function(i) {
      sapply(1:nrow(correlation_matrix), function(j) {
        if (abs(correlation_matrix[i, j]) > 0.7) {
          paste("Korelasi kuat antara", colnames(correlation_matrix)[i], "dan", rownames(correlation_matrix)[j])
        } else if (abs(correlation_matrix[i, j]) > 0.4) {
          paste("Korelasi sedang antara", colnames(correlation_matrix)[i], "dan", rownames(correlation_matrix)[j])
        } else {
          paste("Korelasi lemah antara", colnames(correlation_matrix)[i], "dan", rownames(correlation_matrix)[j])
        }
      })
    })
    
    # Menampilkan kesimpulan korelasi
    return(correlation_conclusion)
  })
  
  
  # Regresi
  # Filter data untuk analisis regresi
  filtered_data_for_analysis <- reactive({
    data %>%
      filter(
        (Location == input$location | input$location == "All"),
        (Date >= input$date[1] & Date <= input$date[2]),
        (Sales.Channel == input$sales_channel | input$sales_channel == "All"),
        (Product.Name %in% input$product_input | "All" %in% input$product_input)
      )
  })
  
  # Model regresi
  regression_model <- reactive({
    req(input$dependent_var, input$independent_vars)  # Pastikan input tersedia
    
    # Pastikan ada variabel independen yang dipilih
    if(length(input$independent_vars) < 1) {
      return(NULL)  # Kembalikan NULL jika tidak ada variabel independen
    }
    
    reg_data <- filtered_data_for_analysis() %>%
      select(input$dependent_var, all_of(input$independent_vars)) %>%
      filter(complete.cases(.))  # Hapus baris yang memiliki NA
    
    # Periksa apakah data valid sebelum membangun model regresi
    if (nrow(reg_data) > 0) {
      lm(as.formula(paste(input$dependent_var, "~", paste(input$independent_vars, collapse = "+"))), data = reg_data)
    } else {
      return(NULL)  # Kembalikan NULL jika data tidak cukup untuk regresi
    }
  })
  
  # Menampilkan output regresi
  output$regression_output <- renderPrint({
    lm_model <- regression_model()
    if (is.null(lm_model)) {
      return("Model regresi tidak dapat dihitung karena data tidak cukup atau tidak valid.")
    } else {
      summary(lm_model)  # Menampilkan ringkasan model regresi
    }
  })
  
  
  # Uji asumsi regresi (normalitas, homoskedastisitas, linearitas, multikolinieritas)
  output$assumption_tests <- renderPrint({
    lm_model <- regression_model()
    
    if (is.null(lm_model)) {
      return("Model regresi tidak dapat dihitung.")
    }
    
    # Uji normalitas
    shapiro_test <- tryCatch({
      shapiro.test(residuals(lm_model))  # Uji Normalitas
    }, error = function(e) NULL)  # Jika error, kembalikan NULL
    
    # Uji homoskedastisitas
    bp_test <- tryCatch({
      bptest(lm_model)  # Uji Homoskedastisitas
    }, error = function(e) NULL)
    
    # Uji linearitas
    rainbow_test <- tryCatch({
      linearHypothesis(lm_model, paste(input$independent_vars, collapse = " + "), test = "Chisq")  # Uji Linearitas
    }, error = function(e) NULL)
    
    # Uji multikolinieritas
    vif_test <- tryCatch({
      vif(lm_model)  # Uji Multikolineritas
    }, error = function(e) NULL)
    
    # Menampilkan hasil uji asumsi
    cat("Uji Normalitas (Shapiro-Wilk):\n")
    print(shapiro_test)
    cat("\nUji Homoskedastisitas (Breusch-Pagan):\n")
    print(bp_test)
    cat("\nUji Linearitas (Rainbow Test):\n")
    print(rainbow_test)
    cat("\nUji Multikolineritas (VIF):\n")
    print(vif_test)
  })
  
  # Keputusan dan Kesimpulan dari analisis regresi dan uji asumsi
  output$conclusion <- renderDT({
    data_filtered <- filtered_data_for_analysis()
    req(nrow(data_filtered) > 0)  # Pastikan data tidak kosong
    
    # Melakukan regresi jika data valid
    regression_model <- lm(as.formula(paste(input$dependent_var, "~", paste(input$independent_vars, collapse = "+"))), data = data_filtered)
    
    # Melakukan uji asumsi
    shapiro_test <- tryCatch({
      shapiro.test(residuals(regression_model))  # Uji normalitas
    }, error = function(e) NULL)
    
    bp_test <- tryCatch({
      bptest(regression_model)  # Uji homoskedastisitas
    }, error = function(e) NULL)
    
    rainbow_test <- tryCatch({
      linearHypothesis(regression_model, paste(input$independent_vars, collapse = " + "), test = "Chisq")  # Uji linearitas
    }, error = function(e) NULL)
    
    vif_test <- tryCatch({
      vif(regression_model)  # Uji multikolinieritas
    }, error = function(e) NULL)
    
    # Menggabungkan hasil uji asumsi menjadi kesimpulan
    conclusion <- data.frame(
      Test = c("Significant Relationship", "Normality Test (Shapiro-Wilk)", "Homoscedasticity Test (Breusch-Pagan)",
               "Linearity Test (Rainbow Test)", "Multicollinearity (VIF)"),
      Decision = c(
        ifelse(summary(regression_model)$coefficients[2, 4] < 0.05, 
               paste("Hubungan signifikan antara", input$dependent_var, "dan", paste(input$independent_vars, collapse = ", ")), 
               paste("Tidak ada hubungan signifikan antara", input$dependent_var, "dan", paste(input$independent_vars, collapse = ", "))),
        ifelse(!is.null(shapiro_test) && shapiro_test$p.value > 0.05, 
               "Residual terdistribusi normal (p-value > 0.05)", 
               "Residual tidak terdistribusi normal (p-value < 0.05)"),
        ifelse(!is.null(bp_test) && bp_test$p.value > 0.05, 
               "Tidak ada masalah heteroskedastisitas (p-value > 0.05)", 
               "Data menunjukkan masalah heteroskedastisitas (p-value < 0.05)"),
        ifelse(!is.null(rainbow_test) && rainbow_test$`Pr(>Chi)`[2] > 0.05, 
               "Data menunjukkan hubungan linear (p-value > 0.05)", 
               "Data tidak menunjukkan hubungan linear (p-value < 0.05)"),
        ifelse(!is.null(vif_test) && max(vif_test) < 10, 
               "Tidak ada masalah multikolinieritas (VIF < 10)", 
               "Ada masalah multikolinieritas (VIF >= 10)")
      )
    )
    
    # Menampilkan kesimpulan sebagai tabel
    datatable(conclusion)
  })
  
  
  
  # Deskriptif
  # Output: Value Box - Total Sales Value
  output$total_sales_value <- renderValueBox({
    total_value <- filtered_data_for_analysis() %>%
      summarize(Total = sum(Total.Value, na.rm = TRUE)) %>%
      pull(Total)
    
    valueBox(
      value = paste0("$", formatC(total_value, format = "f", big.mark = ",", digits = 2)),
      subtitle = "Total Sales Value",
      icon = icon("dollar-sign"),
      color = "green"
    )
  })
  
  # Output: Value Box - Total Quantity Sold
  output$total_quantity_sold <- renderValueBox({
    total_quantity <- filtered_data_for_analysis() %>%
      summarize(Total = sum(Quantity.Sold..liters.kg., na.rm = TRUE)) %>%
      pull(Total)
    
    valueBox(
      value = formatC(total_quantity, format = "f", big.mark = ",", digits = 2),
      subtitle = "Total Quantity Sold (liters/kg)",
      icon = icon("shopping-cart"),
      color = "blue"
    )
  })
  
  # Output: Value Box - Total Number of Cows
  output$total_of_Cows <- renderValueBox({
    total_cows <- filtered_data_for_analysis() %>%
      summarize(Total = sum(Number.of.Cows, na.rm = TRUE)) %>%
      pull(Total)
    
    valueBox(
      value = total_cows,
      subtitle = "Total Number of Cows",
      icon = icon("cow"),
      color = "orange"
    )
  })
  
  # Output: Bar Plot with Different Contrasting Colors
  output$barplot <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>% 
      group_by(Product.Name) %>% 
      summarize(Total_Sales = sum(Quantity.Sold..liters.kg., na.rm = TRUE)) %>% 
      arrange(desc(Total_Sales))
    
    # Generate a contrasting and vibrant color palette (Paired for contrasting colors)
    color_palette <- RColorBrewer::brewer.pal(n = nrow(data_plot), name = "Paired")  # Use "Paired" for contrasting colors
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_xAxis(categories = data_plot$Product.Name) %>% 
      hc_yAxis(title = list(text = "Total Quantity Sold (liters/kg)")) %>% 
      hc_add_series(
        data = data_plot$Total_Sales, 
        name = "Product",
        colorByPoint = TRUE,  # Assign a different color for each bar
        colors = color_palette  # Use the generated color palette
      ) %>% 
      hc_title(text = "Sales by Product")
  })
  
  # Output: Donut Chart with Contrasting Colors
  output$donutchart <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>% 
      group_by(Brand) %>% 
      summarize(Total_Sales = sum(Quantity.Sold..liters.kg., na.rm = TRUE)) %>% 
      arrange(desc(Total_Sales))
    
    # Use the same contrasting color palette from the bar chart
    color_palette <- RColorBrewer::brewer.pal(n = nrow(data_plot), name = "Paired")  # Same contrasting colors
    
    highchart() %>% 
      hc_chart(type = "pie") %>% 
      hc_plotOptions(pie = list(innerSize = "60%", dataLabels = list(enabled = TRUE))) %>% 
      hc_add_series(
        name = "Total Quantity Sold", 
        data = list_parse(data_plot %>% mutate(name = Brand, y = Total_Sales)),
        colors = color_palette  # Use the same color palette
      ) %>% 
      hc_title(text = "Sales by Brand (Donut Chart)")
  })
  
  # Output: Pie Chart with Contrasting Colors
  output$piechart <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>% 
      group_by(Product.Name) %>% 
      summarize(Total_Sales = sum(Quantity.Sold..liters.kg., na.rm = TRUE))
    
    # Use the same contrasting color palette from the bar chart
    color_palette <- RColorBrewer::brewer.pal(n = nrow(data_plot), name = "Paired")  # Same contrasting colors
    
    highchart() %>% 
      hc_chart(type = "pie") %>% 
      hc_plotOptions(pie = list(dataLabels = list(enabled = TRUE))) %>% 
      hc_add_series(
        name = "Sales", 
        data = list_parse(data_plot %>% mutate(name = Product.Name, y = Total_Sales)),
        colors = color_palette  # Use the same color palette
      ) %>% 
      hc_title(text = "Sales by Product (Pie Chart)")
  })
  
  # Output: Sales by Storage Condition Bar Chart with Contrasting Colors
  output$sales_by_storage_condition <- renderHighchart({
    # Mengelompokkan data berdasarkan Storage Condition dan menghitung Total Sales
    data_plot <- filtered_data_for_analysis() %>% 
      group_by(Storage.Condition) %>% 
      summarize(Total_Sales = sum(Total.Value, na.rm = TRUE)) %>% 
      arrange(desc(Total_Sales))
    
    # Use the same contrasting color palette from the bar chart
    color_palette <- RColorBrewer::brewer.pal(n = nrow(data_plot), name = "Paired")  # Same contrasting colors
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_xAxis(categories = data_plot$Storage.Condition) %>% 
      hc_yAxis(title = list(text = "Total Sales")) %>% 
      hc_add_series(
        data = data_plot$Total_Sales,
        name = "Storage Condition", 
        colorByPoint = TRUE,  # Warna berbeda untuk setiap kategori
        colors = color_palette  # Use the same color palette as other charts
      ) %>% 
      hc_title(text = "Sales by Storage Condition")
  })
  
  
  # Tren
  # Filter data berdasarkan tahun minimum dan maksimum
  filtered_data_for_analysis <- reactive({
    data %>%
      filter(
        (Location == input$location | input$location == "All"),
        (Date >= input$date[1] & Date <= input$date[2]),
        (Sales.Channel == input$sales_channel | input$sales_channel == "All"),
        (Product.Name %in% input$product_input | "All" %in% input$product_input)
      )
  })
  
  # Untuk memastikan data tren mencakup tahun minimum dan maksimum
  min_year <- min(data$Year, na.rm = TRUE)  # Menentukan tahun minimum
  max_year <- max(data$Year, na.rm = TRUE)  # Menentukan tahun maksimum
  
  # Output: Revenue Trend Plot (pastikan data mencakup rentang tahun minimum dan maksimum)
  output$trendplot <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>%
      group_by_at(vars(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop") %>%
      arrange(get(input$time_aggregation))
    
    if (nrow(data_plot) == 0) {
      return(highchart() %>% hc_title(text = "No data available for selected filters"))
    }
    
    highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = seq(min_year, max_year, by = 1)) %>%  # Sumbu X akan mencakup tahun dari minimum ke maksimum
      hc_yAxis(title = list(text = "Total Revenue (INR)")) %>%
      hc_add_series(name = "Tahun", data = data_plot$Total_Revenue) %>%
      hc_title(text = "Total Revenue Trend")
  })
  
  # Output: Tren Total Revenue berdasarkan Location
  output$trend_by_location <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>%
      group_by(Location, !!sym(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop") %>%
      arrange(!!sym(input$time_aggregation))
    
    if (nrow(data_plot) == 0) {
      return(highchart() %>% hc_title(text = "No data available for selected filters"))
    }
    
    color_palette <- RColorBrewer::brewer.pal(n = length(unique(data_plot$Location)), name = "Set3")
    
    hc <- highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = seq(min_year, max_year, by = 1)) %>%  # Sumbu X mencakup rentang tahun
      hc_yAxis(title = list(text = "Total Revenue (INR)")) %>%
      hc_title(text = "Perbandingan Total Revenue Berdasarkan Location")
    
    for (i in 1:length(unique(data_plot$Location))) {
      loc <- unique(data_plot$Location)[i]
      hc <- hc %>%
        hc_add_series(
          data = data_plot[data_plot$Location == loc, ]$Total_Revenue,
          name = loc,
          lineWidth = 2,
          color = color_palette[i]
        )
    }
    
    return(hc)
  })
  
  # Output: Tren Total Revenue berdasarkan Produk
  output$trend_by_product <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>%
      group_by(Product.Name, !!sym(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop") %>%
      arrange(!!sym(input$time_aggregation))
    
    if (nrow(data_plot) == 0) {
      return(highchart() %>% hc_title(text = "No data available for selected filters"))
    }
    
    color_palette <- RColorBrewer::brewer.pal(n = length(unique(data_plot$Product.Name)), name = "Set2")
    
    hc <- highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = seq(min_year, max_year, by = 1)) %>%  # Sumbu X mencakup rentang tahun
      hc_yAxis(title = list(text = "Total Revenue (INR)")) %>%
      hc_title(text = "Perbandingan Total Revenue Berdasarkan Produk")
    
    for (i in 1:length(unique(data_plot$Product.Name))) {
      prod <- unique(data_plot$Product.Name)[i]
      hc <- hc %>%
        hc_add_series(
          data = data_plot[data_plot$Product.Name == prod, ]$Total_Revenue,
          name = prod,
          lineWidth = 2,
          color = color_palette[i]
        )
    }
    
    return(hc)
  })
  
  # Output: Tren Total Revenue berdasarkan Sales Channel
  output$trend_by_sales_channel <- renderHighchart({
    data_plot <- filtered_data_for_analysis() %>%
      group_by(Sales.Channel, !!sym(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop") %>%
      arrange(!!sym(input$time_aggregation))
    
    if (nrow(data_plot) == 0) {
      return(highchart() %>% hc_title(text = "No data available for selected filters"))
    }
    
    color_palette <- RColorBrewer::brewer.pal(n = length(unique(data_plot$Sales.Channel)), name = "Set1")
    
    hc <- highchart() %>%
      hc_chart(type = "line") %>%
      hc_xAxis(categories = seq(min_year, max_year, by = 1)) %>%  # Sumbu X mencakup rentang tahun
      hc_yAxis(title = list(text = "Total Revenue (INR)")) %>%
      hc_title(text = "Perbandingan Total Revenue Berdasarkan Sales Channel")
    
    for (i in 1:length(unique(data_plot$Sales.Channel))) {
      channel <- unique(data_plot$Sales.Channel)[i]
      hc <- hc %>%
        hc_add_series(
          data = data_plot[data_plot$Sales.Channel == channel, ]$Total_Revenue,
          name = channel,
          lineWidth = 2,
          color = color_palette[i]
        )
    }
    
    return(hc)
  })
  
  # Filter data berdasarkan filter yang dipilih
  filtered_data_for_analysis <- reactive({
    data %>%
      filter(
        (Location == input$location | input$location == "All"),
        (Date >= input$date[1] & Date <= input$date[2]),
        (Sales.Channel == input$sales_channel | input$sales_channel == "All"),
        (Product.Name %in% input$product_input | "All" %in% input$product_input)
      )
  })
  
  # Output: Insight untuk Tren Total Revenue
  output$insight_trendplot <- renderText({
    total_revenue_trend <- filtered_data_for_analysis() %>%
      group_by_at(vars(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop")
    
    if (nrow(total_revenue_trend) > 0) {
      return(paste("Tren total pendapatan menunjukkan", 
                   ifelse(total_revenue_trend$Total_Revenue[nrow(total_revenue_trend)] > total_revenue_trend$Total_Revenue[1], 
                          "peningkatan", "penurunan"), 
                   "selama periode yang dipilih."))
    } else {
      return("Tidak ada data yang tersedia untuk filter yang dipilih.")
    }
  })
  
  # Output: Insight untuk Tren Revenue Berdasarkan Location
  output$insight_trend_by_location <- renderText({
    revenue_by_location <- filtered_data_for_analysis() %>%
      group_by(Location, !!sym(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop")
    
    if (nrow(revenue_by_location) > 0) {
      location_selected <- input$location
      
      # Memberikan insight berdasarkan lokasi yang dipilih
      if (location_selected == "All") {
        return("Tren pendapatan keseluruhan menunjukkan variasi di berbagai lokasi.")
      } else {
        return(paste("Tren pendapatan untuk lokasi", location_selected, "menunjukkan perubahan yang signifikan. Periksa lebih lanjut untuk detailnya."))
      }
    } else {
      return("Tidak ada data yang tersedia untuk filter yang dipilih.")
    }
  })
  
  # Output: Insight untuk Tren Revenue Berdasarkan Produk
  output$insight_trend_by_product <- renderText({
    revenue_by_product <- filtered_data_for_analysis() %>%
      group_by(Product.Name, !!sym(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop")
    
    if (nrow(revenue_by_product) > 0) {
      return("Produk-produk tertentu menunjukkan pertumbuhan pendapatan yang konsisten. Pertimbangkan untuk meningkatkan fokus pada produk yang berkinerja tinggi.")
    } else {
      return("Tidak ada data yang tersedia untuk filter yang dipilih.")
    }
  })
  
  # Output: Insight untuk Tren Revenue Berdasarkan Sales Channel
  output$insight_trend_by_sales_channel <- renderText({
    revenue_by_channel <- filtered_data_for_analysis() %>%
      group_by(Sales.Channel, !!sym(input$time_aggregation)) %>%
      summarize(Total_Revenue = sum(Approx..Total.Revenue.INR., na.rm = TRUE), .groups = "drop")
    
    if (nrow(revenue_by_channel) > 0) {
      return("Saluran penjualan menunjukkan tren kinerja yang berbeda. Diperlukan investigasi lebih lanjut untuk menentukan strategi penjualan yang lebih efektif.")
    } else {
      return("Tidak ada data yang tersedia untuk filter yang dipilih.")
    }
  })
  
  
  # Output: Data Table
  output$sales_data <- renderDT({
    datatable(filtered_data_for_analysis(), options = list(pageLength = 10, scrollX = TRUE))
  })
}

# Run the shiny app
shinyApp(ui, server)
