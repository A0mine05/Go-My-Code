-- Checkpoint 6 : Data Query Langage --
/*
1) Écrivez une requête SQL pour récupérer les noms des clients qui ont commandé 
- au moins un widget et au moins un gadget, 
- ainsi que le coût total des widgets et gadgets commandés par chaque client. 
- Le coût de chaque article doit être calculé en multipliant la quantité par le prix du produit.
*/
Select customer_name, price*quantity from 
    Customer INNER JOIN (
        Products INNER JOIN Orders ON Products.product_id = Orders.product_id
        WHERE category = 'gadget' OR category = 'widget'
    ) x ON Customer.customer_id = x.customer_id group by customer_name;

/*
2) Écrivez une requête pour récupérer les noms des clients qui ont passé une commande 
- pour au moins un widget, 
- ainsi que le coût total des widgets commandés par chaque client.
*/
Select customer_name, price*quantity from 
    Customer INNER JOIN (
        Products INNER JOIN Orders ON Products.product_id = Orders.product_id
        WHERE category = 'widget'
    ) x ON Customer.customer_id = x.customer_id group by customer_name;

/*
3) Rédigez une requête pour récupérer les noms des clients qui ont passé une commande 
- pour au moins un gadget, 
- ainsi que le coût total des gadgets commandés par chaque client.
*/
Select customer_name, price*quantity from 
    Customer INNER JOIN (
        Products INNER JOIN Orders ON Products.product_id = Orders.product_id
        WHERE category = 'gadget'
    ) x ON Customer.customer_id = x.customer_id group by customer_name;

/*
4) Écrivez une requête pour récupérer les noms des clients qui ont commandé 
- au moins un doohickey, 
- ainsi que le coût total des doohickeys commandés par chaque client.
*/
Select customer_name, price*quantity from 
    Customer INNER JOIN (
        Products INNER JOIN Orders ON Products.product_id = Orders.product_id
        WHERE category = 'doohickey'
    ) x ON Customer.customer_id = x.customer_id group by customer_name;

/*
5) Rédigez une requête pour récupérer le nombre total de widgets et de gadgets commandés par chaque client, 
- ainsi que le coût total des commandes.
*/
Select count(*), total_amount from Products INNER JOIN Orders ON Products.product_id = Orders.product_id 
    WHERE category = 'widget' AND category = 'gadget' group by customer_id;

/*
6) Écrivez une requête pour récupérer les noms des produits qui ont été commandés 
- par au moins un client, 
- ainsi que la quantité totale de chaque produit commandé.
*/
Select product_name, quantity from 
    Products INNER JOIN Orders ON Products.product_id = Orders.product_id group by product_id;

/*
7) Rédigez une requête pour récupérer les noms des clients qui ont passé le plus de commandes, 
- ainsi que le nombre total de commandes passées par chaque client.
*/
Select customer_id, count(*) from Customer INNER JOIN Orders group by
    customer_id DESC limit 5;

/*
8) Rédigez une requête pour récupérer les noms des produits les plus commandés, 
- ainsi que la quantité totale de chaque produit commandé.
*/
Select product_name, quantity from Products INNER JOIN Orders ON Products.product_id = Orders.product_id
    DESC limit 5 ; 


/*
9) Écrivez une requête pour récupérer les noms des clients qui ont passé une commande 
- chaque jour de la semaine, 
- ainsi que le nombre total de commandes passées par chaque client.
*/
Select customer_name, count(*) from
    Customer INNER JOIN Orders ON Customer.customer_id = Orders.customer_id
    where OrderDate IN ('Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche')
    group by customer_name;

--- checkPoint 7 : Gestion de bases de données relationnel ---

/*
1) Convertissez le diagramme de relation d'entité en modèle relationnel.
*/
Wine (NumP, Category, Year, Degree);
Producer (Nump, FirstName, LastName, Region);
Harvest (NumW, NumP, Quantity);

/*
2) Donnez la liste des producteurs.
*/
Select * from Producer;

/*
3) Donnez la liste des producteurs triés par nom.
*/
Select * from Producer group by FirstName;

/*
4) Donner la liste des producteurs de Sousse.
*/
Select *  from Producer where Region = 'Sousse';

/*
5) Calculer la quantité totale de vin produit portant le numéro 12.
*/
Select count (*) from Harvest where numW = '12';

/*
6) Calculer la quantité de vin produit par catégorie.
*/
Select Quantity from Harvest INNER JOIN Wine ON Harvest.numW = Wine.numW group by Category ;

/*
7) Quels producteurs de la région de Sousse ont récolté au moins un vin en quantités supérieures à 300 litres ? Nous voulons les noms et prénoms des producteurs, triés par ordre alphabétique.
*/
Select FirstName, LastName from Producer INNER JOIN Harvest ON Producer.numP = Harvest.numP 
where Quantity > 300 AND Region ='Sousse' DESC;

/*
8) Énumérez les numéros de vin qui ont un degré supérieur à 12 et qui ont été produits par le producteur numéro 24.
*/ 
Select numW from Wine INNER JOIN Harvest ON Wine.numP = Harvest.numP 
where numP ='24' AND Degree > 12;