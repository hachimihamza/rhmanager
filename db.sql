create table employe (
cin_employe integer primary key,
nom_employe varchar(20),
prenom_employe varchar(20),
adresse varchar(40),
username varchar(20),
motdepasse varchar(20),
num_departement integer,
is_admin boolean
);

create table employe (
cin_chef integer primary key,
nom_chef varchar(20),
prenom_chef varchar(20),
adresse varchar(40),
username varchar(20),
motdepasse varchar(20),
num_departement integer,
is_admin boolean
);

create table departement (
num_departement integer primary key,
designation_departement varchar(20),
cin_chef integer references employe(cin_employe)
);

alter table employe
add constraint employe_fk foreign key(num_departement) references departement(num_departement);

create table arret (
num_arret integer primary key,
date_debut date,
date_fin date,
type_arret varchar(20),
status_arret varchar(20),
cin_employe integer references employe(cin_employe)
);

create table fonction (
num_fonction integer primary key,
designation_fonction varchar(20) 
);

create table fonction_employe (
cin_employe integer references employe(cin_employe),
num_fonction integer references fonction(cin_fonction),
constraint fonction_employe_pk primary key(cin_employe, num_fonction)
);
