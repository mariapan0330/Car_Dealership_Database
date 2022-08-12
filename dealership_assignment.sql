-- customer
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(25),
	phone VARCHAR(25),
	address VARCHAR(100)
);


-- car
CREATE TABLE car(
	car_id SERIAL PRIMARY KEY,
	price NUMERIC(10,2)
	color VARCHAR(25),
	make VARCHAR(25),
	model VARCHAR(25),
	last_maintained TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- inventory
CREATE TABLE inventory(
	inventory_id SERIAL PRIMARY KEY,
	car_id INTEGER NOT NULL,
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	branch_id INTEGER NOT NULL,
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	quantity INTEGER
);

-- branch BOOKMARK
CREATE TABLE branch(
	branch_id SERIAL PRIMARY KEY,
	branch_name VARCHAR(50),
	city VARCHAR(25),
	state VARCHAR(2),
	phone VARCHAR(25),
	address VARCHAR(100)
);


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


-- invoice_employee
CREATE TABLE invoice_employee(
	employee_id INTEGER NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
	invoice_id INTEGER NOT NULL,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
);


-- service_ticket
CREATE TABLE service_ticket(
	service_ticket_id SERIAL PRIMARY KEY,
	invoice_id INTEGER NOT NULL,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	amount NUMERIC(5,2),
	work_done VARCHAR(100),
	completed BOOLEAN,
	notes VARCHAR(500)
);

































