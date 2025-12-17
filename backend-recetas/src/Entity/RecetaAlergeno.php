<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class RecetaAlergeno
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Receta::class, inversedBy: 'alergenosRel')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Receta $receta = null;

    #[ORM\ManyToOne(targetEntity: Alergeno::class, inversedBy: 'recetasAlergeno')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Alergeno $alergeno = null;

    public function getId(): ?int { return $this->id; }

    public function getReceta(): ?Receta { return $this->receta; }

    public function setReceta(?Receta $receta): self
    {
        $this->receta = $receta;
        return $this;
    }

    public function getAlergeno(): ?Alergeno { return $this->alergeno; }

    public function setAlergeno(?Alergeno $alergeno): self
    {
        $this->alergeno = $alergeno;
        return $this;
    }
}
