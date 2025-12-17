<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Receta
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 150)]
    private string $nombre;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $descripcion = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $imagen = null;

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $tiempoPreparacion = null;

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $porciones = null;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private ?string $dificultad = null;

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $popularidad = null;

    #[ORM\Column(type: 'datetime')]
    private \DateTime $fechaCreacion;

    #[ORM\ManyToOne(targetEntity: Categoria::class, inversedBy: 'recetas')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Categoria $categoria = null;

    #[ORM\OneToMany(mappedBy: 'receta', targetEntity: Instruccion::class)]
    private Collection $instrucciones;

    #[ORM\OneToMany(mappedBy: 'receta', targetEntity: RecetaIngrediente::class)]
    private Collection $ingredientesRel;

    #[ORM\OneToMany(mappedBy: 'receta', targetEntity: RecetaAlergeno::class)]
    private Collection $alergenosRel;

    #[ORM\OneToMany(mappedBy: 'receta', targetEntity: RecetaTag::class)]
    private Collection $tagsRel;

    #[ORM\OneToMany(mappedBy: 'receta', targetEntity: MenuReceta::class)]
    private Collection $menusReceta;

    #[ORM\OneToMany(mappedBy: 'receta', targetEntity: Favorito::class)]
    private Collection $favoritos;

    public function __construct()
    {
        $this->instrucciones = new ArrayCollection();
        $this->ingredientesRel = new ArrayCollection();
        $this->alergenosRel = new ArrayCollection();
        $this->tagsRel = new ArrayCollection();
        $this->menusReceta = new ArrayCollection();
        $this->favoritos = new ArrayCollection();
        $this->fechaCreacion = new \DateTime();
    }

    public function getId(): ?int { return $this->id; }

    public function getNombre(): string { return $this->nombre; }
    public function setNombre(string $nombre): self { $this->nombre = $nombre; return $this; }

    public function getDescripcion(): ?string { return $this->descripcion; }
    public function setDescripcion(?string $descripcion): self { $this->descripcion = $descripcion; return $this; }

    public function getImagen(): ?string { return $this->imagen; }
    public function setImagen(?string $imagen): self { $this->imagen = $imagen; return $this; }

    public function getTiempoPreparacion(): ?int { return $this->tiempoPreparacion; }
    public function setTiempoPreparacion(?int $tiempoPreparacion): self { $this->tiempoPreparacion = $tiempoPreparacion; return $this; }

    public function getPorciones(): ?int { return $this->porciones; }
    public function setPorciones(?int $porciones): self { $this->porciones = $porciones; return $this; }

    public function getDificultad(): ?string { return $this->dificultad; }
    public function setDificultad(?string $dificultad): self { $this->dificultad = $dificultad; return $this; }

    public function getPopularidad(): ?int { return $this->popularidad; }
    public function setPopularidad(?int $popularidad): self { $this->popularidad = $popularidad; return $this; }

    public function getFechaCreacion(): \DateTime { return $this->fechaCreacion; }
    public function setFechaCreacion(\DateTime $fechaCreacion): self { $this->fechaCreacion = $fechaCreacion; return $this; }

    public function getCategoria(): ?Categoria { return $this->categoria; }
    public function setCategoria(?Categoria $categoria): self { $this->categoria = $categoria; return $this; }

    /** @return Collection<int, Instruccion> */
    public function getInstrucciones(): Collection { return $this->instrucciones; }

    /** @return Collection<int, RecetaIngrediente> */
    public function getIngredientesRel(): Collection { return $this->ingredientesRel; }

    /** @return Collection<int, RecetaAlergeno> */
    public function getAlergenosRel(): Collection { return $this->alergenosRel; }

    /** @return Collection<int, RecetaTag> */
    public function getTagsRel(): Collection { return $this->tagsRel; }

    /** @return Collection<int, MenuReceta> */
    public function getMenusReceta(): Collection { return $this->menusReceta; }

    /** @return Collection<int, Favorito> */
    public function getFavoritos(): Collection { return $this->favoritos; }
}
