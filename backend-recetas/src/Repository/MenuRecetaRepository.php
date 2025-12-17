<?php

namespace App\Repository;

use App\Entity\MenuReceta;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<MenuReceta>
 */
class MenuRecetaRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, MenuReceta::class);
    }

    public function save(MenuReceta $menuReceta, bool $flush = false): void
    {
        $this->_em->persist($menuReceta);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function remove(MenuReceta $menuReceta, bool $flush = false): void
    {
        $this->_em->remove($menuReceta);
        if ($flush) {
            $this->_em->flush();
        }
    }
}
