<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230115091916 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE house (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE comics_collection ADD house_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE comics_collection ADD CONSTRAINT FK_D6EC913E6BB74515 FOREIGN KEY (house_id) REFERENCES house (id)');
        $this->addSql('CREATE INDEX IDX_D6EC913E6BB74515 ON comics_collection (house_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE comics_collection DROP FOREIGN KEY FK_D6EC913E6BB74515');
        $this->addSql('DROP TABLE house');
        $this->addSql('DROP INDEX IDX_D6EC913E6BB74515 ON comics_collection');
        $this->addSql('ALTER TABLE comics_collection DROP house_id');
    }
}
