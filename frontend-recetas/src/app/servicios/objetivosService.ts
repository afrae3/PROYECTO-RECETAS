import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface ObjetivosPersonales {
  sexo: string;
  edad: number;
  peso: number;
  altura: number;
  nivelActividad: string;
  objetivo: string;
}

export interface Objetivos extends ObjetivosPersonales {
  calorias: number;
  proteinas: number;
  grasas: number;
  carbohidratos: number;
  fibra: number;
}

@Injectable({ providedIn: 'root' })
export class ObjetivosService {
  private apiUrl = 'http://127.0.0.1:8000/api/objetivos';

  constructor(private http: HttpClient) {}

  obtener(usuarioId: number): Observable<Objetivos> {
    return this.http.get<Objetivos>(`${this.apiUrl}?usuarioId=${usuarioId}`);
  }

  guardar(usuarioId: number, datos: ObjetivosPersonales): Observable<any> {
    return this.http.post(this.apiUrl, { usuarioId, ...datos });
  }

  eliminar(usuarioId: number): Observable<any> {
    return this.http.delete(this.apiUrl, { body: { usuarioId } });
  }
}