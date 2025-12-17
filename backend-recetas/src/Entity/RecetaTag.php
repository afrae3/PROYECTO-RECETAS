<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class RecetaTag
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Receta::class, inversedBy: 'tagsRel')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Receta $receta = null;

    #[ORM\ManyToOne(targetEntity: TagSaludable::class, inversedBy: 'recetasTag')]
    #[ORM\JoinColumn(nullable: false)]
    private ?TagSaludable $tag = null;

    public function getId(): ?int { return $this->id; }

    public function getReceta(): ?Receta { return $this->receta; }

    public function setReceta(?Receta $receta): self
    {
        $this->receta = $receta;
        return $this;
    }

    public function getTag(): ?TagSaludable { return $this->tag; }

    public function setTag(?TagSaludable $tag): self
    {
        $this->tag = $tag;
        return $this;
    }
}
