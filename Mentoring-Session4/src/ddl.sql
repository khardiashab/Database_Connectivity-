
-- creating the schema
create database LPG;
use LPG;

-- creating the table cust_details
create table if not exists cust_details(
	Id int primary key auto_increment,
	name varchar(50),
	gender varchar(1),
    address varchar(100),
    phone_no bigint,
    connection_type decimal(3,1),
    no_of_cylinders int
);

-- creating orders table
create table if not exists orders (
	id int primary key auto_increment,
    Date date,
    cust_id int,
    quantity int,
    payment_type varchar(30),
    status varchar(30),
    constraint c_o_fk foreign key(cust_id) references cust_details(id)
);

-- creating cancelled_orders
create table if not exists cancelled_orders (
	order_id int,
    date date,
    reason varchar(50),
    constraint cancelled_to_order_fk foreign key(order_id) references orders(id)
);

-- creating  billing_details

create table if not exists billing_details (
	inv_id int primary key auto_increment,
    date date,
    order_id int,
    delivery_status varchar(30),
    constraint billing_to_orders_fk foreign key (order_id) references orders(id)
);

-- creating table cancelled_bills
create table if not exists cancelled_bills (
	inv_id int,
    date date,
    reason varchar(50),
    constraint cancelled_bills_to_billing_details_fk foreign key (inv_id) references billing_details(inv_id)
);

-- create table pricing
create table if not exists pricing (
	type decimal(3,1),
    month varchar(10),
    year int,
    price int
);