<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UserRepository::class)]
class User implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 180, unique: true)]
    private ?string $email = null;

    #[ORM\Column]
    private ?string $password = null;

    #[ORM\OneToMany(mappedBy: 'usuario', targetEntity: UserRole::class, cascade: ['persist', 'remove'])]
    private Collection $userRoles;

    #[ORM\OneToMany(mappedBy: 'usuario', targetEntity: MenuSemanal::class, cascade: ['persist', 'remove'])]
    private Collection $menusSemanales;

    #[ORM\OneToMany(mappedBy: 'usuario', targetEntity: Favorito::class, cascade: ['persist', 'remove'])]
    private Collection $favoritos;

    public function __construct()
    {
        $this->userRoles = new ArrayCollection();
        $this->menusSemanales = new ArrayCollection();
        $this->favoritos = new ArrayCollection();
    }

    public function getId(): ?int { return $this->id; }

    public function getEmail(): ?string { return $this->email; }

    public function setEmail(string $email): self { $this->email = $email; return $this; }

    public function getPassword(): string { return $this->password; }

    public function setPassword(string $password): self { $this->password = $password; return $this; }

    /** Métodos requeridos por UserInterface */
    public function getUserIdentifier(): string { return (string) $this->email; }

    public function eraseCredentials(): void {}

    /** Devuelve los roles como array de strings */
    public function getRoles(): array
    {
        $roleNames = [];
        foreach ($this->userRoles as $userRole) {
            $roleNames[] = $userRole->getRole()->getNombre();
        }
        $roleNames[] = 'ROLE_USER';
        return array_unique($roleNames);
    }

    /** @return Collection<int, UserRole> */
    public function getUserRoles(): Collection { return $this->userRoles; }

    public function addUserRole(UserRole $userRole): self
    {
        if (!$this->userRoles->contains($userRole)) {
            $this->userRoles->add($userRole);
            $userRole->setUsuario($this);
        }
        return $this;
    }

    public function removeUserRole(UserRole $userRole): self
    {
        if ($this->userRoles->removeElement($userRole)) {
            if ($userRole->getUsuario() === $this) {
                $userRole->setUsuario(null);
            }
        }
        return $this;
    }

    /** @return Collection<int, MenuSemanal> */
    public function getMenusSemanales(): Collection { return $this->menusSemanales; }

    public function addMenuSemanal(MenuSemanal $menu): self
    {
        if (!$this->menusSemanales->contains($menu)) {
            $this->menusSemanales->add($menu);
            $menu->setUsuario($this);
        }
        return $this;
    }

    public function removeMenuSemanal(MenuSemanal $menu): self
    {
        if ($this->menusSemanales->removeElement($menu)) {
            if ($menu->getUsuario() === $this) {
                $menu->setUsuario(null);
            }
        }
        return $this;
    }

    /** @return Collection<int, Favorito> */
    public function getFavoritos(): Collection { return $this->favoritos; }

    public function addFavorito(Favorito $favorito): self
    {
        if (!$this->favoritos->contains($favorito)) {
            $this->favoritos->add($favorito);
            $favorito->setUsuario($this);
        }
        return $this;
    }

    public function removeFavorito(Favorito $favorito): self
    {
        if ($this->favoritos->removeElement($favorito)) {
            if ($favorito->getUsuario() === $this) {
                $favorito->setUsuario(null);
            }
        }
        return $this;
    }
}
