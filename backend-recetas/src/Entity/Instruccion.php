<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Instruccion
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(type: 'text')]
    private string $paso;

    #[ORM\Column(type: 'integer')]
    private int $orden;

    #[ORM\ManyToOne(targetEntity: Receta::class, inversedBy: 'instrucciones')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Receta $receta = null;

    public function getId(): ?int { return $this->id; }

    public function getPaso(): string { return $this->paso; }

    public function setPaso(string $paso): self
    {
        $this->paso = $paso;
        return $this;
    }

    public function getOrden(): int { return $this->orden; }

    public function setOrden(int $orden): self
    {
        $this->orden = $orden;
        return $this;
    }

    public function getReceta(): ?Receta { return $this->receta; }

    public function setReceta(?Receta $receta): self
    {
        $this->receta = $receta;
        return $this;
    }
}
