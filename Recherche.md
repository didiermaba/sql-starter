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

SELECT CONCAT(users.firstname, ' ', users.lastname), COUNT(product_carts.quantity), SUM(products.price) FROM `users`, `products`, `product_carts`, `orders`, `carts` WHERE `users`.`id` = `orders`.`user_id` AND `carts`.`id` = `product_carts`.`cart_id` AND `carts`.`id` = `orders`.`cart_id` GROUP BY `users`.`firstname`, `users`.`lastname` AND users.id=1;

Exercices
1 - Réalise une requête qui retourne un panier et son contenu.

SELECT
    `carts`.`cart_id`,
    `product_carts`.`quantity`,
    `products`.`product_id`,
    `products`.`product_name`,
    `products`.`product_price`,
    `products`.`product_description`
FROM
    `carts`
JOIN
    `product_carts` ON `carts`.`id` = `product_carts`.`cart_id`
JOIN
    `products` ON `product_carts`.`product_id` = `products`.`id`
WHERE
    `carts`.`id` = 1; 


SELECT
    c.id AS cart_id, -- c est un alias pour l'id de carts
    pc.quantity, -- pc est un alias pour la quantité de product_carts
    p.id AS product_id, -- p est un alias pour l'id de products
    p.name AS product_name, -- p est un alias pour le nom de products
    p.price AS product_price, -- p est un alias pour le prix de products
    p.description AS product_description -- p est un alias pour la description de products
FROM
    carts c -- ici on utilise l'alias c pour carts
JOIN
    product_carts pc ON c.id = pc.cart_id -- on fait une jointure entre carts et product_carts
JOIN
    products p ON pc.product_id = p.id -- on fait une jointure entre product_carts et products
WHERE
    c.id = 2; -- on détermine le panier à afficher
2 - Réalise une requête qui retourne un produit avec sa catégorie et ses étiquettes (tags) et son contenu.

SELECT 
    `products`.`name`,
    `products`.`description`,
    `products`.`price`,
    `categories`.`name`,
    `tags`.`name`,
    `products`.`id`
FROM `products`
JOIN `categories` ON `products`.`category_id` = `categories`.`id`
JOIN `tags` ON `products_tags`.`tag_id` = `tags`.`id`
WHERE `products`.`id` = 1;
3 - Rédige une requête SQL complexe qui afficher le résultat suivant :

"Le client "X" va acheter "Y" produits pour un montant total de "Z" euros."

X = Nom Prenom Y = Nombre de produits Z = Montant total