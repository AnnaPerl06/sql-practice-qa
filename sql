-- Задача 1: Вывести все колонки из таблицы orders для категории 'Одежда'.
SELECT * FROM orders WHERE category = 'Одежда';

-- Задача 2: Вывести номер заказа и цену из таблицы orders, отсортировав от самых дорогих к дешевым.
SELECT order_id, price FROM orders ORDER BY price DESC;

-- Задача 3: Найти все заказы в таблице orders, где не указана почта клиента.
SELECT * FROM orders WHERE customer_email IS NULL;

-- Задача 4: Выгрузить order_id, price и status для заказов, которые завершены или возвращены, но при этом клиент не вводил промокод.
SELECT order_id, price, status 
FROM orders 
WHERE (status = 'Завершенный' OR status = 'Возвращенный') 
AND promo_code IS NULL;

-- Задача 5: Вывести номера заказов и их суммы из таблицы orders, оставить только те заказы, у которых статус 'Завершенный', а сумма чека превышает 5000. Отсортировать по сумме чека от самых крупных к самым мелким.
SELECT order_id, total_amount FROM orders WHERE status = 'Завершенный' AND total_amount > 5000 ORDER BY total_amount DESC;

-- Задача 6: Подсчитать общую сумму всех заказов за всё время из таблицы orders.
SELECT SUM(total_amount) AS total_sum FROM orders;

-- Задача 7: Вывести количество успешных заказов, общую выручку, средний чек, а также минимальную и максимальную цену для заказов со статусом 'Завершенный'.
SELECT 
COUNT(order_id) AS completed_orders_count,
SUM(total_amount) AS total_revenue,
AVG(total_amount) AS average_check,
MIN(price) AS min_price,
MAX(price) AS max_price 
FROM orders 
WHERE status = 'Завершенный';

-- Задача 8: Найти все заказы, сделанные с 1 по 15 мая 2026 года, у которых почта покупателя заканчивается на @example.com, отсортировать по цене от самых дорогих к самым дешевым.
SELECT * 
FROM orders 
WHERE order_date BETWEEN '2026-05-01' AND '2026-05-15 23:59:59' 
AND customer_email LIKE '%@example.com' 
ORDER BY price DESC;

-- Задача 9: Вывести product_id, name и rating для товаров, у которых значение is_active равно TRUE, и при этом выполняется одно из двух условий: либо остаток на складе (stock) равен 0, либо рейтинг имеет значение NULL.
SELECT product_id, name, rating FROM products WHERE is_active = 1 AND (stock = 0 OR rating IS NULL);

-- Задача 10: Найти все товары, у которых в названии содержится слово 'Кроссовки'. Категория товара — либо 'Обувь', либо 'Спорт'. Цена должна находиться в диапазоне от 2000 до 8000 включительно. Значение остатка на складе (stock) отсутствует (NULL).
SELECT * FROM products 
WHERE name LIKE '%Кроссовки%'
AND category IN ('Обувь', 'Спорт')
AND price BETWEEN 2000 AND 8000
AND stock IS NULL;

-- Задача 11: Вывести количество заказов в разрезе каждой категории из таблицы orders.
SELECT 
category,
COUNT(order_id) AS orders_count
FROM orders
GROUP BY category;

-- Задача 12: Вывести название категории и количество отмененных заказов ('Возвращенный'), показать только те категории, где количество отмен строго больше 50.
SELECT 
category,
COUNT(order_id) AS canceled_orders_count 
FROM orders 
WHERE status = 'Возвращенный'
GROUP BY category 
HAVING COUNT(order_id) > 50;

-- Задача 13: Сгруппировать данные по колонке category. Посчитать количество товаров в каждой группе (колонка total_items). Посчитать среднюю цену в каждой группе (колонка avg_price). Оставить в итоговой таблице только те товары, у которых is_active имеет значение TRUE. Вывести только те категории, в которых средняя цена меньше 5000.
SELECT 
category,
COUNT(product_id) AS total_items,
AVG(price) AS avg_price
FROM products 
WHERE is_active = 1
GROUP BY category 
HAVING AVG(price) < 5000;

-- Задача 14: Из двух таблиц users (user_id, name) и orders (order_id, user_id) вывести имена всех пользователей и номера их заказов, чтобы в список попали только те пользователи, которые сделали хотя бы один заказ. 
SELECT users.name, orders.order_id
FROM users
INNER JOIN orders ON users.user_id = orders.user_id;
