create database vehicle_system

use vehicle_system
go

create table [Owner](
National_number int primary key,
[Name] nvarchar(50) unique,
[Type] nvarchar(50),
[Address] nvarchar(100),
constraint CHK_Type check ([Type] in ('Government','Organization','Individual'))
)

create table Phone_number(
Phone nvarchar(15),
Owner_NN int,
CONSTRAINT OwnerPhone FOREIGN KEY (Owner_NN)
REFERENCES Owner(National_number) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PK_Phone PRIMARY KEY (Owner_NN,Phone)
)

create table Department(
Code int primary key,
[Name] nvarchar(50) unique,
)

create table Service_location(
Dep_code int,
Location_name nvarchar(50) unique,
CONSTRAINT DepSL FOREIGN KEY (Dep_code)
REFERENCES Department(Code) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PK_SL PRIMARY KEY (Dep_code,Location_name)
)
create table Fine_type(
[Type] nvarchar(50) primary key,
[Value] float,
)

Create table Vehicle_type(
Code int primary key,
[Name] nvarchar(50) unique,
)

Create table Tax_category(
Type_code int,
Tax_rate float,
CONSTRAINT VType_FK FOREIGN KEY (Type_code)
REFERENCES Vehicle_type(Code) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT PK_ PRIMARY KEY (Type_code,Tax_rate),
)

create table Vehicle(
Vehicle_number int primary key,
Dep_code int,
Model nvarchar(50),
[Type] int not null,
Color nvarchar(50),
Motor_capacity int,
Number_of_seats int,
Manfacturing_year int,
License_issue_date date,
License_expiry_date date,
Owner_NN int not null,
tax_rate float not null default (0.0),
Total_fine float default (0.0),

CONSTRAINT V_type FOREIGN KEY ([Type])
REFERENCES Vehicle_type(Code) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Vehicle_uniquness unique (Dep_code,Vehicle_number,Owner_NN),
CONSTRAINT Owner_FK FOREIGN KEY (Owner_NN)
REFERENCES [Owner](National_number) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Dep_FK FOREIGN KEY (Dep_code)
REFERENCES Department(Code) ON DELETE CASCADE ON UPDATE CASCADE,
)
	
create table Vehicle_fine(
Fine_number int identity(1,1) primary key,
[Type] nvarchar(50),
[Date] date,
[Vehicle] int,
CONSTRAINT Vehicle_FK FOREIGN KEY ([Vehicle])
REFERENCES Vehicle(Vehicle_number) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Fine_FK FOREIGN KEY ([Type])
REFERENCES Fine_type([Type]) ON DELETE CASCADE ON UPDATE CASCADE,
)

create table Vehicle_History(
Dep_code int,
Vehicle_number int,
Owner_NN int,
License_issue_date date,
License_expiry_date date,
[Start_date] date,
[End_date] date,
CONSTRAINT Dep_H_FK ForEIGN KEY ([Dep_code])
REFERENCES Department(Code) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Vehicle_H_FK ForEIGN KEY (Vehicle_number)
REFERENCES Vehicle(Vehicle_number) ON DELETE NO ACTION ON UPDATE NO ACTION,
CONSTRAINT Owner_H_FK ForEIGN KEY (Owner_NN)
REFERENCES [Owner](National_number) ON DELETE CASCADE ON UPDATE CASCADE,
Constraint VH_Uniquness Unique(Dep_code,Vehicle_number,Owner_NN,License_issue_date,License_expiry_date,[Start_date],[End_date])
)
