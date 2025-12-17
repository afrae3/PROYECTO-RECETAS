import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Comida {
  nombre: string;
  tipo: string;
  calorias: number;
  proteinas: number;
  grasas: number;
  carbohidratos: number;
}

export interface DatosDia {
  calorias: number;
  proteinas: number;
  grasas: number;
  carbohidratos: number;
  fibra: number;
  azucares: number;
  comidas: Comida[];
}

export interface Objetivos {
  calorias: number;
  proteinas: number;
  grasas: number;
  carbohidratos: number;
  fibra: number;
}

export interface EstadisticasResponse {
  fechaMenu: string;
  datosPorDia: { [dia: string]: DatosDia };
  totalesSemanales: {
    calorias: number;
    proteinas: number;
    grasas: number;
    carbohidratos: number;
    fibra: number;
    azucares: number;
  };
  promediosDiarios: {
    calorias: number;
    proteinas: number;
    grasas: number;
    carbohidratos: number;
    fibra: number;
    azucares: number;
  };
  objetivos?: Objetivos; 
}

@Injectable({ providedIn: 'root' })
export class DashboardService { 
  private apiUrl = 'http://127.0.0.1:8000/api/dashboard';

  constructor(private http: HttpClient) {}

  obtenerEstadisticas(usuarioId: number): Observable<EstadisticasResponse> {
    return this.http.get<EstadisticasResponse>(`${this.apiUrl}?usuarioId=${usuarioId}`);
  }
}