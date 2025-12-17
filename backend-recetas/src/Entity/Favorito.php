<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Favorito
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'favoritos')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $usuario = null;

    #[ORM\ManyToOne(targetEntity: Receta::class, inversedBy: 'favoritos')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Receta $receta = null;

    public function getId(): ?int { return $this->id; }

    public function getUsuario(): ?User { return $this->usuario; }
    public function setUsuario(?User $usuario): self { $this->usuario = $usuario; return $this; }

    public function getReceta(): ?Receta { return $this->receta; }
    public function setReceta(?Receta $receta): self { $this->receta = $receta; return $this; }
}
