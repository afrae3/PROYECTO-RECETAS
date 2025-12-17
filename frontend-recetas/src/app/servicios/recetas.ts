import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface IngredienteReceta {
  id?: number;
  nombre: string;
  cantidad: number;
  medida: string;
}

export interface Receta {
  id: number;
  nombre: string;
  descripcion: string;
  imagen?: string;
  tiempoPreparacion?: number;
  porciones?: number;
  ingredientes?: IngredienteReceta[];
  instrucciones?: string[];
  categoria?: number | string; 
  dificultad?: string | null;
  alergenos?: (number | string)[]; 
  tagsSaludables?: (number | string)[]; 
  calorias?: number;
  proteinas?: number;
  grasas?: number;
  carbohidratos?: number;
  fibra?: number;
  azucares?: number;
}

@Injectable({
  providedIn: 'root'
})
export class RecetasService {
  private apiUrl = 'https://proyecto-recetas-backend.onrender.com/api/recetas';
  private apiCategorias = 'https://proyecto-recetas-backend.onrender.com/api/categorias';
  private apiIngredientes = 'https://proyecto-recetas-backend.onrender.com/api/ingredientes';
  private apiTags = 'https://proyecto-recetas-backend.onrender.com/api/tags-saludables';
  private apiAlergenos = 'https://proyecto-recetas-backend.onrender.com/api/alergenos';

  constructor(private http: HttpClient) {}

  // Recetas
  getRecetas(): Observable<Receta[]> {
    return this.http.get<Receta[]>(this.apiUrl);
  }

  crearReceta(formData: FormData): Observable<any> {
    return this.http.post<any>(this.apiUrl, formData);
  }

  editarReceta(id: number, formData: FormData): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/${id}`, formData);
  }

  borrarReceta(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }

  // Selects
  getCategorias(): Observable<{id:number,nombre:string}[]> {
    return this.http.get<{id:number,nombre:string}[]>(this.apiCategorias);
  }
  
  getIngredientes(): Observable<{id:number,nombre:string}[]> {
    return this.http.get<{id:number,nombre:string}[]>(this.apiIngredientes);
  }

  getAlergenos(): Observable<{id:number,nombre:string}[]> {
    return this.http.get<{id:number,nombre:string}[]>(this.apiAlergenos);
  }

  getTags(): Observable<{id:number,nombre:string}[]> {
    return this.http.get<{id:number,nombre:string}[]>(this.apiTags);
  }
}