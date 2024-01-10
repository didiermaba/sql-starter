-- Base de données SQL pour une application e-commerce

CREATE DATABASE ecom;

CREATE TABLE  user (id INT PRIMARY KEY AUTO_INCREMENT, firstname VARCHAR(30), lastname VARCHAR(30), email VARCHAR(100) NOT NULL, password(50) NOT NULL, phone VARCHAR(15), birthday DATE, role VARCHAR(10) NOT NULL);

CREATE TABLE category (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL, image VARCHAR(255), description TEXT);

CREATE TABLE  product (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL, price FLOAT NOT NULL, description TEXT NOT NULL, category_id INT NOT NULL, FOREIGN KEY (category_id) REFERENCES category(id));

CREATE TABLE  review (id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(100) NOT NULL, content TEXT NOT NULL, note INT NOT NULL, user_id INT NOT NULL, product_id INT NOT NULL, FOREIGN KEY (user_id) REFERENCES user(id), FOREIGN KEY (product_id) REFERENCES product(id));

CREATE TABLE tag (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL);

CREATE TABLE  product_tag (product_id INT NOT NULL, tag_id INT NOT NULL,   FOREIGN KEY (product_id) REFERENCES product(id), FOREIGN KEY (tag_id) REFERENCES tag(id) );

CREATE TABLE  product_image (id INT PRIMARY KEY AUTO_INCREMENT,  name VARCHAR(100) NOT NULL, link VARCHAR(255) NOT NULL, small VARCHAR(255) NOT NULL, medium VARCHAR(255), large VARCHAR(255), product_id INT NOT NULL, FOREIGN KEY (product_id) REFERENCES product(id));

CREATE TABLE stock ( product_id INT NOT NULL, quantity INT NOT NULL, FOREIGN KEY (product_id) REFERENCES product(id));

CREATE TABLE  cart(id INT PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE  product_cart (quantity INT NOT NULL, product_id INT NOT NULL, cart_id INT NOT NULL, FOREIGN KEY (product_id) REFERENCES product(id), FOREIGN KEY (cart_id) REFERENCES cart(id) );

CREATE TABLE  payment (id INT PRIMARY KEY AUTO_INCREMENT, status BOOLEAN NOT NULL DEFAULT 0, amount FLOAT NOT NULL, date datetime DEFAULT CURRENT_TIMESTAMP, transaction_id VARCHAR(255) NOT NULL, type VARCHAR(20) NOT NULL);

CREATE TABLE promo (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100) NOT NULL, date DATETIME NOT NULL, discount FLOAT NOT NULL);

CREATE TABLE delivery (id INT PRIMARY KEY AUTO_INCREMENT, address VARCHAR(255) NOT NULL, city VARCHAR(100) NOT NULL, zip VARCHAR(10) NOT NULL, country VARCHAR(100) NOT NULL DEFAULT 'France', details TEXT, default_addres BOOLEAN NOT NULL DEFAULT 0, user_id INT NOT NUll, FOREIGN KEY (user_id) REFERENCES user(id));

CREATE TABLE  order (id INT PRIMARY KEY AUTO_INCREMENT,  date DATETIME NOT NULL, status VARCHAR(20) NOT NULL, cart_id INT NOT NULL, user_id INT NOT NULL, promo_id INT NOT NULL, delivery_id INT NOT NULL, payment_id INT NOT NULL, FOREIGN KEY (cart_id) REFERENCES cart(id), FOREIGN KEY (user_id) REFERENCES user(id), FOREIGN KEY (promo_id) REFERENCES promo(id), FOREIGN KEY (delivery_id) REFERENCES deliverie(id), FOREIGN KEY (payment_id) REFERENCES payment(id));

CREATE TABLE invoice (id INT PRIMARY KEY AUTO_INCREMENT, number INT NOT NULL, order_id INT NOT NULL,  FOREIGN KEY (order_id) REFERENCES order(id));

-- Insertion de données fictives

INSERT INTO users (firstname, lastname, email, password, phone, birthday, role) VALUES
('John', 'Doe', 'john.doe@example.com', 'password123', '123-456-7890', '1990-05-15', 'customer'),
('Alice', 'Smith', 'alice.smith@example.com', 'pass456', '987-654-3210', '1985-08-22', 'admin'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'securePass', '555-123-4567', '1978-12-03', 'customer');

INSERT INTO categories (name, image, description) VALUES
('Electronics', 'electronics.jpg', 'Electronic gadgets and devices'),
('Clothing', 'clothing.jpg', 'Fashion and apparel'),
('Home Decor', 'homedecor.jpg', 'Decorative items for your home');

INSERT INTO products (name, price, description, category_id) VALUES
('Smartphone X', 799.99, 'High-end smartphone with advanced features', 1),
('Laptop Pro', 1299.99, 'Powerful laptop for professional use', 1),
('T-shirt Basic', 19.99, 'Comfortable cotton t-shirt', 2),
('Decorative Lamp', 49.99, 'Elegant lamp for your living room', 3);

INSERT INTO reviews (title, content, note, user_id, product_id) VALUES
('Great product!', 'I love my new smartphone. It has amazing features.', 5, 1, 1),
('Highly recommended', 'The laptop exceeded my expectations. Excellent performance.', 5, 2, 2),
('Nice t-shirt', 'Comfortable and fits well. Happy with the purchase.', 4, 3, 3),
('Beautiful lamp', 'The lamp adds a nice touch to my living room. Very satisfied.', 5, 2, 4);

INSERT INTO tags (name) VALUES
('High-end'),
('Fashion'),
('Home Decor'),
('Recommended');

INSERT INTO products_tags (product_id, tag_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);

INSERT INTO stocks (product_id, quantity) VALUES
(1, 10),
(2, 5),
(3, 100),
(4, 20);

INSERT INTO promos (name, date, discount) VALUES
('Summer Sale', '2021-07-01 00:00:00', 0.2),
('Black Friday', '2021-11-26 00:00:00', 0.3);

INSERT INTO carts (id) VALUES
(1),
(2);

INSERT INTO product_carts (quantity, product_id, cart_id) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(1, 4, 2);


// version code jensone : 

-- BASE DE DONNÉES E-COMMERCE

-- Création de la BDD
CREATE DATABASE IF NOT EXISTS ecom;
-- IF NOT EXISTS permet de ne pas créer la BDD si elle existe déjà

-- Spécification de la BDD à utiliser
USE ecom;

-- Création des tables (entités)
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    email VARCHAR(100) NOT NULL,
    password VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    birthday DATE,
    role VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    image VARCHAR(255),
    description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    description TEXT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    note INT NOT NULL,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS products_tags (
    product_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS product_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    link VARCHAR(255) NOT NULL,
    small VARCHAR(255) NOT NULL,
    medium VARCHAR(255),
    large VARCHAR(255),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS stocks (
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS carts (
    id INT PRIMARY KEY AUTO_INCREMENT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS product_carts (
    quantity INT NOT NULL,
    product_id INT NOT NULL,
    cart_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (cart_id) REFERENCES carts(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status BOOLEAN NOT NULL DEFAULT 0,
    amount FLOAT NOT NULL,
    date datetime DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(255) NOT NULL,
    type VARCHAR(20) NOT NULL -- CB, Paypal, etc.
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS promos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    date DATETIME NOT NULL,
    discount FLOAT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS deliveries ( 
    id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip VARCHAR(10) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'France',
    details TEXT,
    default_address BOOLEAN NOT NULL DEFAULT 0,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    cart_id INT NOT NULL,
    user_id INT NOT NULL,
    promo_id INT NOT NULL,
    delivery_id INT NOT NULL,
    payment_id INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (promo_id) REFERENCES promos(id),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(id),
    FOREIGN KEY (payment_id) REFERENCES payments(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number INT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insertion de données fictives

INSERT INTO users (firstname, lastname, email, password, phone, birthday, role) VALUES
('John', 'Doe', 'john.doe@example.com', 'password123', '123-456-7890', '1990-05-15', 'customer'),
('Alice', 'Smith', 'alice.smith@example.com', 'pass456', '987-654-3210', '1985-08-22', 'admin'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'securePass', '555-123-4567', '1978-12-03', 'customer');

INSERT INTO categories (name, image, description) VALUES
('Electronics', 'electronics.jpg', 'Electronic gadgets and devices'),
('Clothing', 'clothing.jpg', 'Fashion and apparel'),
('Home Decor', 'homedecor.jpg', 'Decorative items for your home');

INSERT INTO products (name, price, description, category_id) VALUES
('Smartphone X', 799.99, 'High-end smartphone with advanced features', 1),
('Laptop Pro', 1299.99, 'Powerful laptop for professional use', 1),
('T-shirt Basic', 19.99, 'Comfortable cotton t-shirt', 2),
('Decorative Lamp', 49.99, 'Elegant lamp for your living room', 3);

INSERT INTO reviews (title, content, note, user_id, product_id) VALUES
('Great product!', 'I love my new smartphone. It has amazing features.', 5, 1, 1),
('Highly recommended', 'The laptop exceeded my expectations. Excellent performance.', 5, 2, 2),
('Nice t-shirt', 'Comfortable and fits well. Happy with the purchase.', 4, 3, 3),
('Beautiful lamp', 'The lamp adds a nice touch to my living room. Very satisfied.', 5, 2, 4);

INSERT INTO tags (name) VALUES
('High-end'),
('Fashion'),
('Home Decor'),
('Recommended');

INSERT INTO products_tags (product_id, tag_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3);

INSERT INTO stocks (product_id, quantity) VALUES
(1, 10),
(2, 5),
(3, 100),
(4, 20);

INSERT INTO promos (name, date, discount) VALUES
('Summer Sale', '2021-07-01 00:00:00', 0.2),
('Black Friday', '2021-11-26 00:00:00', 0.3);

INSERT INTO carts (id) VALUES
(1),
(2);

INSERT INTO product_carts (quantity, product_id, cart_id) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(1, 4, 2);
