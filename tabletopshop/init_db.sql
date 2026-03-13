use tabletopshop;

CREATE TABLE category (
	category_id INT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    Descript TEXT
);

CREATE TABLE customer (
	user_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    passowrd VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    price FLOAT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE orders (
	order_number INT PRIMARY KEY,
    shipping_address VARCHAR(100) NOT NULL,
    total_cost Float NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES customer(user_id)
);

CREATE TABLE ordered_items(
	order_number INT,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (order_number, product_id),
    FOREIGN KEY (order_number) REFERENCES orders(order_number),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE cart(
	cart_id INT PRIMARY KEY,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES customer(user_id)
);

CREATE TABLE items_in_cart (
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (cart_id , product_id),
    FOREIGN KEY (cart_id) REFERENCES cart (cart_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

INSERT INTO category (category_id, brand_name, Descript)
VALUES
(501, 'YU GI OH', 'Japanese trading card game.'),
(502, 'Warhammer', 'Miniature table-top War-gaming models'),
(503, 'Dungeons and Dragons', 'Table-top Role playing game');

INSERT INTO customer (user_id, email, passowrd, first_name)
VALUES
(601, 'funguy@coolemail.com','password123','James' ),
(602, 'johnreader@gmail.com','lovebooks54','John'),
(603, 'Johnyugioh@gmail.com','6cardmaster7','Yugi'),
(604, 'dndnerd@yahoo.com','masterpass123','Archibald'),
(605, 'Dwang@fau.edu', 'databaselover', 'Dingding');

INSERT INTO product (product_id, product_name, stock, price, category_id)
VALUES
(101, 'Blue Eyes White Dragon Structure Deck', 4, 24.99, 501),
(102, 'Rarity Collection V Booster Box', 5, 139.99, 501),
(103, 'Alliance Insight Booster box', 0, 59.99, 501),
(104, 'Phantom Revenge Booster box', 5, 37.75, 501),
(201, 'Intercessor Squad', 10, 79.99, 502),
(202, 'Terminator Assault Box', 5, 89.99, 502),
(301, 'D&D Starter Set', 20, 29.99, 503),
(302, 'Mind Flayer Dice pack', 5, 7.99, 503);

INSERT INTO cart (cart_id, user_id)
VALUES
(6767, 601),
(5523, 602),
(6942, 603),
(1337, 604),
(1738, 605);

INSERT INTO orders (order_number, total_cost, shipping_address, user_id)
VALUES
(23565, 24.99, '1600 Pennsylvania Avenue NW, Washington DC, 20500', 603),
(63452, 169.98, '50 Hudson Yards, New York, New York, 10001', 601),
(12312, 29.99, '1100 S Ocean Blvd, Palm Beach, FL 33480', 602),
(83272, 7.99, '550 Terry A. Francois Blvd.', 605),
(16925, 89.99, '721-725 Fifth Avenue, New York, NY 10022', 601);

INSERT INTO ordered_items (order_number, product_id, quantity)
VALUES
(23565, 101, 1),
(63452, 201, 1),
(63452, 202, 1);

INSERT INTO items_in_cart (cart_id, product_id, quantity)
VALUES
(6767,  104, 1),
(6767, 302, 1);


