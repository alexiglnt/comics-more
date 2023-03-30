-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 30 mars 2023 à 09:51
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `api_ptut_v2`
--

-- --------------------------------------------------------

--
-- Structure de la table `bookmark`
--

CREATE TABLE `bookmark` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comics_id` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `bookmark`
--

INSERT INTO `bookmark` (`id`, `user_id`, `comics_id`) VALUES
(1369, 2, '/2/10/22/21/18/16/20/5/15/21/'),
(1387, 1, '/16/5/17/27/'),
(1389, 3, '/7/23/21/26/25/'),
(1390, 9, '/19/'),
(1391, 10, '/7/23/'),
(1392, 11, '/2/1/12/6/'),
(1393, 5, '/6/'),
(1394, 8, '/1/'),
(1399, 20, '/'),
(1400, 27, '/27/'),
(1401, 28, '/6/');

-- --------------------------------------------------------

--
-- Structure de la table `comic`
--

CREATE TABLE `comic` (
  `id` int(11) NOT NULL,
  `comics_collection_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `nb_page` int(11) NOT NULL,
  `extension` varchar(255) NOT NULL,
  `credits` int(11) NOT NULL,
  `note` double DEFAULT NULL,
  `users_who_noted` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `comic`
--

INSERT INTO `comic` (`id`, `comics_collection_id`, `name`, `nb_page`, `extension`, `credits`, `note`, `users_who_noted`) VALUES
(1, 1, 'Maestro', 129, 'jpeg', 2, 2.5, '2'),
(2, 2, 'Batman01', 177, 'webp', 2, 4, '3,2'),
(4, 3, 'Old+man+Logan+T1', 92, 'jpg', 1, 3, ''),
(5, 2, 'Batman02', 210, 'webp', 3, NULL, ''),
(6, 4, 'Docteur+Fatalis+T1+-+Mort+dans+l_après-midi', 134, 'jpg', 2, 4, '28'),
(7, 2, 'Batman03', 180, 'webp', 2, 3.5, '2'),
(10, 5, 'Cosmic+Ghost+Rider+-+La+Vengeance+du+Ghost+Rider+Cosmique', 121, 'jpg', 2, 4, '3'),
(11, 5, 'Cosmic+Ghost+Rider+-+Le+Ghost+Rider+Cosmique+détruit+l\'histoire+Marvel', 130, 'jpg', 2, NULL, ''),
(12, 6, 'Secret+Invasion', 243, 'jpg', 3, NULL, ''),
(13, 3, 'Old+man+Logan+T2', 92, 'jpg', 1, NULL, ''),
(14, 3, 'Old+man+Logan+T3', 114, 'jpg', 2, NULL, ''),
(15, 7, 'All+Star+Superman', 310, 'webp', 4, NULL, ''),
(16, 8, 'The+Superior+Spider-Man+T0-.Prélude', 133, 'jpg', 2, NULL, ''),
(17, 8, 'The+Superior+Spider-Man+T1', 125, 'jpg', 2, 3, '3'),
(18, 9, 'Flash+Rebirth+T1', 230, 'jpg', 3, 3, '2'),
(19, 9, 'Flash+Rebirth+T2', 112, 'jpg', 2, NULL, ''),
(20, 10, 'Invincible+-+01+-+Affaires+de+famille', 146, 'jpg', 2, NULL, ''),
(21, 10, 'Invincible+-+02+-+Au+nom+du+père', 146, 'jpg', 2, NULL, ''),
(22, 11, 'The+Boys+1+(1920)', 144, 'jpg', 2, 3.5, '2'),
(23, 11, 'The+Boys+2+(1920)', 97, 'jpg', 1, NULL, ''),
(24, 2, 'AllStar+Batman+T1', 202, 'jpg', 3, NULL, ''),
(25, 2, 'AllStar+Batman+T2', 138, 'jpg', 2, NULL, ''),
(26, 2, 'AllStar+Batman+T3', 197, 'jpg', 2, 4, '3'),
(27, 12, 'The+JOJOLands+-+Chapitre+1', 61, 'jpg', 1, 3.5, '3,2,27,11,1');

-- --------------------------------------------------------

--
-- Structure de la table `comics_collection`
--

CREATE TABLE `comics_collection` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `house_id` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `comics_collection`
--

INSERT INTO `comics_collection` (`id`, `name`, `house_id`, `description`) VALUES
(1, 'Hulk', 1, 'Hulk est un personnage de fiction créé par Marvel Comics. C\'est un super-héros qui a été exposé à des radiations gamma lors d\'une expérience scientifique qui a mal tourné, et qui a acquis une force physique surhumaine. Le Dr Bruce Banner, qui se transforme en Hulk lorsque sa colère est déclenchée, doit apprendre à maîtriser cette force et à la canaliser pour l\'utiliser de manière positive. Bien qu\'il soit un héros bienveillant, Hulk est souvent considéré comme un monstre en raison de son apparence physique et de son potentiel destructeur, ce qui le rend parfois rejeté par la société.'),
(2, 'Batman', 2, 'Batman est un personnage de fiction appartenant à l\'univers DC Comics. Il est également connu sous le nom de Bruce Wayne, un riche homme d\'affaires de Gotham City qui, après avoir été témoin du meurtre de ses parents, décide de consacrer sa vie à la lutte contre le crime en utilisant sa fortune et ses compétences physiques et intellectuelles. Il est considéré comme l\'un des plus grands détectives du monde et utilise une variété de gadgets et de technologies pour l\'aider dans sa mission. Bien qu\'il n\'ait pas de super-pouvoirs, il est souvent considéré comme l\'un des super-héros les plus emblématiques et populaires de tous les temps.'),
(3, 'Wolverine', 1, 'Wolverine est un personnage de fiction appartenant à l\'univers des X-Men de Marvel Comics. Il s\'agit d\'un mutant doté d\'un facteur de guérison accéléré, qui lui permet de régénérer rapidement ses tissus corporels et de récupérer rapidement de ses blessures. Il possède également des griffes rétractables en adamantium, un métal indestructible, qui sortent de ses poings lorsqu\'il est en colère ou en danger. Wolverine est souvent représenté comme un personnage violent et impulsif, mais qui se bat pour protéger les personnes qu\'il aime et les innocents en danger.'),
(4, 'Doctor Doom', 1, 'Doctor Doom est un super-vilain de l\'univers Marvel Comics, créé par le scénariste Stan Lee et le dessinateur Jack Kirby. Il apparaît pour la première fois en 1962 dans Fantastic Four #5. Le personnage est le principal ennemi des Quatre Fantastiques, mais il a également combattu de nombreux autres héros de l\'univers Marvel.\n\nDocteur Doom est en réalité Victor von Doom, un génie scientifique et sorcier d\'origine latvienne. Il est obsédé par le pouvoir et la domination mondiale, et utilise ses compétences en technologie avancée et en magie noire pour poursuivre ses ambitions maléfiques.\n\nLe personnage est connu pour son armure de haute technologie, qui lui confère une grande force, une résistance aux dommages et une variété d\'armes intégrées. Il possède également des pouvoirs de sorcellerie, tels que la téléportation et la manipulation de la matière.\n\nDocteur Doom est souvent considéré comme l\'un des plus grands super-vilains de tous les temps, grâce à son intelligence, sa détermination et son charisme. Sa rivalité avec les Quatre Fantastiques a été l\'un des arcs narratifs les plus durables de l\'univers Marvel, et il est devenu une présence régulière dans de nombreuses séries de bande dessinée, adaptations cinématographiques et jeux vidéo.'),
(5, 'Ghost Rider', 1, 'Le personnage de Ghost Rider est un super-héros surnaturel appartenant à l\'univers de Marvel Comics. Il a été créé en 1972 par les auteurs Roy Thomas, Gary Friedrich et Mike Ploog.\n\nLe personnage de Ghost Rider est généralement représenté sous les traits de Johnny Blaze, un cascadeur de moto qui a conclu un pacte avec le diable pour sauver la vie de son père adoptif. En échange de son âme, Blaze est transformé en Ghost Rider, un être surnaturel avec des pouvoirs incroyables, y compris la capacité de projeter des flammes et de manier une chaîne de fer enflammée.\n\nEn tant que Ghost Rider, Blaze utilise ses pouvoirs pour combattre les forces du mal et protéger les innocents. Il a été membre de diverses équipes de super-héros de l\'univers Marvel, notamment les Vengeurs, les Champions et les Midnight Sons.'),
(6, 'Secret Invasion', 1, 'Secret Invasion est une série de comics publiée par Marvel Comics en 2008. L\'histoire tourne autour d\'une invasion secrète des Skrulls, une race extraterrestre capable de se métamorphoser en n\'importe quel être vivant, qui ont infiltré la Terre depuis des années. Les Skrulls ont remplacé des héros et des dirigeants de la Terre par des imposteurs, semant le chaos et la confusion. Les Avengers doivent découvrir qui est un Skrull et qui ne l\'est pas, tandis que la guerre entre les deux races atteint son paroxysme. La série a été écrite par Brian Michael Bendis et illustrée par Leinil Francis Yu. Elle a eu un impact majeur sur l\'univers Marvel, en particulier sur la continuité des Avengers et sur la façon dont les héros sont perçus par le public.'),
(7, 'Superman', 2, 'Superman est un personnage de bande dessinée et de fiction créé en 1938 par Jerry Siegel et Joe Shuster. Il est considéré comme l\'un des super-héros les plus emblématiques de la culture populaire et est souvent décrit comme l\'archétype du super-héros moderne.\n\nSuperman est un extraterrestre nommé Kal-El, originaire de la planète Krypton, qui a été envoyé sur Terre par ses parents alors que sa planète natale était sur le point d\'exploser. Il est adopté par un couple de fermiers et élevé sous le nom de Clark Kent.\n\nSuperman possède des pouvoirs extraordinaires tels que la super-force, la super-vitesse, la super-endurance et la capacité de voler. Il a également une vision thermique et des rayons X, ainsi qu\'une ouïe et une vision surhumaines. En outre, il est doté d\'un sens moral infaillible et est souvent vu comme un symbole de justice et de vérité.\n\nSuperman est souvent opposé à des ennemis puissants tels que Lex Luthor et Darkseid, mais il est également un membre fondateur de la Justice League, un groupe de super-héros de l\'univers DC Comics.'),
(8, 'Spider-Man', 1, 'Spider-Man est un super-héros fictif créé par Stan Lee et Steve Ditko, apparu pour la première fois dans Amazing Fantasy #15 en 1962. Le personnage est un jeune homme nommé Peter Parker qui acquiert des capacités surhumaines après avoir été mordu par une araignée radioactive. Ces capacités incluent la force, l\'agilité, la vitesse et la capacité de coller aux surfaces, ainsi que la capacité de lancer des toiles d\'araignée à partir de ses mains.\n\nEn tant que Spider-Man, Peter Parker utilise ses pouvoirs pour combattre le crime et protéger les citoyens de New York. Il est connu pour son sens de l\'humour et sa capacité à plaisanter en combat, ainsi que pour sa lutte constante entre sa vie personnelle et son rôle de super-héros. Il est l\'un des héros les plus populaires et les plus reconnaissables de l\'univers Marvel.'),
(9, 'Flash', 2, 'Flash est un personnage de fiction appartenant à l\'univers de DC Comics. Il a été créé en 1940 par Gardner Fox et Harry Lampert. Le personnage est en réalité un alter ego porté par plusieurs individus qui ont eu des pouvoirs similaires. Le plus célèbre des Flashs est Barry Allen, un scientifique qui a acquis des pouvoirs surhumains après avoir été frappé par la foudre et avoir été aspergé de produits chimiques. Barry est capable de se déplacer à une vitesse incroyable et de ralentir le temps, lui permettant de réagir à des situations en un éclair. Il est également capable de vibrer à travers les objets solides et de créer des éclairs avec ses mains. Le costume de Flash est principalement rouge avec des accents jaunes, et il porte un masque qui couvre tout son visage sauf les yeux. Flash est souvent membre de la Justice League et a également eu sa propre série de bandes dessinées.'),
(10, 'Invincible', 3, 'Invincible est une série de bandes dessinées de super-héros écrite par Robert Kirkman et publiée par Image Comics. L\'histoire suit un adolescent nommé Mark Grayson, qui découvre que son père est en réalité Omni-Man, un extraterrestre superpuissant qui protège la Terre en tant que super-héros. Mark développe également des superpouvoirs et décide de devenir un super-héros sous le nom d\'Invincible. Au fur et à mesure que la série progresse, Mark doit affronter divers ennemis et faire face à des choix difficiles, tout en naviguant dans sa vie adolescente normale. La série est connue pour son mélange d\'humour, d\'action et de drame, ainsi que pour son ton réaliste et mature.'),
(11, 'The Boys', 4, 'The Boys est une série de comics créée par Garth Ennis et Darick Robertson, publiée par Dynamite Entertainment. L\'histoire se déroule dans un monde où les super-héros sont devenus une entreprise lucrative et corrompue, se comportant souvent de manière impitoyable et égoïste. Dans ce contexte, une équipe de justiciers ordinaires appelée \"The Boys\" est recrutée par la CIA pour surveiller et contrôler les super-héros. La série explore des thèmes tels que la célébrité, la corruption, la violence et la moralité dans un monde où la ligne entre le bien et le mal est floue. Les comics ont été adaptés en une série télévisée éponyme produite par Amazon Prime Video en 2019.'),
(12, 'JOJO', 5, 'Le manga JoJo\'s Bizarre Adventure est une série de manga créée par Hirohiko Araki. L\'histoire suit la famille Joestar à travers plusieurs générations, chacune avec son propre protagoniste, qui a tous un surnom contenant le nom \"JoJo\". Chaque personnage principal doit affronter des ennemis aux pouvoirs surnaturels et des situations surnaturelles, en utilisant souvent un pouvoir unique connu sous le nom de \"Stand\". Le manga est connu pour son style de dessin distinctif, son intrigue complexe et ses références à la musique, à la mode et à la culture populaire. Il a également inspiré de nombreux jeux vidéo, des adaptations en anime et des produits dérivés.');

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `comic_id` int(11) NOT NULL,
  `created_at` varchar(255) NOT NULL,
  `user_commented` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `comment`
--

INSERT INTO `comment` (`id`, `content`, `user_id`, `comic_id`, `created_at`, `user_commented`) VALUES
(1, 'J\'ai beaucoup aimé !', 1, 1, '16/03/2023 10:12', 'Fernand'),
(2, 'Très bon comics !', 1, 2, '16/03/2023 10:27', 'Fernand'),
(3, 'Smaaaaaaaash', 1, 1, '16/03/2023 11:07', 'Fernand'),
(4, 'Oh lesstgoooo le nouveau chapitre !', 11, 27, '16/03/2023 11:18', 'Elon'),
(5, 'Comics délicieux aux sucre', 11, 16, '16/03/2023 14:27', 'Elon'),
(6, 'J\'ai bien aimé ce comics !', 2, 24, '23/03/2023 10:18', 'John'),
(7, '🦇🦇🦇', 1, 24, '23/03/2023 10:21', 'Fernand'),
(11, 'Rare de voir une version de Hulk méchante', 2, 1, '25/03/2023 15:10', 'John'),
(12, 'J\'ai lu ce comics aussi vite que Flash court ', 2, 18, '25/03/2023 15:12', 'John'),
(13, 'Bonne histoire à propos du Ghost Rider', 3, 10, '26/03/2023 17:08', 'Jack'),
(14, '🕷️🕷️🕸️🕸️🕸️', 3, 17, '26/03/2023 17:10', 'Jack');

-- --------------------------------------------------------

--
-- Structure de la table `credit`
--

CREATE TABLE `credit` (
  `id` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `credit`
--

INSERT INTO `credit` (`id`, `price`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20221101145936', '2023-01-12 10:43:23', 48),
('DoctrineMigrations\\Version20221101150729', '2023-01-12 10:43:23', 8),
('DoctrineMigrations\\Version20221102145646', '2023-01-12 10:43:23', 10),
('DoctrineMigrations\\Version20221111161106', '2023-01-12 10:43:23', 4),
('DoctrineMigrations\\Version20221112133520', '2023-01-12 10:43:23', 4),
('DoctrineMigrations\\Version20221121135834', '2023-01-12 10:43:23', 10),
('DoctrineMigrations\\Version20221124195431', '2023-01-12 10:43:23', 5),
('DoctrineMigrations\\Version20221124195829', '2023-01-12 10:43:23', 9),
('DoctrineMigrations\\Version20221126151609', '2023-01-12 10:43:23', 4),
('DoctrineMigrations\\Version20221126151840', '2023-01-12 10:43:23', 10),
('DoctrineMigrations\\Version20230115091613', '2023-01-15 10:16:22', 278),
('DoctrineMigrations\\Version20230115091916', '2023-01-15 10:19:25', 116),
('DoctrineMigrations\\Version20230115092049', '2023-01-15 10:20:57', 53),
('DoctrineMigrations\\Version20230119095058', '2023-01-19 10:55:34', 31),
('DoctrineMigrations\\Version20230206161349', '2023-02-06 17:13:57', 37),
('DoctrineMigrations\\Version20230206165927', '2023-02-06 17:59:31', 33),
('DoctrineMigrations\\Version20230206204822', '2023-02-06 21:48:29', 175),
('DoctrineMigrations\\Version20230208095347', '2023-02-08 10:53:57', 155),
('DoctrineMigrations\\Version20230225130438', '2023-02-25 14:04:47', 167),
('DoctrineMigrations\\Version20230307080641', '2023-03-07 09:06:48', 32),
('DoctrineMigrations\\Version20230307161421', '2023-03-07 17:14:28', 184),
('DoctrineMigrations\\Version20230316081746', '2023-03-16 09:17:58', 216),
('DoctrineMigrations\\Version20230316091238', '2023-03-16 10:13:12', 57),
('DoctrineMigrations\\Version20230316091423', '2023-03-16 10:14:30', 36),
('DoctrineMigrations\\Version20230316092453', '2023-03-16 10:24:59', 37),
('DoctrineMigrations\\Version20230316093918', '2023-03-16 10:39:25', 34);

-- --------------------------------------------------------

--
-- Structure de la table `house`
--

CREATE TABLE `house` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `house`
--

INSERT INTO `house` (`id`, `name`) VALUES
(1, 'MARVEL'),
(2, 'DC COMICS'),
(3, 'IMAGE COMICS'),
(4, 'PANINI COMICS'),
(5, 'MANGA');

-- --------------------------------------------------------

--
-- Structure de la table `library`
--

CREATE TABLE `library` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comics_user_has` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `library`
--

INSERT INTO `library` (`id`, `user_id`, `comics_user_has`) VALUES
(1, 1, '0,1,4,5,12,11,16,2,21,15,27,24'),
(2, 11, '0,15,6,11,2,27,1,16'),
(6, 2, '0,1,5,22,10,7,4,24,18'),
(7, 3, '0'),
(8, 5, '0,6'),
(9, 8, '0,1'),
(10, 9, '0'),
(11, 12, '0'),
(15, 20, '0'),
(16, 27, '0,27'),
(17, 28, '0,6,27');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `credits` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `nom`, `prenom`, `credits`) VALUES
(1, 'test@test.com', '[]', '$2y$13$O.r9U3U1WQ.gUcukpGY3qeD3l9hn9dp8F6TF.cVqcuyBwxd8ZYz6O', 'Dubois', 'Fernand', 99990),
(2, 'johndoe@gmail.com', '[]', '$2y$13$ogw4AvWK3efBX2Y0QLsrIegHrwBtx8AlmzXxzJkSZ2FmEXfKWdray', 'Doe', 'John', 26),
(3, 'jackbiboustone@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$qWlHsasxX7sZz.o0ZGxnX.yFqdfjkGAbo4qT/qvTdXm98CLyZ5aAS', 'Biboustone', 'Jack', 15),
(4, 'contact.comicsmore@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$3MBBFjLcM1YSc2CTk8y8UuBazTOLDgTHQugXTwhKwqvSrzFlkHRV.', 'Stark', 'Tony', 10),
(5, 'xavidup@gmail.com', '[]', '$2y$13$5hEOXQX3xFkk8H5SNqx0Euh2G9Zeos0sdyhcYtqurkQEHTvHwNKp6', 'Dupie', 'Xavier', 8),
(6, 'jotarokujo@gmail.com', '[]', '$2y$13$igxLVLHMv1B6IPjHi9B73O7ehtp0lUhSLplB73i7LbPleBYe3QRf6', 'Kujo', 'Jotaro', 10),
(8, 'pickychaudy@free.fr', '[]', '$2y$13$FPh9d3ghwiCFud9JWn9zwuqyKDZcmm/lrUufKS/XYJNn1auVClmU.', 'Chaudy', 'Picky', 8),
(9, 'maxoupoizat@gmail.com', '[]', '$2y$13$N/Vy/fU/b8RGGsC8CVlh2eS6DSy9EUc3acfHl7msZEJWxyPYCjJeq', 'Poizat', 'Maxence', 10),
(10, 'quentin.detre@etu.uca.fr', '[]', '$2y$13$OMJIH2IC/BLKVbTzN5guuOcS0DqjLk6I.oBPUfFIUZTFtm9SkwvvK', 'Detre', 'Quentin', 10),
(11, 'elonmusk@gmail.com', '[]', '$2y$13$Toc9YdWNr4HTvrGKCs5u.uw0laRaBeUXKWLsbeKA24rMUKgNDLNhS', 'Musk', 'Elon', 9),
(27, 'alexigallonet@gmail.com', '[]', '$2y$13$WvpfC1pIUEHCnJNBDmmvN.0TUQmaHQ3RGW9h8F/oVJ3mio7zGmHf6', 'Gallonet', 'Alexi', 15),
(28, 'lucas.charbonnier43@gmail.com', '[]', '$2y$13$mOHJsRPwXssEs42g4364euKwIwA36tIUw0CDkcynVUKObjxJktlY2', 'charbonnier', 'lucas', 8);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `bookmark`
--
ALTER TABLE `bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `comic`
--
ALTER TABLE `comic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5B7EA5AA89521874` (`comics_collection_id`);

--
-- Index pour la table `comics_collection`
--
ALTER TABLE `comics_collection`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D6EC913E6BB74515` (`house_id`);

--
-- Index pour la table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `credit`
--
ALTER TABLE `credit`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `library`
--
ALTER TABLE `library`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `bookmark`
--
ALTER TABLE `bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1402;

--
-- AUTO_INCREMENT pour la table `comic`
--
ALTER TABLE `comic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `comics_collection`
--
ALTER TABLE `comics_collection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `credit`
--
ALTER TABLE `credit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `house`
--
ALTER TABLE `house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `library`
--
ALTER TABLE `library`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comic`
--
ALTER TABLE `comic`
  ADD CONSTRAINT `FK_5B7EA5AA89521874` FOREIGN KEY (`comics_collection_id`) REFERENCES `comics_collection` (`id`);

--
-- Contraintes pour la table `comics_collection`
--
ALTER TABLE `comics_collection`
  ADD CONSTRAINT `FK_D6EC913E6BB74515` FOREIGN KEY (`house_id`) REFERENCES `house` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
