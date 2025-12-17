<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Ingrediente
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 150)]
    private string $nombre;

    #[ORM\Column(type: 'float')]
    private float $calorias;

    #[ORM\Column(type: 'float')]
    private float $proteinas;

    #[ORM\Column(type: 'float')]
    private float $grasas;

    #[ORM\Column(type: 'float')]
    private float $carbohidratos;

    #[ORM\Column(type: 'float')]
    private float $fibra;

    #[ORM\Column(type: 'float')]
    private float $azucares;

    #[ORM\OneToMany(mappedBy: 'ingrediente', targetEntity: RecetaIngrediente::class)]
    private Collection $recetasIngrediente;

    public function __construct()
    {
        $this->recetasIngrediente = new ArrayCollection();
    }

    public function getId(): ?int { return $this->id; }

    public function getNombre(): string { return $this->nombre; }

    public function setNombre(string $nombre): self
    {
        $this->nombre = $nombre;
        return $this;
    }

    public function getCalorias(): float { return $this->calorias; }
    public function setCalorias(float $calorias): self { $this->calorias = $calorias; return $this; }

    public function getProteinas(): float { return $this->proteinas; }
    public function setProteinas(float $proteinas): self { $this->proteinas = $proteinas; return $this; }

    public function getGrasas(): float { return $this->grasas; }
    public function setGrasas(float $grasas): self { $this->grasas = $grasas; return $this; }

    public function getCarbohidratos(): float { return $this->carbohidratos; }
    public function setCarbohidratos(float $carbohidratos): self { $this->carbohidratos = $carbohidratos; return $this; }

    public function getFibra(): float { return $this->fibra; }
    public function setFibra(float $fibra): self { $this->fibra = $fibra; return $this; }

    public function getAzucares(): float { return $this->azucares; }
    public function setAzucares(float $azucares): self { $this->azucares = $azucares; return $this; }

    /** @return Collection<int, RecetaIngrediente> */
    public function getRecetasIngrediente(): Collection { return $this->recetasIngrediente; }

    public function addRecetaIngrediente(RecetaIngrediente $ri): self
    {
        if (!$this->recetasIngrediente->contains($ri)) {
            $this->recetasIngrediente->add($ri);
            $ri->setIngrediente($this);
        }
        return $this;
    }

    public function removeRecetaIngrediente(RecetaIngrediente $ri): self
    {
        if ($this->recetasIngrediente->removeElement($ri)) {
            $ri->setIngrediente(null);
        }
        return $this;
    }
}
