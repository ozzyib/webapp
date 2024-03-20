-- Path: project/db/init.sql

Create Database if not exists project;
use project;

Create Table if not exists messages (
    id int auto_increment primary key,
    message varchar(255) not null
);
