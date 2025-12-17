<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Alergeno
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 100)]
    private string $nombre;

    #[ORM\OneToMany(mappedBy: 'alergeno', targetEntity: RecetaAlergeno::class)]
    private Collection $recetasAlergeno;

    public function __construct()
    {
        $this->recetasAlergeno = new ArrayCollection();
    }

    public function getId(): ?int { return $this->id; }

    public function getNombre(): string { return $this->nombre; }

    public function setNombre(string $nombre): self
    {
        $this->nombre = $nombre;
        return $this;
    }

    /** @return Collection<int, RecetaAlergeno> */
    public function getRecetasAlergeno(): Collection { return $this->recetasAlergeno; }

    public function addRecetaAlergeno(RecetaAlergeno $ra): self
    {
        if (!$this->recetasAlergeno->contains($ra)) {
            $this->recetasAlergeno->add($ra);
            $ra->setAlergeno($this);
        }
        return $this;
    }

    public function removeRecetaAlergeno(RecetaAlergeno $ra): self
    {
        if ($this->recetasAlergeno->removeElement($ra)) {
            $ra->setAlergeno(null);
        }
        return $this;
    }
}
