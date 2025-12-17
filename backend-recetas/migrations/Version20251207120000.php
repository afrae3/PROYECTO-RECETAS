<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20251207120000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Crear tabla objetivos_nutricionales';
    }

    public function up(Schema $schema): void
    {
        $this->addSql('CREATE TABLE objetivos_nutricionales (
            id INT AUTO_INCREMENT NOT NULL, 
            usuario_id INT NOT NULL, 
            calorias INT NOT NULL DEFAULT 2000, 
            proteinas NUMERIC(6, 1) NOT NULL DEFAULT 150.0, 
            grasas NUMERIC(6, 1) NOT NULL DEFAULT 65.0, 
            carbohidratos NUMERIC(6, 1) NOT NULL DEFAULT 250.0, 
            fibra NUMERIC(5, 1) DEFAULT 25.0, 
            fecha_creacion DATETIME NOT NULL, 
            fecha_actualizacion DATETIME DEFAULT NULL, 
            INDEX IDX_OBJETIVOS_USUARIO (usuario_id), 
            UNIQUE KEY unique_usuario (usuario_id),
            PRIMARY KEY(id)
        ) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        
        $this->addSql('ALTER TABLE objetivos_nutricionales 
            ADD CONSTRAINT FK_OBJETIVOS_USUARIO 
            FOREIGN KEY (usuario_id) 
            REFERENCES user (id) 
            ON DELETE CASCADE');
    }

    public function down(Schema $schema): void
    {
        $this->addSql('ALTER TABLE objetivos_nutricionales DROP FOREIGN KEY FK_OBJETIVOS_USUARIO');
        $this->addSql('DROP TABLE objetivos_nutricionales');
    }
}