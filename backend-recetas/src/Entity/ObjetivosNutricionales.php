<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
#[ORM\Table(name: 'objetivos_nutricionales')]
class ObjetivosNutricionales
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(name: 'usuario_id', referencedColumnName: 'id', nullable: false, onDelete: 'CASCADE')]
    private ?User $usuario = null;

    // Datos personales
    #[ORM\Column(type: 'string', length: 10, nullable: true)]
    private ?string $sexo = null; // 'masculino' o 'femenino'

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $edad = null;

    #[ORM\Column(type: 'decimal', precision: 5, scale: 2, nullable: true)]
    private ?float $peso = null; // en kg

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $altura = null; // en cm

    #[ORM\Column(type: 'string', length: 20, nullable: true)]
    private ?string $nivelActividad = null; // sedentario, ligero, moderado, activo, muy_activo

    #[ORM\Column(type: 'string', length: 20, nullable: true)]
    private ?string $objetivo = null; // perder_peso, mantener, ganar_musculo

    // Objetivos nutricionales calculados
    #[ORM\Column(type: 'integer')]
    private int $calorias = 2000;

    #[ORM\Column(type: 'decimal', precision: 6, scale: 1)]
    private float $proteinas = 150.0;

    #[ORM\Column(type: 'decimal', precision: 6, scale: 1)]
    private float $grasas = 65.0;

    #[ORM\Column(type: 'decimal', precision: 6, scale: 1)]
    private float $carbohidratos = 250.0;

    #[ORM\Column(type: 'decimal', precision: 5, scale: 1, nullable: true)]
    private ?float $fibra = 25.0;

    #[ORM\Column(type: 'datetime')]
    private \DateTime $fechaCreacion;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private ?\DateTime $fechaActualizacion = null;

    public function __construct()
    {
        $this->fechaCreacion = new \DateTime();
    }

    // Getters y Setters existentes...
    public function getId(): ?int { return $this->id; }
    public function getUsuario(): ?User { return $this->usuario; }
    public function setUsuario(?User $usuario): self { $this->usuario = $usuario; return $this; }

    // Nuevos Getters y Setters
    public function getSexo(): ?string { return $this->sexo; }
    public function setSexo(?string $sexo): self { $this->sexo = $sexo; return $this; }

    public function getEdad(): ?int { return $this->edad; }
    public function setEdad(?int $edad): self { $this->edad = $edad; return $this; }

    public function getPeso(): ?float { return $this->peso; }
    public function setPeso(?float $peso): self { $this->peso = $peso; return $this; }

    public function getAltura(): ?int { return $this->altura; }
    public function setAltura(?int $altura): self { $this->altura = $altura; return $this; }

    public function getNivelActividad(): ?string { return $this->nivelActividad; }
    public function setNivelActividad(?string $nivelActividad): self { $this->nivelActividad = $nivelActividad; return $this; }

    public function getObjetivo(): ?string { return $this->objetivo; }
    public function setObjetivo(?string $objetivo): self { $this->objetivo = $objetivo; return $this; }

    // Getters y Setters de nutrientes
    public function getCalorias(): int { return $this->calorias; }
    public function setCalorias(int $calorias): self { $this->calorias = $calorias; return $this; }

    public function getProteinas(): float { return $this->proteinas; }
    public function setProteinas(float $proteinas): self { $this->proteinas = $proteinas; return $this; }

    public function getGrasas(): float { return $this->grasas; }
    public function setGrasas(float $grasas): self { $this->grasas = $grasas; return $this; }

    public function getCarbohidratos(): float { return $this->carbohidratos; }
    public function setCarbohidratos(float $carbohidratos): self { $this->carbohidratos = $carbohidratos; return $this; }

    public function getFibra(): ?float { return $this->fibra; }
    public function setFibra(?float $fibra): self { $this->fibra = $fibra; return $this; }

    public function getFechaCreacion(): \DateTime { return $this->fechaCreacion; }
    public function getFechaActualizacion(): ?\DateTime { return $this->fechaActualizacion; }
    public function setFechaActualizacion(?\DateTime $fecha): self { $this->fechaActualizacion = $fecha; return $this; }
}