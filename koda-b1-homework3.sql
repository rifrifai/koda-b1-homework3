-- CREATE DATABASE koda_b1_homework3;
-- select tablename from pg_tables;
-- Tabel Users
-- CREATE TABLE users (
--     id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name VARCHAR(100) NOT NULL,
--     email VARCHAR(100) UNIQUE NOT NULL,
--     alamat TEXT,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
-- ALTER TABLE products ALTER COLUMN price TYPE DECIMAL(7, 2);

-- Tabel Products
-- CREATE TABLE products (
--     id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     name VARCHAR(150) NOT NULL,
--     price NUMERIC(12, 2) NOT NULL CHECK (price > 0),
--     stock INT DEFAULT 0 CHECK (stock >= 0),
--     photo VARCHAR(255),
--     "desc" TEXT
-- );

-- -- Tabel Orders (Sudah Memenuhi 3NF)
-- CREATE TABLE orders (
--     id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     qty INT NOT NULL CHECK (qty > 0),
--     subtotal NUMERIC(12, 2) NOT NULL CHECK (subtotal >= 0),
--     order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     user_id INTEGER NOT NULL REFERENCES users(id),
--     product_id INTEGER NOT NULL REFERENCES products(id)
-- );
-- -- INSERT
-- INSERT INTO users (name, email, alamat) VALUES
-- ('Budi Santoso', 'budi@gmail.com', 'Jl. Sudirman No. 12, Jakarta'),
-- ('Siti Rahma', 'siti@gmail.com', 'Jl. Asia Afrika No. 45, Bandung'),
-- ('Andi Wijaya', 'andi@gmail.com', 'Jl. Pemuda No. 88, Surabaya'),
-- ('Dewi Lestari', 'dewi@gmail.com', 'Jl. Malioboro No. 10, Yogyakarta');

-- INSERT INTO products (name, price, stock, photo, "desc") VALUES
-- ('Pitik Burger', 15000.00, 10, 'pitik-burger.jpg', 'Burger ayam crispy dengan selada dan saus khas Bangor, pilihan hemat yang tetap mengenyangkan.'),
-- ('Single Burger', 23000.00, 50, 'single-burger.jpg', 'Satu patty 100% daging sapi Australia dengan sayuran segar dan saus spesial.'),
-- ('Double Burger', 33000.00, 25, 'double-burger.jpg', 'Dua patty daging sapi Australia untuk kamu yang ingin porsi lebih besar.'),
-- ('Cheese Burger', 27000.00, 15, 'cheese-burger.jpg', 'Patty sapi Australia dengan keju leleh, selada, dan tomat segar.'),
-- ('Double Cheese Burger', 38000.00, 15, 'double-cheese-burger.jpg', 'Dua patty sapi dengan dua lapis keju leleh, burger paling puas untuk pecinta keju.'),
-- ('Smoky Beef Burger', 30000.00, 15, 'dsmoky-beef-burger.jpg', 'Patty sapi dengan saus smoky yang gurih dan aroma panggangan yang khas.');


-- INSERT INTO orders (user_id, product_id, qty, subtotal) VALUES
-- (1, 1, 1, 15000.00),
-- (1, 2, 2, 46000.00),
-- (2, 2, 1, 23000.00),
-- (2, 4, 1, 27000.00),
-- (3, 3, 2, 66000.00),
-- (3, 1, 1, 15000.00),
-- (4, 5, 2, 76000.00)
-- SELECT * FROM orders;
-- QUERY SELECT LENGKAP
-- WHERE, ORDER BY, JOIN, GROUP BY, HAVING, dan Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
SELECT 
    u.id AS user_id,
    u.name AS nama_user,
    COUNT(o.id) AS total_transaksi,
    SUM(o.qty) AS total_item_dibeli,
    SUM(o.subtotal) AS total_pengeluaran,
    ROUND(AVG(o.subtotal), 2) AS rata_rata_per_transaksi,
    MIN(o.subtotal) AS transaksi_terkecil,
    MAX(o.subtotal) AS transaksi_terbesar
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.subtotal > 5000.00
GROUP BY u.id, u.name
HAVING SUM(o.subtotal) >= 10000.00
ORDER BY total_pengeluaran DESC;
