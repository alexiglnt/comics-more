<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20221212105428 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE comic (id INT AUTO_INCREMENT NOT NULL, comics_collection_id INT NOT NULL, name VARCHAR(255) NOT NULL, nb_page INT NOT NULL, INDEX IDX_5B7EA5AA89521874 (comics_collection_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE comics_collection (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, link VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE comic ADD CONSTRAINT FK_5B7EA5AA89521874 FOREIGN KEY (comics_collection_id) REFERENCES comics_collection (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE comic DROP FOREIGN KEY FK_5B7EA5AA89521874');
        $this->addSql('DROP TABLE comic');
        $this->addSql('DROP TABLE comics_collection');
    }
}
