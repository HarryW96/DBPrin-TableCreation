create database dbprin_cwk;

create table event(
  eventID int auto_increment,
  eventName varchar(50) not null,
  eventDate date not null,
  eventTime time not null,
  eventCost int not null,
  eventLocation varchar(50) not null,
  eventLength_Km int not null,
  primary key (eventID)
);

create table volunteer(
  volunteerID int auto_increment,
  fName varchar(25) not null,
  lName varchar(30) not null,
  phoneNum int not null,
  email varchar(40) not null,
  firstAid boolean not null,
  primary key (volunteerID)
);

create table eventVolunteer(
  volunteerEventAssignment int auto_increment,
  eventID int,
  volunteerID int,
  foreign key(eventID)
  references event(eventID),
  foreign key(volunteerID)
  references volunteer(volunteerID),
  primary key (volunteerEventAssignment)
);

create table staff(
  staffID int auto_increment,
  fName varchar(25) not null,
  lName varchar(30) not null,
  phoneNum int not null,
  email varchar(40) not null,
  primary key (staffID)
);

create table eventStaff(
  staffEventAssignment int auto_increment,
  eventID int,
  staffID int,
  foreign key(eventID)
  references event(eventID),
  foreign key(staffID)
  references staff(staffID),
  primary key (staffEventAssignment)
);

create table participent(
  participentID int auto_increment,
  age int not null,
  fName varchar(25) not null,
  lName varchar(30) not null,
  phoneNum int not null,
  email varchar(40) not null,
  emergencyContactNum int not null,
  primary key(participentID)
);

create table eventParticipent(
  participationNum int auto_increment,
  eventID int,
  participentID int,
  paid boolean not null,
  result int,
  eventTime varchar(10),
  foreign key(eventID)
  references event(eventID),
  foreign key(participentID)
  references participent(participentID),
  primary key (participationNum)
);

create table station(
  stationID int auto_increment,
  eventID int null,
  type varchar(25) not null,
  location_Km int not null,
  foreign key(eventID)
  references event(eventID),
  primary key(stationID)
);

create table client(
  clientID int auto_increment,
  eventID int,
  companyName varchar(30) not null,
  phoneNum int not null,
  email varchar(40) not null,
  liaisonFName varchar(25),
  liaisonLName varchar(30),
  foreign key (eventID)
  references event(eventID),
  primary key(clientID)
);

create table invoice(
  invoiceID int auto_increment,
  clientID int,
  eventID int,
  moneyOwed int not null,
  dateIssued date not null,
  dateDue date not null,
  foreign key(clientID)
  references client(clientID),
  foreign key(eventID)
  references event(eventID),
  primary key(invoiceID)
);




