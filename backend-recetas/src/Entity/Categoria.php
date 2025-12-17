<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Categoria
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 100)]
    private string $nombre;

    #[ORM\OneToMany(mappedBy: 'categoria', targetEntity: Receta::class)]
    private Collection $recetas;

    public function __construct()
    {
        $this->recetas = new ArrayCollection();
    }

    public function getId(): ?int { return $this->id; }

    public function getNombre(): ?string { return $this->nombre; }

    public function setNombre(string $nombre): self
    {
        $this->nombre = $nombre;
        return $this;
    }

    /** @return Collection<int, Receta> */
    public function getRecetas(): Collection { return $this->recetas; }

    public function addReceta(Receta $receta): self
    {
        if (!$this->recetas->contains($receta)) {
            $this->recetas->add($receta);
            $receta->setCategoria($this);
        }
        return $this;
    }

    public function removeReceta(Receta $receta): self
    {
        if ($this->recetas->removeElement($receta)) {
            $receta->setCategoria(null);
        }
        return $this;
    }
}
