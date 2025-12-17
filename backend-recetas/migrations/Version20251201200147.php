<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251201200147 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE alergeno (id INT AUTO_INCREMENT NOT NULL, nombre VARCHAR(100) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE categoria (id INT AUTO_INCREMENT NOT NULL, nombre VARCHAR(100) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE favorito (id INT AUTO_INCREMENT NOT NULL, usuario_id INT NOT NULL, receta_id INT NOT NULL, INDEX IDX_881067C7DB38439E (usuario_id), INDEX IDX_881067C754F853F8 (receta_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE ingrediente (id INT AUTO_INCREMENT NOT NULL, nombre VARCHAR(150) NOT NULL, calorias DOUBLE PRECISION NOT NULL, proteinas DOUBLE PRECISION NOT NULL, grasas DOUBLE PRECISION NOT NULL, carbohidratos DOUBLE PRECISION NOT NULL, fibra DOUBLE PRECISION NOT NULL, azucares DOUBLE PRECISION NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE instruccion (id INT AUTO_INCREMENT NOT NULL, receta_id INT NOT NULL, paso LONGTEXT NOT NULL, orden INT NOT NULL, INDEX IDX_B6748E7054F853F8 (receta_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE menu_receta (id INT AUTO_INCREMENT NOT NULL, menu_semanal_id INT NOT NULL, receta_id INT NOT NULL, dia VARCHAR(50) NOT NULL, tipo_comida VARCHAR(50) NOT NULL, INDEX IDX_63D41196D1DEB0A1 (menu_semanal_id), INDEX IDX_63D4119654F853F8 (receta_id), UNIQUE INDEX UNIQ_63D41196D1DEB0A13E153BCE417EACF (menu_semanal_id, dia, tipo_comida), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE menu_semanal (id INT AUTO_INCREMENT NOT NULL, usuario_id INT NOT NULL, fecha_creacion DATETIME NOT NULL, INDEX IDX_89D24BADB38439E (usuario_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE receta (id INT AUTO_INCREMENT NOT NULL, categoria_id INT NOT NULL, nombre VARCHAR(150) NOT NULL, descripcion LONGTEXT DEFAULT NULL, imagen VARCHAR(255) DEFAULT NULL, tiempo_preparacion INT DEFAULT NULL, porciones INT DEFAULT NULL, dificultad VARCHAR(50) DEFAULT NULL, popularidad INT DEFAULT NULL, fecha_creacion DATETIME NOT NULL, INDEX IDX_B093494E3397707A (categoria_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE receta_alergeno (id INT AUTO_INCREMENT NOT NULL, receta_id INT NOT NULL, alergeno_id INT NOT NULL, INDEX IDX_EA68B3ED54F853F8 (receta_id), INDEX IDX_EA68B3ED3E89035 (alergeno_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE receta_ingrediente (id INT AUTO_INCREMENT NOT NULL, receta_id INT NOT NULL, ingrediente_id INT NOT NULL, cantidad DOUBLE PRECISION NOT NULL, medida VARCHAR(50) NOT NULL, INDEX IDX_F7A6A61354F853F8 (receta_id), INDEX IDX_F7A6A613769E458D (ingrediente_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE receta_tag (id INT AUTO_INCREMENT NOT NULL, receta_id INT NOT NULL, tag_id INT NOT NULL, INDEX IDX_DB6F5D6D54F853F8 (receta_id), INDEX IDX_DB6F5D6DBAD26311 (tag_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE role (id INT AUTO_INCREMENT NOT NULL, nombre VARCHAR(100) NOT NULL, UNIQUE INDEX UNIQ_57698A6A3A909126 (nombre), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE tag_saludable (id INT AUTO_INCREMENT NOT NULL, nombre VARCHAR(100) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user (id INT AUTO_INCREMENT NOT NULL, email VARCHAR(180) NOT NULL, password VARCHAR(255) NOT NULL, UNIQUE INDEX UNIQ_8D93D649E7927C74 (email), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_role (id INT AUTO_INCREMENT NOT NULL, usuario_id INT NOT NULL, role_id INT NOT NULL, INDEX IDX_2DE8C6A3DB38439E (usuario_id), INDEX IDX_2DE8C6A3D60322AC (role_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE messenger_messages (id BIGINT AUTO_INCREMENT NOT NULL, body LONGTEXT NOT NULL, headers LONGTEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at DATETIME NOT NULL COMMENT \'(DC2Type:datetime_immutable)\', available_at DATETIME NOT NULL COMMENT \'(DC2Type:datetime_immutable)\', delivered_at DATETIME DEFAULT NULL COMMENT \'(DC2Type:datetime_immutable)\', INDEX IDX_75EA56E0FB7336F0 (queue_name), INDEX IDX_75EA56E0E3BD61CE (available_at), INDEX IDX_75EA56E016BA31DB (delivered_at), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE favorito ADD CONSTRAINT FK_881067C7DB38439E FOREIGN KEY (usuario_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE favorito ADD CONSTRAINT FK_881067C754F853F8 FOREIGN KEY (receta_id) REFERENCES receta (id)');
        $this->addSql('ALTER TABLE instruccion ADD CONSTRAINT FK_B6748E7054F853F8 FOREIGN KEY (receta_id) REFERENCES receta (id)');
        $this->addSql('ALTER TABLE menu_receta ADD CONSTRAINT FK_63D41196D1DEB0A1 FOREIGN KEY (menu_semanal_id) REFERENCES menu_semanal (id)');
        $this->addSql('ALTER TABLE menu_receta ADD CONSTRAINT FK_63D4119654F853F8 FOREIGN KEY (receta_id) REFERENCES receta (id)');
        $this->addSql('ALTER TABLE menu_semanal ADD CONSTRAINT FK_89D24BADB38439E FOREIGN KEY (usuario_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE receta ADD CONSTRAINT FK_B093494E3397707A FOREIGN KEY (categoria_id) REFERENCES categoria (id)');
        $this->addSql('ALTER TABLE receta_alergeno ADD CONSTRAINT FK_EA68B3ED54F853F8 FOREIGN KEY (receta_id) REFERENCES receta (id)');
        $this->addSql('ALTER TABLE receta_alergeno ADD CONSTRAINT FK_EA68B3ED3E89035 FOREIGN KEY (alergeno_id) REFERENCES alergeno (id)');
        $this->addSql('ALTER TABLE receta_ingrediente ADD CONSTRAINT FK_F7A6A61354F853F8 FOREIGN KEY (receta_id) REFERENCES receta (id)');
        $this->addSql('ALTER TABLE receta_ingrediente ADD CONSTRAINT FK_F7A6A613769E458D FOREIGN KEY (ingrediente_id) REFERENCES ingrediente (id)');
        $this->addSql('ALTER TABLE receta_tag ADD CONSTRAINT FK_DB6F5D6D54F853F8 FOREIGN KEY (receta_id) REFERENCES receta (id)');
        $this->addSql('ALTER TABLE receta_tag ADD CONSTRAINT FK_DB6F5D6DBAD26311 FOREIGN KEY (tag_id) REFERENCES tag_saludable (id)');
        $this->addSql('ALTER TABLE user_role ADD CONSTRAINT FK_2DE8C6A3DB38439E FOREIGN KEY (usuario_id) REFERENCES user (id)');
        $this->addSql('ALTER TABLE user_role ADD CONSTRAINT FK_2DE8C6A3D60322AC FOREIGN KEY (role_id) REFERENCES role (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE favorito DROP FOREIGN KEY FK_881067C7DB38439E');
        $this->addSql('ALTER TABLE favorito DROP FOREIGN KEY FK_881067C754F853F8');
        $this->addSql('ALTER TABLE instruccion DROP FOREIGN KEY FK_B6748E7054F853F8');
        $this->addSql('ALTER TABLE menu_receta DROP FOREIGN KEY FK_63D41196D1DEB0A1');
        $this->addSql('ALTER TABLE menu_receta DROP FOREIGN KEY FK_63D4119654F853F8');
        $this->addSql('ALTER TABLE menu_semanal DROP FOREIGN KEY FK_89D24BADB38439E');
        $this->addSql('ALTER TABLE receta DROP FOREIGN KEY FK_B093494E3397707A');
        $this->addSql('ALTER TABLE receta_alergeno DROP FOREIGN KEY FK_EA68B3ED54F853F8');
        $this->addSql('ALTER TABLE receta_alergeno DROP FOREIGN KEY FK_EA68B3ED3E89035');
        $this->addSql('ALTER TABLE receta_ingrediente DROP FOREIGN KEY FK_F7A6A61354F853F8');
        $this->addSql('ALTER TABLE receta_ingrediente DROP FOREIGN KEY FK_F7A6A613769E458D');
        $this->addSql('ALTER TABLE receta_tag DROP FOREIGN KEY FK_DB6F5D6D54F853F8');
        $this->addSql('ALTER TABLE receta_tag DROP FOREIGN KEY FK_DB6F5D6DBAD26311');
        $this->addSql('ALTER TABLE user_role DROP FOREIGN KEY FK_2DE8C6A3DB38439E');
        $this->addSql('ALTER TABLE user_role DROP FOREIGN KEY FK_2DE8C6A3D60322AC');
        $this->addSql('DROP TABLE alergeno');
        $this->addSql('DROP TABLE categoria');
        $this->addSql('DROP TABLE favorito');
        $this->addSql('DROP TABLE ingrediente');
        $this->addSql('DROP TABLE instruccion');
        $this->addSql('DROP TABLE menu_receta');
        $this->addSql('DROP TABLE menu_semanal');
        $this->addSql('DROP TABLE receta');
        $this->addSql('DROP TABLE receta_alergeno');
        $this->addSql('DROP TABLE receta_ingrediente');
        $this->addSql('DROP TABLE receta_tag');
        $this->addSql('DROP TABLE role');
        $this->addSql('DROP TABLE tag_saludable');
        $this->addSql('DROP TABLE user');
        $this->addSql('DROP TABLE user_role');
        $this->addSql('DROP TABLE messenger_messages');
    }
}
