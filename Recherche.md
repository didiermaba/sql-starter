# Recherche avec SQL

On dispose de différent opérateur comme en programmation pour faire des recherches dans une base de données :


## Opérateurs logique 

AND et OR 

## Opérateurs arthmétiques 

| Opérateur | Description |
| --- | --- |
| + | Addition |
| - | Soustraction |
| * | Multiplication |
| / | Division |
| % | Modulo |

## Opérateurs comparaison 

Tableau complet : https://sql.sh/cours/where


## Exemples 

```sql
-- Recherche avec LIKE et AND ou OR
SELECT * FROM `products` 
WHERE (CONVERT(`name` USING utf8) 
LIKE '%smartphone%' 
AND CONVERT(`description` USING utf8) 
LIKE '%smartphone%');


-- Recherche avec INNER JOIN
SELECT 
    `title`, 
    `content`, 
    `note`, 
    `user_id`, 
    `product_id`
FROM `reviews`
INNER JOIN `products` ON `reviews`.`product_id` = `products`.`price`
INNER JOIN `users` ON `reviews`.`user_id`= `users`.`firstname`
;

-- Recherche avec LEFT JOIN
SELECT
    `reviews`.`title`,
    `reviews`.`content`,
    `reviews`.`note`,
    `reviews`.`user_id`,
    `users`.`firstname`,
    `reviews`.`product_id`,
    `products`.`name`
FROM
    `reviews`
LEFT JOIN `users` ON `reviews`.`user_id` = `users`.`id`
LEFT JOIN `products` ON `reviews`.`product_id` = `products`.`id`;
```

Page récapitulatif des recherches avec jointures : [Jointures SQL](https://sql.sh/cours/jointures)


SELECT * FROM `product_carts`, `carts` WHERE `product_carts`.`cart_id` = `carts`.`id`;

SELECT * FROM `carts`, `categories`, `product_carts`, `products` WHERE `product_carts`.`cart_id` = `carts`.`id`AND `product_carts`.`product_id` = `products`.`id`, `products.category_id` = `categories`.`id`;

SELECT * FROM `products`, `categories`, `tags`, `products_tags` WHERE `products`.`category_id` = `categories`.`id` AND `products`.`id` = `products_tags`.`product_id` AND `products_tags`.`tag_id` = `tags`.`id` AND `products`.`id` = 1 LIMIT 0, 25;

SELECT products.name, products.description, products.price, categories.name, tags.name, products_tags.product_id FROM `products`, `categories`, `tags`, `products_tags` WHERE `products`.`category_id` = `categories`.`id` AND `products`.`id` = `products_tags`.`product_id` AND `products_tags`.`tag_id` = `tags`.`id` LIMIT 0, 25;

SELECT products.name, products.description, products.price, categories.name, tags.name, products_tags.product_id FROM `products`, `categories`, `tags`, `products_tags` WHERE `products`.`category_id` = `categories`.`id` AND `products`.`id` = `products_tags`.`product_id` AND `products_tags`.`tag_id` = `tags`.`id` AND `products`.`id` = 1 LIMIT 0, 25;