<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230316091238 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE comment DROP FOREIGN KEY FK_9474526C9D86650F');
        $this->addSql('ALTER TABLE comment DROP FOREIGN KEY FK_9474526CF4B61CD0');
        $this->addSql('DROP INDEX IDX_9474526CF4B61CD0 ON comment');
        $this->addSql('DROP INDEX IDX_9474526C9D86650F ON comment');
        $this->addSql('ALTER TABLE comment DROP comics_id_id, DROP user_id_id');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE comment ADD comics_id_id INT DEFAULT NULL, ADD user_id_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE comment ADD CONSTRAINT FK_9474526C9D86650F FOREIGN KEY (user_id_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE comment ADD CONSTRAINT FK_9474526CF4B61CD0 FOREIGN KEY (comics_id_id) REFERENCES comic (id)');
        $this->addSql('CREATE INDEX IDX_9474526CF4B61CD0 ON comment (comics_id_id)');
        $this->addSql('CREATE INDEX IDX_9474526C9D86650F ON comment (user_id_id)');
    }
}
