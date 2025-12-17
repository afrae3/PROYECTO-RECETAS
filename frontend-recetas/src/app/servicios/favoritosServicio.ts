import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Receta } from './recetas';

@Injectable({
  providedIn: 'root'
})
export class FavoritosService {
  private apiUrl = 'http://127.0.0.1:8000/api/favoritos';

  constructor(private http: HttpClient) {}

  listarFavoritosPorUsuario(usuarioId: number): Observable<Receta[]> {
    return this.http.get<Receta[]>(`${this.apiUrl}?usuarioId=${usuarioId}`);
  }

  agregarFavorito(usuarioId: number, recetaId: number): Observable<any> {
    return this.http.post(this.apiUrl, { usuarioId, recetaId });
  }

  eliminarFavorito(usuarioId: number, recetaId: number): Observable<any> {
    return this.http.post(`${this.apiUrl}/delete`, { usuarioId, recetaId });
  }
}
