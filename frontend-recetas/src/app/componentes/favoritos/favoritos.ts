// src/app/componentes/favoritos/favoritos.ts
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FavoritosService } from '../../servicios/favoritosServicio';
import { Receta } from '../../servicios/recetas';
import { Auth } from '../../servicios/auth';

@Component({
  selector: 'app-favoritos',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './favoritos.html',
  styleUrls: ['./favoritos.css']
})
export class Favoritos implements OnInit {

  favoritos: Receta[] = [];

  constructor(
    private favoritosService: FavoritosService,
    private auth: Auth
  ) {}

  ngOnInit(): void {
    this.cargarFavoritos();
  }

  cargarFavoritos(): void {
    const userId = this.auth.getUserId();
    if (!userId) {
      console.error('Usuario no logueado');
      this.favoritos = [];
      return;
    }

    this.favoritosService.listarFavoritosPorUsuario(userId).subscribe({
      next: (res: Receta[]) => this.favoritos = res,
      error: (err: unknown) => console.error('Error al cargar favoritos', err)
    });
  }

  eliminarFavorito(receta: Receta): void {
    const userId = this.auth.getUserId();
    if (!userId) {
      console.error('Usuario no logueado');
      return;
    }

    this.favoritosService.eliminarFavorito(userId, receta.id).subscribe({
      next: () => this.cargarFavoritos(),
      error: (err: unknown) => console.error('Error al eliminar favorito', err)
    });
  }

  agregarFavorito(receta: Receta): void {
    const userId = this.auth.getUserId();
    if (!userId) {
      console.error('Usuario no logueado');
      return;
    }

    this.favoritosService.agregarFavorito(userId, receta.id).subscribe({
      next: () => this.cargarFavoritos(),
      error: (err: unknown) => console.error('Error al agregar favorito', err)
    });
  }

  clearTodos(): void {
    this.favoritos.forEach(receta => this.eliminarFavorito(receta));
  }
}
