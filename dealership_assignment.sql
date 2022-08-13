-- customer
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(25),
	phone VARCHAR(25),
	address VARCHAR(100)
);

-- thank you random word generator for these names: https://randomwordgenerator.com/name.php
INSERT INTO customer (first_name, last_name, email, phone, address)
VALUES ('Minh','Deleon','md@123.com','555 555 5555','123 Wabie Street'),
('Lenard','Dominguez', 'ld@gmail.com', '111 111 1111', '123 Cyclones St'),
('Christian','Griffin', 'cg@gmail.com', '222 222 2222', '123 Adeline St'),
('Arline','Reese', 'ar@gmail.com', '333 333 3333', '123 Fever St'),
('Ronny','Cruz', 'rc@gmail.com', '444 444 4444', '215 Nanana St');


CREATE OR REPLACE PROCEDURE add_customer(first_name VARCHAR, last_name VARCHAR, email VARCHAR, phone VARCHAR, address VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO customer (first_name, last_name, email, phone, address)
	VALUES (first_name, last_name, email, phone, address);
END;
$$;

CALL add_customer('Emilia', 'Cooke', 'ec@gmail.com', '773 111 1111', '124 Sunshine Way');

CALL add_customer('Leon','Rojas','lr@gmail.com', '773 222 2222', '492 Away Rd');

SELECT * FROM customer;


-- car
CREATE TABLE car(
	car_id SERIAL PRIMARY KEY,
	price NUMERIC(10,2),
	color VARCHAR(25),
	make VARCHAR(25),
	model VARCHAR(25),
	last_maintained TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE car
DROP COLUMN last_maintained;

ALTER TABLE car ADD COLUMN year1 VARCHAR(4);
SELECT * FROM car;

INSERT INTO car(price, color, make, model, year1)
VALUES (15000,'red','Toyota','Hiace',2010),
(20000,'blue','Chevrolet','Malibu',2007),
(35000,'black','Nissan','Platina',2005),
(170000,'silver','Mercedes-Benz','S600',2009),
(27000,'pink','Mazda','Miata',2004);

SELECT * FROM car;



-- inventory
CREATE TABLE inventory(
	inventory_id SERIAL PRIMARY KEY,
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	branch_id INTEGER NOT NULL,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	quantity INTEGER
);

INSERT INTO inventory (car_id, branch_id, quantity)
VALUES (1, 1, 5),
(1, 2, 5),
(1, 3, 6),
(2, 4, 10),
(2, 1, 4),
(3, 1, 2),
(3, 3, 2),
(3, 4, 5),
(4, 4, 3),
(4, 2, 3),
(4, 5, 4),
(5, 5, 6),
(5, 2, 2),
(5, 1, 1);

SELECT * FROM inventory;

-- how many cars & how many types of car does each branch have
SELECT branch_id, sum(quantity) AS total_cars, count(*) AS car_varieties FROM inventory GROUP BY branch_id;



-- branch
CREATE TABLE branch(
	branch_id SERIAL PRIMARY KEY,
	branch_name VARCHAR(50),
	city VARCHAR(25),
	state VARCHAR(2),
	phone VARCHAR(25),
	address VARCHAR(100)
);

INSERT INTO branch (branch_name, city, state, phone, address)
VALUES ('Roselle Rd','Schaumberg','IL','123 111 1111', '123 Roselle Rd'),
('Woodfield Mall','Schaumberg','IL','123 222 2222', '123 Woodfield Rd'),
('Aurora','Aurora','IL','123 333 3333', '213 W Galena Blvd'),
('Madison','Madison','WI','223 444 4444', '642 Keyes Ave'),
('St. Louis','St. Louis','MO','248 555 5555', '743 Washington Ave');

SELECT * FROM branch;



-- invoice
CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	branch_id INTEGER NOT NULL,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	amount NUMERIC(10,2),
	date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO invoice (branch_id, car_id, customer_id, amount)
VALUES (1, 1, 1, 14000),
(1, 1, 2, 15000),
(2, 2, 5, 25000),
(3, 4, 3, 165000),
(4, 3, 4, 34000),
(5, 5, 5, 22000);

SELECT * FROM invoice;
SELECT * FROM car;



-- employee
CREATE TABLE employee(
	employee_id SERIAL PRIMARY KEY,
	branch_id INTEGER NOT NULL,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	job VARCHAR(30),
	job_rank VARCHAR(10),
	email VARCHAR(30),
	phone VARCHAR(30),
	address VARCHAR(100)
);

-- thanks again to random word generator for the names: https://randomwordgenerator.com/name.php
INSERT INTO employee (branch_id, first_name, last_name, job, job_rank, email, phone, address)
VALUES (1, 'Hobert', 'Carter', 'sales', 'director', 'hc@gmail.com', '234 111 1111', '123 Wendi St'),
(1, 'Florencio', 'Bray', 'mechanic', 'trainee', 'fb@gmail.com', '234 222 2222', '123 Truman St'),
(1, 'Antoine', 'Barrera', 'mechanic', 'manager', 'ab@gmail.com', '234 333 3333', '123 Graves St'),
(2, 'Dorothea', 'McFarland', 'sales', 'manager', 'dmf@gmail.com', '234 444 4444', '123 Donovan St'),
(2, 'Elliot', 'Shea', 'mechanic', 'manager', 'es@gmail.com', '234 555 5555', '123 Ayers St'),
(3, 'Vernon', 'Dean', 'sales', 'manager', 'vd@gmail.com', '234 666 6666', '123 Elena St'),
(3, 'Dale', 'Foley', 'mechanic', 'manager', 'df@gmail.com', '234 777 7777', '123 Horne St'),
(4, 'Hugh', 'George', 'sales', 'intern', 'hg@gmail.com', '234 888 8888', '123 Allison St'),
(4, 'Dominique', 'Flores', 'sales', 'manager', 'df@gmail.com', '234 999 9999', '123 Kenyad St'),
(4, 'Jenny', 'Camacho', 'mechanic', 'manager', 'jc@gmail.com', '234 000 0000', '123 Viggo St'),
(5, 'Bernie', 'Burton', 'sales', 'manager', 'bb@gmail.com', '345 111 1111', '123 Armando St'),
(5, 'Nichole', 'Hines', 'mechanic', 'manager', 'nh@gmail.com', '345 222 2222', '123 Philip St'),
(5, 'Aileen', 'Pugh', 'mechanic', 'trainee', 'ap@gmail.com', '345 333 3333', '123 Morris St');

SELECT * FROM employee;



-- service_ticket
CREATE TABLE service_ticket(
	service_ticket_id SERIAL PRIMARY KEY,
	branch_id INTEGER NOT NULL,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	amount NUMERIC(5,2),
	work_done VARCHAR(100),
	completed BOOLEAN,
	notes VARCHAR(500),
	date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO service_ticket (branch_id, customer_id, car_id, amount, work_done, completed, notes)
VALUES (1, 1, 1, 23.53, 'brakes', TRUE, 'Love these brakes'),
(2, 1, 2, 12.24, 'windshield wipers', TRUE, 'They sure work'),
(4, 3, 4, 130.04, 'windshield', FALSE, 'Windshield ordered, not yet arrived.'),
(5, 2, 5, 70.23, 'air conditioning', TRUE, 'The air smelled weird, turns out there was a dead mouse in the pipes.'),
(3, 5, 5, 200.24, 'battery', TRUE, 'fancy new battery. now it runs.');

-- just to check the cars are owned by the right customers, doesn't so much matter the branch:
SELECT car_id, customer_id FROM invoice; 

SELECT * FROM service_ticket;



-- invoice_employee
CREATE TABLE invoice_employee(
	employee_id INTEGER NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
	invoice_id INTEGER NOT NULL,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

-- checking which invoices were done at which branch, and which employees work in sales at that branch
SELECT * FROM invoice; -- 1,2@1; 2@1; 3@2; 4@3; 5@4; 6@5
SELECT * FROM employee WHERE job = 'sales'; -- 1@1; 4@2; 6@3; 8,9@4; 11@5


INSERT INTO invoice_employee (invoice_id, employee_id)
VALUES (1,1),
(2,1),
(3,4),
(4,6),
(5,8),
(6,11);

SELECT * FROM invoice_employee;



-- service_ticket_employee
CREATE TABLE service_ticket_employee(
	employee_id INTEGER NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
	service_ticket_id INTEGER NOT NULL,
	FOREIGN KEY (service_ticket_id) REFERENCES service_ticket(service_ticket_id)
);

-- checking what service was done at what branch, and what employees work as mechanics at that branch:
SELECT * FROM service_ticket; -- 1@1, 2@2, 3@4, 4@5, 5@3
SELECT * FROM employee WHERE job = 'mechanic'; -- 2,3@1; 5@2; 7@3; 10@4; 12,13@5

INSERT INTO service_ticket_employee (service_ticket_id, employee_id)
VALUES (1,2),
(1,3),
(2,5),
(3,10),
(4,12),
(4,13),
(5,7);

SELECT * FROM service_ticket_employee;




































