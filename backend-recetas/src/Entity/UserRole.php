<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class UserRole
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(inversedBy: 'userRoles')]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $usuario = null;

    #[ORM\ManyToOne(inversedBy: 'userRoles')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Role $role = null;

    public function getId(): ?int { return $this->id; }

    public function getUsuario(): ?User { return $this->usuario; }

    public function setUsuario(?User $usuario): self { $this->usuario = $usuario; return $this; }

    public function getRole(): ?Role { return $this->role; }

    public function setRole(?Role $role): self { $this->role = $role; return $this; }
}
