<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TagSaludable
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 100)]
    private string $nombre;

    #[ORM\OneToMany(mappedBy: 'tag', targetEntity: RecetaTag::class)]
    private Collection $recetasTag;

    public function __construct()
    {
        $this->recetasTag = new ArrayCollection();
    }

    public function getId(): ?int { return $this->id; }

    public function getNombre(): string { return $this->nombre; }

    public function setNombre(string $nombre): self
    {
        $this->nombre = $nombre;
        return $this;
    }

    /** @return Collection<int, RecetaTag> */
    public function getRecetasTag(): Collection { return $this->recetasTag; }

    public function addRecetaTag(RecetaTag $rt): self
    {
        if (!$this->recetasTag->contains($rt)) {
            $this->recetasTag->add($rt);
            $rt->setTag($this);
        }
        return $this;
    }

    public function removeRecetaTag(RecetaTag $rt): self
    {
        if ($this->recetasTag->removeElement($rt)) {
            $rt->setTag(null);
        }
        return $this;
    }
}
