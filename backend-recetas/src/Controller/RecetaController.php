<?php

namespace App\Controller;

use App\Entity\Receta;
use App\Entity\Categoria;
use App\Entity\Ingrediente;
use App\Entity\RecetaIngrediente;
use App\Entity\Instruccion;
use App\Entity\Alergeno;
use App\Entity\RecetaAlergeno;
use App\Entity\TagSaludable;
use App\Entity\RecetaTag;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\String\Slugger\SluggerInterface;

class RecetaController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $em,
        private SluggerInterface $slugger
    ) {}

    #[Route('/api/recetas', name: 'recetas_list', methods: ['GET'])]
    public function listar(): JsonResponse
    {
        $recetas = $this->em->getRepository(Receta::class)->findAll();
        $data = [];

        foreach ($recetas as $receta) {
            $ingredientes = [];
            $calorias = $proteinas = $grasas = $carbohidratos = $fibra = $azucares = 0;

            foreach ($receta->getIngredientesRel() as $ri) {
                $ing = $ri->getIngrediente();
                if ($ing) {
                    $ingredientes[] = [
                        'id' => $ing->getId(),
                        'nombre' => $ing->getNombre(),
                        'cantidad' => $ri->getCantidad() ?? 0,
                        'medida' => $ri->getMedida() ?? 'g',
                        'ingrediente' => [
                            'nombre' => $ing->getNombre(),
                            'calorias' => $ing->getCalorias() ?? 0,
                            'proteinas' => $ing->getProteinas() ?? 0,
                            'grasas' => $ing->getGrasas() ?? 0,
                            'carbohidratos' => $ing->getCarbohidratos() ?? 0,
                            'fibra' => $ing->getFibra() ?? 0,
                            'azucares' => $ing->getAzucares() ?? 0
                        ]
                    ];

                    $cantidad = $ri->getCantidad() ?? 0;
                    $medida = strtolower(trim($ri->getMedida() ?? ''));

                    $factor = match($medida) {
                        'g','ml' => $cantidad / 100,
                        'unidad' => $cantidad,
                        default => 0
                    };

                    $calorias += $factor * ($ing->getCalorias() ?? 0);
                    $proteinas += $factor * ($ing->getProteinas() ?? 0);
                    $grasas += $factor * ($ing->getGrasas() ?? 0);
                    $carbohidratos += $factor * ($ing->getCarbohidratos() ?? 0);
                    $fibra += $factor * ($ing->getFibra() ?? 0);
                    $azucares += $factor * ($ing->getAzucares() ?? 0);
                }
            }

            $instrucciones = [];
            foreach ($receta->getInstrucciones() as $inst) {
                $instrucciones[] = $inst->getPaso();
            }

            $alergenos = [];
            foreach ($receta->getAlergenosRel() as $ra) {
                $nombre = $ra->getAlergeno()?->getNombre();
                if ($nombre) $alergenos[] = $nombre;
            }

            $tags = [];
            foreach ($receta->getTagsRel() as $rt) {
                $nombre = $rt->getTag()?->getNombre();
                if ($nombre) $tags[] = $nombre;
            }

            $data[] = [
                'id' => $receta->getId(),
                'nombre' => $receta->getNombre(),
                'descripcion' => $receta->getDescripcion(),
                'imagen' => $receta->getImagen(),
                'tiempoPreparacion' => $receta->getTiempoPreparacion(),
                'porciones' => $receta->getPorciones(),
                'calorias' => round($calorias, 2),
                'proteinas' => round($proteinas, 2),
                'grasas' => round($grasas, 2),
                'carbohidratos' => round($carbohidratos, 2),
                'fibra' => round($fibra, 2),
                'azucares' => round($azucares, 2),
                'categoria' => $receta->getCategoria()?->getId(), // ✅ CAMBIO: devolver ID en lugar de nombre
                'dificultad' => $receta->getDificultad(),
                'popularidad' => $receta->getPopularidad(),
                'fechaCreacion' => $receta->getFechaCreacion()?->format('Y-m-d H:i:s'),
                'ingredientes' => $ingredientes,
                'instrucciones' => $instrucciones,
                'alergenos' => $alergenos,
                'tagsSaludables' => $tags,
            ];
        }

        return new JsonResponse($data, 200);
    }

  
    #[Route('/api/categorias', name: 'categorias_list', methods: ['GET'])]
    public function listarCategorias(): JsonResponse
    {
        $categorias = $this->em->getRepository(Categoria::class)->findAll();
        $data = array_map(fn($c) => ['id'=>$c->getId(),'nombre'=>$c->getNombre()], $categorias);
        return new JsonResponse($data,200);
    }

    #[Route('/api/ingredientes', name: 'ingredientes_list', methods: ['GET'])]
    public function listarIngredientes(): JsonResponse
    {
        $ingredientes = $this->em->getRepository(Ingrediente::class)->findAll();
        $data = array_map(fn($i) => ['id'=>$i->getId(),'nombre'=>$i->getNombre()], $ingredientes);
        return new JsonResponse($data,200);
    }

    #[Route('/api/alergenos', name: 'alergenos_list', methods: ['GET'])]
    public function listarAlergenos(): JsonResponse
    {
        $alergenos = $this->em->getRepository(Alergeno::class)->findAll();
        $data = array_map(fn($a) => ['id'=>$a->getId(),'nombre'=>$a->getNombre()], $alergenos);
        return new JsonResponse($data,200);
    }

    #[Route('/api/tags-saludables', name: 'tags_list', methods: ['GET'])]
    public function listarTags(): JsonResponse
    {
        $tags = $this->em->getRepository(TagSaludable::class)->findAll();
        $data = array_map(fn($t) => ['id'=>$t->getId(),'nombre'=>$t->getNombre()], $tags);
        return new JsonResponse($data,200);
    }

    
    #[Route('/api/recetas', name: 'recetas_create', methods: ['POST'])]
    public function crear(Request $request): JsonResponse
    {
        $nombre = $request->request->get('nombre');
        $descripcion = $request->request->get('descripcion');
        $tiempoPreparacion = $request->request->get('tiempoPreparacion');
        $porciones = $request->request->get('porciones');
        $dificultad = $request->request->get('dificultad');
        $categoriaId = $request->request->get('categoria');

        $imagenFile = $request->files->get('imagen');
        $imagenNombre = null;

        if ($imagenFile) {
            $originalFilename = pathinfo($imagenFile->getClientOriginalName(), PATHINFO_FILENAME);
            $safeFilename = $this->slugger->slug($originalFilename);
            $newFilename = $safeFilename.'-'.uniqid().'.'.$imagenFile->guessExtension();

            try {
                $imagenFile->move(
                    $this->getParameter('imagenes_directory'),
                    $newFilename
                );
                $imagenNombre = $newFilename;
            } catch (FileException $e) {
                return new JsonResponse(['error' => 'Error al subir la imagen: ' . $e->getMessage()], 500);
            }
        }

        $receta = new Receta();
        $receta->setNombre($nombre ?? '');
        $receta->setDescripcion($descripcion ?? '');
        $receta->setImagen($imagenNombre);
        $receta->setTiempoPreparacion((int)($tiempoPreparacion ?? 0));
        $receta->setPorciones((int)($porciones ?? 1));
        $receta->setDificultad($dificultad);

        if ($categoriaId) {
            $categoria = $this->em->getRepository(Categoria::class)->find($categoriaId);
            if ($categoria) $receta->setCategoria($categoria);
        }

        $this->em->persist($receta);
        $this->em->flush();

        $ingredientesJson = $request->request->get('ingredientes');
        if ($ingredientesJson) {
            $ingredientes = json_decode($ingredientesJson, true);
            if (is_array($ingredientes)) {
                foreach ($ingredientes as $item) {
                    $ingrediente = $this->em->getRepository(Ingrediente::class)->find($item['id'] ?? null);
                    if ($ingrediente) {
                        $rel = new RecetaIngrediente();
                        $rel->setReceta($receta);
                        $rel->setIngrediente($ingrediente);
                        $rel->setCantidad($item['cantidad'] ?? 0);
                        $rel->setMedida($item['medida'] ?? 'g');
                        $this->em->persist($rel);
                    }
                }
            }
        }

        $instruccionesJson = $request->request->get('instrucciones');
        if ($instruccionesJson) {
            $instrucciones = json_decode($instruccionesJson, true);
            if (is_array($instrucciones)) {
                foreach ($instrucciones as $index => $texto) {
                    $inst = new Instruccion();
                    $inst->setReceta($receta);
                    $inst->setPaso($texto);
                    $inst->setOrden($index + 1);
                    $this->em->persist($inst);
                }
            }
        }

        $alergenosJson = $request->request->get('alergenos');
        if ($alergenosJson) {
            $alergenos = json_decode($alergenosJson, true);
            if (is_array($alergenos)) {
                foreach ($alergenos as $idA) {
                    $alergeno = $this->em->getRepository(Alergeno::class)->find($idA);
                    if ($alergeno) {
                        $rel = new RecetaAlergeno();
                        $rel->setReceta($receta);
                        $rel->setAlergeno($alergeno);
                        $this->em->persist($rel);
                    }
                }
            }
        }

        $tagsJson = $request->request->get('tagsSaludables');
        if ($tagsJson) {
            $tags = json_decode($tagsJson, true);
            if (is_array($tags)) {
                foreach ($tags as $idT) {
                    $tag = $this->em->getRepository(TagSaludable::class)->find($idT);
                    if ($tag) {
                        $rel = new RecetaTag();
                        $rel->setReceta($receta);
                        $rel->setTag($tag);
                        $this->em->persist($rel);
                    }
                }
            }
        }

        $this->em->flush();

        return new JsonResponse([
            'message' => 'Receta creada correctamente',
            'id' => $receta->getId(),
            'imagen' => $imagenNombre
        ], 201);
    }

 
    #[Route('/api/recetas/{id}', name: 'recetas_edit', methods: ['PUT', 'POST'])]
    public function editar(int $id, Request $request): JsonResponse
    {
        $receta = $this->em->getRepository(Receta::class)->find($id);
        if (!$receta) return new JsonResponse(['error'=>'Receta no encontrada'],404);

        if ($request->files->count() > 0 || $request->request->count() > 0) {
            $nombre = $request->request->get('nombre');
            $descripcion = $request->request->get('descripcion');
            $tiempoPreparacion = $request->request->get('tiempoPreparacion');
            $porciones = $request->request->get('porciones');
            $dificultad = $request->request->get('dificultad');
            $categoriaId = $request->request->get('categoria');

            if ($nombre) $receta->setNombre($nombre);
            if ($descripcion !== null) $receta->setDescripcion($descripcion);
            if ($tiempoPreparacion !== null) $receta->setTiempoPreparacion((int)$tiempoPreparacion);
            if ($porciones !== null) $receta->setPorciones((int)$porciones);
            if ($dificultad !== null) $receta->setDificultad($dificultad);

            if ($categoriaId) {
                $categoria = $this->em->getRepository(Categoria::class)->find($categoriaId);
                if ($categoria) $receta->setCategoria($categoria);
            }

            $imagenFile = $request->files->get('imagen');
            if ($imagenFile) {
                $originalFilename = pathinfo($imagenFile->getClientOriginalName(), PATHINFO_FILENAME);
                $safeFilename = $this->slugger->slug($originalFilename);
                $newFilename = $safeFilename.'-'.uniqid().'.'.$imagenFile->guessExtension();

                try {
                    $imagenFile->move($this->getParameter('imagenes_directory'), $newFilename);
                    
                    if ($receta->getImagen()) {
                        $oldFile = $this->getParameter('imagenes_directory').'/'.$receta->getImagen();
                        if (file_exists($oldFile)) {
                            unlink($oldFile);
                        }
                    }
                    
                    $receta->setImagen($newFilename);
                } catch (FileException $e) {
                    return new JsonResponse(['error' => 'Error al subir la imagen'], 500);
                }
            }

            $ingredientesJson = $request->request->get('ingredientes');
            if ($ingredientesJson) {
                foreach ($receta->getIngredientesRel() as $ri) {
                    $this->em->remove($ri);
                }
                $this->em->flush();

                $ingredientes = json_decode($ingredientesJson, true);
                if (is_array($ingredientes)) {
                    foreach ($ingredientes as $item) {
                        $ingrediente = $this->em->getRepository(Ingrediente::class)->find($item['id'] ?? null);
                        if ($ingrediente) {
                            $rel = new RecetaIngrediente();
                            $rel->setReceta($receta);
                            $rel->setIngrediente($ingrediente);
                            $rel->setCantidad($item['cantidad'] ?? 0);
                            $rel->setMedida($item['medida'] ?? 'g');
                            $this->em->persist($rel);
                        }
                    }
                }
            }

            $instruccionesJson = $request->request->get('instrucciones');
            if ($instruccionesJson) {
                foreach ($receta->getInstrucciones() as $inst) {
                    $this->em->remove($inst);
                }
                $this->em->flush();

                $instrucciones = json_decode($instruccionesJson, true);
                if (is_array($instrucciones)) {
                    foreach ($instrucciones as $index => $texto) {
                        $inst = new Instruccion();
                        $inst->setReceta($receta);
                        $inst->setPaso($texto);
                        $inst->setOrden($index + 1);
                        $this->em->persist($inst);
                    }
                }
            }

            $alergenosJson = $request->request->get('alergenos');
            if ($alergenosJson) {
                foreach ($receta->getAlergenosRel() as $ra) {
                    $this->em->remove($ra);
                }
                $this->em->flush();

                $alergenos = json_decode($alergenosJson, true);
                if (is_array($alergenos)) {
                    foreach ($alergenos as $idA) {
                        $alergeno = $this->em->getRepository(Alergeno::class)->find($idA);
                        if ($alergeno) {
                            $rel = new RecetaAlergeno();
                            $rel->setReceta($receta);
                            $rel->setAlergeno($alergeno);
                            $this->em->persist($rel);
                        }
                    }
                }
            }

            $tagsJson = $request->request->get('tagsSaludables');
            if ($tagsJson) {
                foreach ($receta->getTagsRel() as $rt) {
                    $this->em->remove($rt);
                }
                $this->em->flush();

                $tags = json_decode($tagsJson, true);
                if (is_array($tags)) {
                    foreach ($tags as $idT) {
                        $tag = $this->em->getRepository(TagSaludable::class)->find($idT);
                        if ($tag) {
                            $rel = new RecetaTag();
                            $rel->setReceta($receta);
                            $rel->setTag($tag);
                            $this->em->persist($rel);
                        }
                    }
                }
            }

        } else {
            $data = json_decode($request->getContent(), true);
            if ($data) {
                $receta->setNombre($data['nombre'] ?? $receta->getNombre());
                $receta->setDescripcion($data['descripcion'] ?? $receta->getDescripcion());
                $receta->setTiempoPreparacion($data['tiempoPreparacion'] ?? $receta->getTiempoPreparacion());
                $receta->setPorciones($data['porciones'] ?? $receta->getPorciones());
                $receta->setDificultad($data['dificultad'] ?? $receta->getDificultad());
            }
        }

        $this->em->flush();

        return new JsonResponse(['message'=>'Receta actualizada']);
    }


    #[Route('/api/recetas/{id}', name: 'recetas_delete', methods: ['DELETE'])]
    public function borrar(int $id): JsonResponse
    {
        $receta = $this->em->getRepository(Receta::class)->find($id);
        if (!$receta) return new JsonResponse(['error' => 'Receta no encontrada'], 404);

        if ($receta->getImagen()) {
            $imagePath = $this->getParameter('imagenes_directory').'/'.$receta->getImagen();
            if (file_exists($imagePath)) {
                unlink($imagePath);
            }
        }
        
        foreach ($receta->getIngredientesRel() as $ri) $this->em->remove($ri);
        foreach ($receta->getInstrucciones() as $inst) $this->em->remove($inst);
        foreach ($receta->getAlergenosRel() as $ra) $this->em->remove($ra);
        foreach ($receta->getTagsRel() as $rt) $this->em->remove($rt);

        $this->em->remove($receta);
        $this->em->flush();

        return new JsonResponse(['message' => 'Receta eliminada correctamente']);
    }
}