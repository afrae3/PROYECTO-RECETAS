import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RecetasService, Receta } from '../../servicios/recetas';
import { FavoritosService } from '../../servicios/favoritosServicio';
import { Auth } from '../../servicios/auth';
import { forkJoin } from 'rxjs';

interface RecetaConCategoriaNombre extends Receta {
  categoriaNombre?: string;
}

@Component({
  selector: 'app-lista-recetas',
  standalone: true,
  imports: [CommonModule, HttpClientModule, FormsModule],
  templateUrl: './lista-recetas.html',
  styleUrls: ['./lista-recetas.css']
})
export class ListaRecetas implements OnInit {

  recetas: RecetaConCategoriaNombre[] = [];
  recetasFiltradas: RecetaConCategoriaNombre[] = [];
  favoritos: Receta[] = [];
  categorias: {id:number, nombre:string}[] = [];
  tags: {id:number, nombre:string}[] = [];
  cargando = true;

  categoriaSeleccionada: string | number = 'todas';
  
  tagBusqueda: string = '';
  tagsSugeridos: {id:number, nombre:string}[] = [];
  tagsSeleccionados: {id:number, nombre:string}[] = [];
  mostrarSugerencias: boolean = false;

  recetaSeleccionada: RecetaConCategoriaNombre | null = null;
  modalAbierto = false;

  constructor(
    private recetasService: RecetasService,
    private favoritosService: FavoritosService,
    public auth: Auth,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.cargando = true;
    
    forkJoin({
      categorias: this.recetasService.getCategorias(),
      recetas: this.recetasService.getRecetas(),
      tags: this.recetasService.getTags()
    }).subscribe({
      next: ({categorias, recetas, tags}) => {
        this.categorias = categorias;
        this.tags = tags;
        
        this.recetas = recetas.map(receta => {
          const categoria = categorias.find(c => c.id === receta.categoria);
          return {
            ...receta,
            categoriaNombre: categoria?.nombre || 'Sin categoría'
          };
        });
        
        this.recetasFiltradas = [...this.recetas];
        this.cargando = false;
        
        console.log('✅ Datos transformados correctamente');
        console.log('Tags cargados:', this.tags.length);
      },
      error: err => {
        console.error('❌ Error al cargar datos:', err);
        this.cargando = false;
      }
    });
    
    this.cargarFavoritos();
  }

  cargarFavoritos(): void {
    const userId = this.auth.getUserId();
    if (!userId) {
      this.favoritos = [];
      return;
    }

    this.favoritosService.listarFavoritosPorUsuario(userId).subscribe({
      next: (res: Receta[]) => this.favoritos = res,
      error: err => console.error('Error al cargar favoritos', err)
    });
  }

  aplicarFiltros(): void {
    let resultado = [...this.recetas];
    
    if (this.categoriaSeleccionada !== 'todas') {
      const categoriaIdSeleccionada = typeof this.categoriaSeleccionada === 'string' 
        ? parseInt(this.categoriaSeleccionada) 
        : this.categoriaSeleccionada;
      
      resultado = resultado.filter(receta => receta.categoria === categoriaIdSeleccionada);
    }
    
    if (this.tagsSeleccionados.length > 0) {
      resultado = resultado.filter(receta => {
        return this.tagsSeleccionados.every(tagSelec => {
          return receta.tagsSaludables?.some(tagReceta => {
            if (typeof tagReceta === 'number') {
              return tagReceta === tagSelec.id;
            }
            return tagReceta === tagSelec.nombre;
          });
        });
      });
    }
    
    this.recetasFiltradas = resultado;
    
    console.log('🔍 Filtros aplicados:', {
      categoriaSeleccionada: this.categoriaSeleccionada,
      tagsSeleccionados: this.tagsSeleccionados.length,
      totalRecetas: this.recetas.length,
      recetasFiltradas: this.recetasFiltradas.length
    });
  }

  onTagBusquedaChange(): void {
    if (this.tagBusqueda.trim().length >= 2) {
      const busqueda = this.tagBusqueda.toLowerCase();
      this.tagsSugeridos = this.tags.filter(tag => 
        tag.nombre.toLowerCase().includes(busqueda) &&
        !this.tagsSeleccionados.some(t => t.id === tag.id)
      );
      this.mostrarSugerencias = this.tagsSugeridos.length > 0;
    } else {
      this.tagsSugeridos = [];
      this.mostrarSugerencias = false;
    }
  }

  seleccionarTag(tag: {id:number, nombre:string}): void {
    if (!this.tagsSeleccionados.some(t => t.id === tag.id)) {
      this.tagsSeleccionados.push(tag);
      this.tagBusqueda = '';
      this.tagsSugeridos = [];
      this.mostrarSugerencias = false;
      this.aplicarFiltros();
    }
  }

  quitarTagSeleccionado(index: number): void {
    this.tagsSeleccionados.splice(index, 1);
    this.aplicarFiltros();
  }

  cerrarSugerencias(): void {
    setTimeout(() => {
      this.mostrarSugerencias = false;
    }, 200);
  }

  onCategoriaChange(): void {
    this.aplicarFiltros();
  }

  esFavorito(receta: Receta): boolean {
    return this.favoritos.some(fav => fav.id === receta.id);
  }

  toggleFavorito(receta: Receta): void {
    const userId = this.auth.getUserId();
    if (!userId) {
      alert('Por favor, inicia sesión para agregar favoritos');
      return;
    }

    if (this.esFavorito(receta)) {
      this.favoritosService.eliminarFavorito(userId, receta.id)
        .subscribe(() => this.cargarFavoritos());
    } else {
      this.favoritosService.agregarFavorito(userId, receta.id)
        .subscribe(() => this.cargarFavoritos());
    }
  }

  isLoggedIn(): boolean {
    return this.auth.isLoggedIn();
  }

  irALogin(): void {
    this.router.navigate(['/login']);
  }

  abrirModal(receta: RecetaConCategoriaNombre): void {
    this.recetaSeleccionada = receta;
    this.modalAbierto = true;
  }

  cerrarModal(): void {
    this.recetaSeleccionada = null;
    this.modalAbierto = false;
  }
}

