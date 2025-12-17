<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\UniqueConstraint(columns: ['menu_semanal_id', 'dia', 'tipo_comida'])]
class MenuReceta
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 50)]
    private string $dia;

    #[ORM\Column(length: 50)]
    private string $tipoComida;

    #[ORM\ManyToOne(targetEntity: MenuSemanal::class, inversedBy: 'menuRecetas')]
    #[ORM\JoinColumn(nullable: false)]
    private ?MenuSemanal $menuSemanal = null;

    #[ORM\ManyToOne(targetEntity: Receta::class)]
    #[ORM\JoinColumn(nullable: false)]
    private ?Receta $receta = null;

    public function getId(): ?int { return $this->id; }

    public function getDia(): string { return $this->dia; }

    public function setDia(string $dia): self
    {
        $this->dia = $dia;
        return $this;
    }

    public function getTipoComida(): string { return $this->tipoComida; }

    public function setTipoComida(string $tipoComida): self
    {
        $this->tipoComida = $tipoComida;
        return $this;
    }

    public function getMenuSemanal(): ?MenuSemanal { return $this->menuSemanal; }

    public function setMenuSemanal(?MenuSemanal $menuSemanal): self
    {
        $this->menuSemanal = $menuSemanal;
        return $this;
    }

    public function getReceta(): ?Receta { return $this->receta; }

    public function setReceta(?Receta $receta): self
    {
        $this->receta = $receta;
        return $this;
    }
}
