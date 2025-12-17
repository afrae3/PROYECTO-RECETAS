import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject } from 'rxjs';
import { tap, map } from 'rxjs/operators';
import { Auth } from './auth';

export interface Comida {
  dia: string;
  tipo: 'desayuno' | 'comida' | 'cena';
  recetaId: number;
}

@Injectable({ providedIn: 'root' })
export class MenuSemanalService {
  private apiUrl = 'http://127.0.0.1:8000/api/menu-semanal';
  private menuSubject = new BehaviorSubject<Comida[]>([]);

  constructor(private http: HttpClient, private auth: Auth) {}

  private getUsuarioId(): number {
    const id = this.auth.getUserId();
    if (!id) throw new Error('No hay usuario logueado');
    return id;
  }

  obtenerMenu(): Observable<Comida[]> {
    const usuarioId = this.getUsuarioId();
    return this.http.get<{ menu: Comida[] }>(`${this.apiUrl}?usuarioId=${usuarioId}`)
      .pipe(
        tap(res => this.menuSubject.next(res.menu || [])),
        map(res => res.menu || [])
      );
  }

  guardarMenu(menu: Comida[]): Observable<any> {
    const usuarioId = this.getUsuarioId();
    return this.http.post(`${this.apiUrl}/generar`, { usuarioId, menu })
      .pipe(tap(() => this.menuSubject.next(menu)));
  }

  actualizarComida(dia: string, tipo: 'desayuno'|'comida'|'cena', recetaId: number): Observable<any> {
    const usuarioId = this.getUsuarioId();
    return this.http.post(`${this.apiUrl}/editar`, { dia, tipo, receta_id: recetaId, usuarioId })
      .pipe(tap((res: any) => {
        const menuActual = this.menuSubject.getValue();
        const index = menuActual.findIndex(c => c.dia === dia && c.tipo === tipo);
        if (index !== -1) menuActual[index].recetaId = recetaId;
        else menuActual.push({ dia, tipo, recetaId });
        this.menuSubject.next(menuActual);
      }));
  }

  obtenerMenuUsuario(): Observable<any> {
    const usuarioId = this.getUsuarioId();
    return this.http.get<any>(`${this.apiUrl}/usuario?usuarioId=${usuarioId}`);
  }

  obtenerMenuPorId(menuId: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/usuario?usuarioId=${this.getUsuarioId()}`);
  }

  borrarMenu(): Observable<any> {
    const usuarioId = this.getUsuarioId();
    return this.http.delete(`${this.apiUrl}/borrar`, { 
      body: { usuarioId } 
    }).pipe(
      tap(() => {
        this.menuSubject.next([]);
      })
    );
  }

  getMenuObservable(): Observable<Comida[]> {
    return this.menuSubject.asObservable();
  }
}