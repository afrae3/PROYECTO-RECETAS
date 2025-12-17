<?php

namespace App\Repository;

use App\Entity\Role;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Role>
 */
class RoleRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Role::class);
    }

    /**
     * Guarda un rol en la base de datos.
     */
    public function save(Role $role, bool $flush = false): void
    {
        $this->_em->persist($role);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * Elimina un rol de la base de datos.
     */
    public function remove(Role $role, bool $flush = false): void
    {
        $this->_em->remove($role);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * Encuentra un rol por su nombre.
     */
    public function findByNombre(string $nombre): ?Role
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.nombre = :nombre')
            ->setParameter('nombre', $nombre)
            ->getQuery()
            ->getOneOrNullResult();
    }

    /**
     * Devuelve todos los roles ordenados alfabéticamente.
     */
    public function findAllOrdered(): array
    {
        return $this->createQueryBuilder('r')
            ->orderBy('r.nombre', 'ASC')
            ->getQuery()
            ->getResult();
    }
}
