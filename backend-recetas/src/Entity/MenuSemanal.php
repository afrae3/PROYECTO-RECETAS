<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class MenuSemanal
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(type: 'datetime')]
    private \DateTimeInterface $fechaCreacion;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'menusSemanales')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $usuario = null;

    #[ORM\OneToMany(mappedBy: 'menuSemanal', targetEntity: MenuReceta::class, cascade: ['persist', 'remove'])]
    private Collection $menuRecetas;

    public function __construct()
    {
        $this->menuRecetas = new ArrayCollection();
        $this->fechaCreacion = new \DateTime();
    }

    public function getId(): ?int { return $this->id; }

    public function getFechaCreacion(): \DateTimeInterface { return $this->fechaCreacion; }

    public function setFechaCreacion(\DateTimeInterface $fechaCreacion): self
    {
        $this->fechaCreacion = $fechaCreacion;
        return $this;
    }

    public function getUsuario(): ?User { return $this->usuario; }

    public function setUsuario(?User $usuario): self
    {
        $this->usuario = $usuario;
        return $this;
    }

    /** @return Collection<int, MenuReceta> */
    public function getMenuRecetas(): Collection { return $this->menuRecetas; }

    public function addMenuReceta(MenuReceta $menuReceta): self
    {
        if (!$this->menuRecetas->contains($menuReceta)) {
            $this->menuRecetas->add($menuReceta);
            $menuReceta->setMenuSemanal($this);
        }
        return $this;
    }

    public function removeMenuReceta(MenuReceta $menuReceta): self
    {
        if ($this->menuRecetas->removeElement($menuReceta)) {
            $menuReceta->setMenuSemanal(null);
        }
        return $this;
    }
}
