<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class RecetaIngrediente
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Receta::class, inversedBy: 'ingredientesRel')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Receta $receta = null;

    #[ORM\ManyToOne(targetEntity: Ingrediente::class, inversedBy: 'recetasIngrediente')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Ingrediente $ingrediente = null;

    #[ORM\Column(type: 'float')]
    private float $cantidad;

    #[ORM\Column(length: 50)]
    private string $medida;

    public function getId(): ?int { return $this->id; }

    public function getReceta(): ?Receta { return $this->receta; }

    public function setReceta(?Receta $receta): self
    {
        $this->receta = $receta;
        return $this;
    }

    public function getIngrediente(): ?Ingrediente { return $this->ingrediente; }

    public function setIngrediente(?Ingrediente $ingrediente): self
    {
        $this->ingrediente = $ingrediente;
        return $this;
    }

    public function getCantidad(): float { return $this->cantidad; }

    public function setCantidad(float $cantidad): self
    {
        $this->cantidad = $cantidad;
        return $this;
    }

    public function getMedida(): string { return $this->medida; }

    public function setMedida(string $medida): self
    {
        $this->medida = $medida;
        return $this;
    }
}
