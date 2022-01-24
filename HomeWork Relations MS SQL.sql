CREATE DATABASE MyData

USE MyData

CREATE TABLE Books(
	Id int primary key identity,
	Name nvarchar(50) unique not null
)

CREATE TABLE Genres(
	Id int primary key identity,
	Name nvarchar(50) not null
)

CREATE TABLE Autors(
	Id int primary key identity,
	Name nvarchar(50) not null
)

CREATE TABLE Customers(
	Id int primary key identity,
	Name nvarchar(50) not null,
	Surname nvarchar(50) not null,
	Age int not null,
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
	GetDates date default getDate(),
	ReturnDates date
)

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
VALUES	('Suzanne Collins'),
		('Stephenie Meyer'),
		('Jane Austen'),
		('Harper Lee')

INSERT INTO Customers
VALUES	('Namik', 'Heydarov', 34, 'Male'),
		('Elmin', 'Kerimov', 27, 'Male'),
		('Elman', 'Memmedov', 20, 'Male'),
		('Nigar', 'Azizova', 19, 'FeMale '),
		('Veli', 'Nebiyev', 30, 'Male'),
		('Aysel', 'Ahmadova', 33, 'FeMale')

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
VALUES	(1, 1, '2021-01-05', '2021-02-05'),
		(2, 1, '2021-02-12', '2021-03-12'),
		(2, 3, '2021-03-15', '2021-04-16'),
		(3, 2, '2021-04-15', '2021-05-05'),
		(5, 4, '2021-04-22', '2021-05-20'),
		(4, 5, '2021-12-12', '2021-12-30'),
		(2, 1, '2021-12-12', Null),
		(3, 1, '2021-12-12', Null),
		(4, 1, '2021-12-12', Null)

--Hansi janra hansi kitablarin aid oldugunu gostermek
SELECT gb.Id, g.Name 'Genres', b.Name 'Books' 
FROM GenresBooks gb
INNER JOIN Genres g ON gb.GenreId = g.Id
INNER JOIN Books b ON gb.BookId = b.Id

--Hansi authorun hansi kitablari var
SELECT ab.Id, a.Name 'Autors', b.Name 'Books'
FROM AutorBooks ab
INNER JOIN Autors a ON a.Id = ab.AutorId
INNER JOIN Books b ON b.Id = ab.BookId

--Hansi author hansi janrlarda yazir
SELECT ag.Id, a.Name 'Autors', g.Name 'Genres'
FROM AutorGenres ag
INNER JOIN Autors a ON a.Id = ag.AutorId
INNER JOIN Genres g ON g.Id = ag.GenreId

--Hansi customer hansi kitablari oxuyub
SELECT o.Id, c.Name + ' ' + c.Surname 'Customers', c.Age, c.Gender, b.Name 'Books', o.GetDates, o.ReturnDates
FROM Orders o
INNER JOIN Customers c ON c.Id = o.CustomerId
INNER JOIN Books b ON b.Id = o.BookId