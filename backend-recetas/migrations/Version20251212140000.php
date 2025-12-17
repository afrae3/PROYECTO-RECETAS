<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20251212140000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Añadir campos personales a objetivos_nutricionales';
    }

    public function up(Schema $schema): void
    {
        $this->addSql('ALTER TABLE objetivos_nutricionales 
            ADD sexo VARCHAR(10) DEFAULT NULL,
            ADD edad INT DEFAULT NULL,
            ADD peso DECIMAL(5,2) DEFAULT NULL,
            ADD altura INT DEFAULT NULL,
            ADD nivel_actividad VARCHAR(20) DEFAULT NULL,
            ADD objetivo VARCHAR(20) DEFAULT NULL'
        );
    }

    public function down(Schema $schema): void
    {
        $this->addSql('ALTER TABLE objetivos_nutricionales 
            DROP sexo,
            DROP edad,
            DROP peso,
            DROP altura,
            DROP nivel_actividad,
            DROP objetivo'
        );
    }
}