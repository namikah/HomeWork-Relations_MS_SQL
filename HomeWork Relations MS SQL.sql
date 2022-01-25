CREATE DATABASE LibraryDb

USE LibraryDb

--CREATE ALL TABLES
CREATE TABLE Books(
	Id int primary key identity,
	Name nvarchar(100) unique not null
)

CREATE TABLE Genres(
	Id int primary key identity,
	Name nvarchar(50) not null
)

CREATE TABLE Autors(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Surname nvarchar(50)
)

CREATE TABLE Customers(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Surname nvarchar(50) not null,
	Age int check(Age > 14) not null,
	Gender nvarchar(20) not null
)

CREATE TABLE GenresBooks(
	Id int primary key identity,
	GenreId int references Genres(Id),
	BookId int references Books(Id)
)

CREATE TABLE AutorGenres(
	Id int primary key identity,
	AutorId int references Autors(Id),
	GenreId int references Genres(Id)
)

CREATE TABLE AutorBooks(
	Id int primary key identity,
	AutorId int references Autors(Id),
	BookId int references Books(Id)
)

CREATE TABLE Orders(
	Id int primary key identity,
	BookId int references Books(Id),
	CustomerId int references Customers(Id),
	GetDates date default GETDATE() not null,
	ReturnDates date default DATEADD(DAY, 10, GETDATE()) not null --default olaraq 10 gun qaytarma vaxti
)

--INSERT DATA TO TABLES
INSERT INTO Books
VALUES	('The Hunger Games'),
		('Catching Fire'),
		('Harry Potter'),
		('Twilight'),
		('Pride And Prejudice'),
		('Eclipse')

INSERT INTO Genres
VALUES	('Fantasy'),
		('Romance'),
		('Horror'),
		('Thriller'),
		('Art')

INSERT INTO Autors
VALUES	('Suzanne', 'Collins'),
		('Stephenie', 'Meyer'),
		('Jane', 'Austen'),
		('Harper', 'Lee')

INSERT INTO Customers
VALUES	('Namik', 'Heydarov', 34, 'Male'),
		('Elmin', 'Kerimov', 27, 'Male'),
		('Elman', 'Memmedov', 20, 'Male'),
		('Nigar', 'Azizova', 19, 'FeMale '),
		('Veli', 'Nebiyev', 30, 'Male'),
		('Aysel', 'Ahmadova', 33, 'FeMale'),
		('Leyla', 'Aliyeva', 15, 'FeMale')

INSERT INTO GenresBooks
VALUES	(5,1),
		(2,2),
		(3,3),
		(1,4),
		(4,5),
		(2,6)

INSERT INTO AutorGenres
VALUES	(1,1),
		(3,2),
		(2,3),
		(4,4),
		(2,5),
		(1,5)

INSERT INTO AutorBooks
VALUES	(3,1),
		(2,2),
		(1,3),
		(4,4),
		(4,5),
		(4,6)

INSERT INTO Orders
VALUES	(1, 7, '2021-01-05', '2021-02-05'),
		(2, 1, '2021-02-12', '2021-03-12'),
		(2, 3, '2021-03-15', '2021-04-16'),
		(3, 2, '2021-04-15', '2021-05-05'),
		(4, 4, '2021-04-22', '2021-05-20'),
		(4, 5, '2021-01-12', '2021-12-30'),
		(2, 7, '2022-01-15', '2022-01-25'),
		(3, 1, '2022-01-16', '2022-01-26'),
		(4, 1, '2022-01-17', '2022-01-27')

--HOMEWORK--
--Hansi janra hansi kitablarin aid oldugunu gostermek[dbo].[GenresBooks]
SELECT GB.Id, G.Name Genres, B.Name Books
FROM GenresBooks GB
LEFT JOIN Genres G ON GB.GenreId = G.Id
LEFT JOIN Books B ON GB.BookId = B.Id
ORDER BY Genres

--Hansi authorun hansi kitablari var
SELECT AB.Id, A.Name + ' ' + A.Surname AutorsFullName, B.Name Books
FROM AutorBooks AB
INNER JOIN Autors A ON A.Id = AB.AutorId
INNER JOIN Books B ON B.Id = AB.BookId
ORDER BY AutorsFullName

--Hansi author hansi janrlarda yazir
SELECT AG.Id, A.Name + ' ' + A.Surname AutorsFullName, G.Name Genres
FROM AutorGenres ag
INNER JOIN Autors A ON A.Id = AG.AutorId
INNER JOIN Genres G ON G.Id = AG.GenreId
ORDER BY AutorsFullName

--Hansi customer hansi kitablari oxuyub
SELECT O.Id, C.Name + ' ' + C.Surname 'Customers FullName', C.Age, C.Gender, B.Name Books, O.GetDates, O.ReturnDates
FROM Orders O
INNER JOIN Customers C ON C.Id = O.CustomerId
INNER JOIN Books B ON B.Id = O.BookId
ORDER BY O.GetDates

--Hec oxunmamish kitablar
SELECT Id, Name 'Unread Books'
FROM Books B
WHERE NOT B.Id IN (SELECT O.BookId FROM ORDERS O)
Order by Name

--Top oxunan kitablar
SELECT B.Name 'Books', COUNT(O.BookId) 'Read Count'
FROM Orders O
INNER JOIN Books B ON b.Id = O.BookId
GROUP BY B.Name
ORDER BY COUNT(O.BookId) DESC;