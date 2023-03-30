<p align="center">
   <br/>
   <a href="https://next-auth.js.org" target="_blank"><img width="200px" src="https://comicsmore.s3.eu-west-3.amazonaws.com/logo.png" /></a>
   <h3 align="center">Comics More</h3>
   <p align="center">
    Site e-commerce de lecture de comics en ligne
   </p>

![alt text](https://github.com/alexiglnt/comics-more/blob/main/front/src/assets/img_readme/home.png?raw=true)
![alt text](https://github.com/alexiglnt/comics-more/blob/main/front/src/assets/img_readme/carroussel.png?raw=true)
![alt text](https://github.com/alexiglnt/comics-more/blob/main/front/src/assets/img_readme/comics.png?raw=true)
![alt text](https://github.com/alexiglnt/comics-more/blob/main/front/src/assets/img_readme/paypal.png?raw=true)
![alt text](https://github.com/alexiglnt/comics-more/blob/main/front/src/assets/img_readme/account.png?raw=true)
![alt text](https://github.com/alexiglnt/comics-more/blob/main/front/src/assets/img_readme/dc.png?raw=true)

# Pour le jury

Pour tester le site, vous pouvez vous créer un compte utilisateur ou utiliser les identifiants d'un compte administrateur :
email : jackbiboustone@gmail.com
Mdp : password

Un administrateur dispose de tout les comics gratuitement et peut naviguer sur tout le site sans utiliser de crédits. Toutn les comics sont stockés dans sa bibibliothèque personnelle.

# Comics More

Comics More est un site en ligne dédié à la lecture de comics, tels que **MARVEL** et **DC Comics**. Le site utilise un système de **crédits** pour l'achat de ces bandes dessinées, chaque comics étant évalué en fonction de son nombre de pages. Les utilisateurs reçoivent 10 crédits gratuits lors de leur inscription. Ils ont le choix entre deux **modes de paiement** pour acheter des crédits : par **carte bancaire** ou via un **compte PayPal**. Une fois les crédits achetés, les utilisateurs peuvent retrouver leurs comics dans leur **bibliothèque personnelle**. Ils peuvent effectuer des recherches de comics en utilisant la barre de recherche ou en explorant les différentes collections de personnages. Par exemple, la collection Spider-Man regroupe tous les comics liés à ce personnage, qui est publié sous la maison d'édition Marvel. Les utilisateurs peuvent également ajouter des comics à leurs favoris.

Comics More utilise les Frameworks **Vue.js** et **Symfony** pour développer le site, stockant les informations dans une base de données. Les images des comics, quant à elles, sont stockées sur **Amazon Web Services (AWS)**. La base de données contient toutes les informations liées aux comics ainsi qu'aux utilisateurs. Le site est relié à la base de données via une API développer en PHP avec Symfony, qui fait le lien entre le back-end et le front-end.

Pour l'authentification des utilisateurs, Comics More utilise le système **lexik-jwt-authentication** avec des **tokens** qui expirent après un certain temps. Les mots de passe des utilisateurs sont cryptés. Les administrateurs ont accès à des fonctionnalités spéciales, tels que la lecture gratuite de tous les comics et la possibilité de naviguer sur tout le site sans utiliser de crédits.

## Technologies utilisées

### Front-end

- Vue.js
- HTML
- CSS
- Vite
- Photoshop
- Bibliothèque d'animation (GSAP, AOS, animate.css, etc...)


### Back-end

- Symfony
- XAMPP
- API Platform
- Postman
- AWS
- lexik-JWT-authentication


## Get started

### Prérequis

- PHP 7.4
- Composer
- Node.js
- NPM
- Symfony CLI

### Installation

1. Cloner le projet
2. Installer les dépendances avec `composer install`
3. Installer les dépendances avec `npm install`
4. Créer un fichier `.env.local` à la racine du projet et y ajouter les informations de connexion à la base de données
5. Créer la base de données avec `symfony console doctrine:database:create`
6. Créer les tables avec `symfony console doctrine:migrations:migrate`
7. Lancer le serveur avec `symfony server:start`
8. Lancer le serveur de développement avec `npm run dev`




