drop database if exists UniversoLector;
create database UniversoLector;
use UniversoLector;

drop table if exists Autor;
create table Autor (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Apellido varchar(100) NOT NULL,
    Nombre varchar(100) NOT NULL
);

drop table if exists Editorial;
create table Editorial (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Razon_Social varchar(100) NOT NULL,
    Telefono varchar(100) NOT NULL
);

drop table if exists Libro;
create table Libro (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ISBN varchar(13) NOT NULL,
    Titulo varchar(200) NOT NULL,
    Anio_Escritura year NOT NULL,
    Anio_Edicion year NOT NULL,
    Codigo_Autor INT,
    Codigo_Editorial INT,
    
	foreign key (Codigo_Autor) references Autor(Codigo),
    foreign key (Codigo_Editorial) references Editorial(Codigo)
);

drop table if exists Volumen;
create table Volumen (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Deteriorado boolean NOT NULL,
    Codigo_Libro INT,
    
	foreign key (Codigo_Libro) references Libro(Codigo)
);

drop table if exists Socio;
create table Socio (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	DNI INT NOT NULL,
    Apellido varchar(100) NOT NULL,
    Nombres varchar(100) NOT NULL,
    Direccion varchar(200) NOT NULL,
    Localidad varchar(100) NOT NULL
);

drop table if exists Prestamo;
create table Prestamo (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Codigo_Socio INT,
    Fecha datetime NOT NULL,
    Fecha_Devolucion date NOT NULL,
    Fecha_Tope date NOT NULL,
    
    foreign key (Codigo_Socio) references Socio(Codigo)
);

drop table if exists PrestamoxVolumen;
create table PrestamoxVolumen (
	Codigo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Codigo_Prestamo INT,
    Codigo_Volumen INT,
    
	foreign key (Codigo_Prestamo) references Prestamo(Codigo),
    foreign key (Codigo_Volumen) references Volumen(Codigo)
);



insert into Socio values(default, 3000000, "PATRICIA", "JOHNSON", "28 MySQL Boulevard", "QLD");
insert into Socio values(default, 2988800, "LINDA", "WILLIAMS", "23 Workhaven Lane", "Alberta");
insert into Socio values(default, 2500000, "BARBARA", "JONES", "1411 Lillydale Drive", "QLD");
insert into Autor values(default, "Rowling", "J. K.");
insert into Editorial values(default, "Bloomsbury Publishing", 54911564874);
insert into Libro values(default, 9781907545009, "Harry Potter y la piedra filosofal", '1997', '1997', 1, 1);
insert into Volumen values(default, 0, 1);
insert into Prestamo values(default, 1, "2020-1-1", "2020-7-1", "2020-7-1");
insert into PrestamoxVolumen values(default, 1, 1);

delete from Socio where Codigo = 2;

update Socio
set Direccion = "Monroe 860"
where Codigo = 3;
