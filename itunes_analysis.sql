drop database itunes_analysis;
CREATE DATABASE itunes_analysis;
USE itunes_analysis;

CREATE TABLE artists (
    ArtistId INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE albums (
    AlbumId INT PRIMARY KEY,
    Title VARCHAR(255),
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES artists(ArtistId)
);


CREATE TABLE genres (
    GenreId INT PRIMARY KEY,
    Name VARCHAR(120)
);

CREATE TABLE media_types (
    MediaTypeId INT PRIMARY KEY,
    Name VARCHAR(120)
);

CREATE TABLE tracks (
    TrackId INT PRIMARY KEY,
    Name VARCHAR(255),
    AlbumId INT,
    MediaTypeId INT,
    GenreId INT,
    Composer VARCHAR(255),
    Milliseconds INT,
    Bytes INT,
    UnitPrice DECIMAL(10,2),

    FOREIGN KEY (AlbumId) REFERENCES albums(AlbumId),
    FOREIGN KEY (MediaTypeId) REFERENCES media_types(MediaTypeId),
    FOREIGN KEY (GenreId) REFERENCES genres(GenreId)
);

CREATE TABLE employees (
    EmployeeId INT PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Title VARCHAR(100),
    ReportsTo INT,
    Levels VARCHAR(10),
    BirthDate DATETIME,
    HireDate DATETIME,
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    Phone VARCHAR(30),
    Fax VARCHAR(30),
    Email VARCHAR(100)
);

CREATE TABLE customers (
    CustomerId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Company VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(20),
    Phone VARCHAR(30),
    Fax VARCHAR(30),
    Email VARCHAR(100),
    SupportRepId INT,
    FOREIGN KEY (SupportRepId) REFERENCES employees(EmployeeId)
);

CREATE TABLE invoices (
    InvoiceId INT PRIMARY KEY,
    CustomerId INT,
    InvoiceDate DATETIME,
    BillingAddress VARCHAR(200),
    BillingCity VARCHAR(50),
    BillingState VARCHAR(50),
    BillingCountry VARCHAR(50),
    BillingPostalCode VARCHAR(20),
    Total DECIMAL(10,2),
    FOREIGN KEY (CustomerId) REFERENCES customers(CustomerId)
);

CREATE TABLE invoice_lines (
    InvoiceLineId INT PRIMARY KEY,
    InvoiceId INT,
    TrackId INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (InvoiceId) REFERENCES invoices(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES tracks(TrackId)
);

CREATE TABLE playlists (
    PlaylistId INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE playlist_tracks(
    PlaylistId INT,
    TrackId INT,
    PRIMARY KEY (PlaylistId, TrackId),
    FOREIGN KEY (PlaylistId) REFERENCES playlists(PlaylistId),
    FOREIGN KEY (TrackId) REFERENCES tracks(TrackId)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist.csv'
INTO TABLE artists
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album.csv'
INTO TABLE albums
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/genre.csv'
INTO TABLE genres
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/media_type.csv'
INTO TABLE media_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/track.csv'
INTO TABLE tracks
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE employees
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeId,
 LastName,
 FirstName,
 Title,
 @ReportsTo,
 Levels,
 @BirthDate,
 @HireDate,
 Address,
 City,
 State,
 Country,
 PostalCode,
 Phone,
 Fax,
 Email)
SET
ReportsTo = NULLIF(@ReportsTo, ''),
BirthDate = STR_TO_DATE(@BirthDate, '%d-%m-%Y %H:%i'),
HireDate = STR_TO_DATE(@HireDate, '%d-%m-%Y %H:%i');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice.csv'
INTO TABLE invoices
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(InvoiceId,
 CustomerId,
 @InvoiceDate,
 BillingAddress,
 BillingCity,
 BillingState,
 BillingCountry,
 BillingPostalCode,
 Total)
SET
InvoiceDate = STR_TO_DATE(@InvoiceDate, '%d-%m-%Y %H:%i');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice_line.csv'
INTO TABLE invoice_lines
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playlist.csv'
INTO TABLE playlists
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playlist_track.csv'
INTO TABLE playlist_tracks
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


select * from artists;
select * from albums;
select * from genres;
select * from tracks;
select * from employees;
select * from customers;
select * from invoices;
select * from invoice_lines;
select * from playlists;
select * from playlist_tracks;



SELECT EmployeeId, FirstName, LastName, Title
FROM employees
ORDER BY Levels DESC
LIMIT 1;

SELECT BillingCountry, COUNT(*) AS InvoiceCount
FROM invoices
GROUP BY BillingCountry
ORDER BY InvoiceCount DESC;

SELECT InvoiceId, Total
FROM invoices
ORDER BY Total DESC
LIMIT 3;

SELECT BillingCity, SUM(Total) AS Revenue
FROM invoices
GROUP BY BillingCity
ORDER BY Revenue DESC
LIMIT 1;

SELECT c.CustomerId, c.FirstName, c.LastName, SUM(i.Total) AS TotalSpent
FROM customers c
JOIN invoices i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY TotalSpent DESC
LIMIT 1;


SELECT DISTINCT c.Email, c.FirstName, c.LastName, g.Name
FROM customers c
JOIN invoices i ON c.CustomerId=i.CustomerId
JOIN invoice_lines il ON i.InvoiceId=il.InvoiceId
JOIN tracks t ON il.TrackId=t.TrackId
JOIN genres g ON t.GenreId=g.GenreId
WHERE g.Name='Rock'
ORDER BY Email;

SELECT ar.Name, COUNT(*) AS TrackCount
FROM artists ar
JOIN albums al ON ar.ArtistId=al.ArtistId
JOIN tracks t ON al.AlbumId=t.AlbumId
JOIN genres g ON t.GenreId=g.GenreId
WHERE g.Name='Rock'
GROUP BY ar.Name
ORDER BY TrackCount DESC
LIMIT 10;

SELECT Name, Milliseconds
FROM tracks
WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM tracks)
ORDER BY Milliseconds DESC;

SELECT c.FirstName, c.LastName, ar.Name,
SUM(il.UnitPrice*il.Quantity) AS TotalSpent
FROM customers c
JOIN invoices i ON c.CustomerId=i.CustomerId
JOIN invoice_lines il ON i.InvoiceId=il.InvoiceId
JOIN tracks t ON il.TrackId=t.TrackId
JOIN albums al ON t.AlbumId=al.AlbumId
JOIN artists ar ON al.ArtistId=ar.ArtistId
GROUP BY c.FirstName,c.LastName,ar.Name
ORDER BY TotalSpent DESC;


SELECT * FROM (
SELECT c.Country,g.Name,COUNT(*) AS Purchases,
RANK() OVER(PARTITION BY c.Country ORDER BY COUNT(*) DESC) r
FROM customers c
JOIN invoices i ON c.CustomerId=i.CustomerId
JOIN invoice_lines il ON i.InvoiceId=il.InvoiceId
JOIN tracks t ON il.TrackId=t.TrackId
JOIN genres g ON t.GenreId=g.GenreId
GROUP BY c.Country,g.Name
) t WHERE r=1;

SELECT * FROM (
SELECT c.Country,c.FirstName,c.LastName,SUM(i.Total) AS Spending,
RANK() OVER(PARTITION BY c.Country ORDER BY SUM(i.Total) DESC) r
FROM customers c
JOIN invoices i ON c.CustomerId=i.CustomerId
GROUP BY c.Country,c.CustomerId
) t WHERE r=1;

SELECT ar.Name, COUNT(*) AS Purchases
FROM artists ar
JOIN albums al ON ar.ArtistId=al.ArtistId
JOIN tracks t ON al.AlbumId=t.AlbumId
JOIN invoice_lines il ON t.TrackId=il.TrackId
GROUP BY ar.Name
ORDER BY Purchases DESC
LIMIT 10;


SELECT t.Name, COUNT(*) AS Purchases
FROM tracks t
JOIN invoice_lines il ON t.TrackId=il.TrackId
GROUP BY t.Name
ORDER BY Purchases DESC
LIMIT 1;

SELECT mt.Name, AVG(t.UnitPrice)
FROM tracks t
JOIN media_types mt ON t.MediaTypeId=mt.MediaTypeId
GROUP BY mt.Name;

SELECT c.Country, COUNT(*) AS Purchases
FROM customers c
JOIN invoices i ON c.CustomerId=i.CustomerId
JOIN invoice_lines il ON i.InvoiceId=il.InvoiceId
GROUP BY c.Country
ORDER BY Purchases DESC;







