📌 Project Overview

The Apple iTunes Music Store Analysis project analyzes transactional data from a digital music store using SQL.

The objective of this project is to explore:

Customer purchasing behavior

Music genre popularity

Revenue trends

Geographic sales distribution

Artist and track performance

Using MySQL, a relational database was built from CSV datasets and analytical SQL queries were performed to generate business insights.

This project demonstrates how SQL can be used for real-world business intelligence and decision-making.

🗂 Dataset Overview

The dataset consists of 11 relational tables representing the music store ecosystem.

Table	Description
artists	Stores artist information
albums	Album details released by artists
tracks	Individual songs in the store
genres	Music genre classification
media_types	Music file formats
employees	Store employees
customers	Customer information
invoices	Customer purchase transactions
invoice_lines	Individual track purchases
playlists	Playlist collections
playlist_tracks	Tracks inside playlists
🏗 Database Architecture

The project uses a relational database design with primary and foreign key relationships.

Artists → Albums → Tracks
Tracks → Genres
Tracks → Media Types
Customers → Invoices → Invoice Lines → Tracks
Customers → Employees
Playlists → Playlist Tracks → Tracks

This schema enables efficient querying across multiple entities.

⚙️ Technologies Used
Tool	Purpose
MySQL	Database management
SQL	Data analysis
MySQL Workbench	Query execution
CSV	Dataset storage
GitHub	Project documentation

Optional tools for visualization:

Power BI

Tableau

📥 Data Loading Process

The dataset was imported into MySQL using:

LOAD DATA INFILE

Key steps included:

Creating tables

Defining primary keys

Creating foreign key relationships

Importing CSV datasets

Cleaning date formats

Handling missing values

📊 Business Questions Answered

The analysis addresses several business questions:

1️⃣ Who is the senior-most employee?
2️⃣ Which country generates the most invoices?
3️⃣ What are the top invoice transactions?
4️⃣ Which city produces the highest revenue?
5️⃣ Who is the best customer?
6️⃣ Who listens to Rock music?
7️⃣ Which artists create the most Rock tracks?
8️⃣ Which songs are longer than average?
9️⃣ How much do customers spend on artists?
🔟 What is the most popular genre per country?
1️⃣1️⃣ Who is the top customer per country?
1️⃣2️⃣ Which artists are most popular?
1️⃣3️⃣ What is the most popular song?
1️⃣4️⃣ What is the average track price?
1️⃣5️⃣ Which countries generate the most purchases?

🔎 Key Insights

Major findings from the analysis include:

✔ Rock music is the most popular genre
✔ USA generates the highest number of purchases
✔ A small number of customers contribute most revenue
✔ Artists like Queen, Led Zeppelin, and U2 dominate music sales
✔ Certain cities such as Prague generate significant revenue

📈 Business Recommendations

Based on the analysis:

Promote high-performing artists

Expand the Rock music catalog

Target high-value customers

Focus marketing on top countries

Implement personalized music recommendations

📂 Project Structure
itunes-analysis-project
│
├── dataset
│   ├── artist.csv
│   ├── album.csv
│   ├── track.csv
│   ├── genre.csv
│   ├── invoice.csv
│   ├── invoice_line.csv
│
├── sql
│   ├── itunes_analysis.sql
│
├── report
│   ├── itunes_analysis_report.pdf
│
└── README.md
📊 Future Enhancements

Possible improvements:

Build Power BI dashboards

Add visual analytics

Perform time-based revenue analysis

Implement customer segmentation

Create recommendation systems

👨‍💻 Author
Ponna Chaitanya
Apple iTunes Music Store Analysis
