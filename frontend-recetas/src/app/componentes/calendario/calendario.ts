// src/app/componentes/calendario/calendario.component.ts
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { MenuSemanalService, Comida } from '../../servicios/menu-semanal';
import { RecetasService, Receta } from '../../servicios/recetas';
import { PdfGenerator, IngredienteAgrupado } from '../../servicios/pdf-generator';
import { forkJoin } from 'rxjs';

interface DiaConFecha {
  nombre: string;
  fecha: string;
  nombreCompleto: string;
}

@Component({
  selector: 'app-calendario',
  standalone: true,
  imports: [CommonModule, FormsModule, HttpClientModule],
  templateUrl: './calendario.html',
  styleUrls: ['./calendario.css']
})
export class Calendario implements OnInit {

  diasSemana: DiaConFecha[] = [];

  existeMenuEstaSemana = false;
  menuSemanalCompleto: any = null;
  mensaje: string | null = null;
  fechaCreacionMenu: string = '';
  fechaInicioMenu: string = '';
  fechaFinMenu: string = '';

  activarMenuSemanal = true;
  incluirDesayuno = false;
  preferencias: { desayuno: string[], comida: string[], cena: string[] } = { 
    desayuno: ['Desayuno'], 
    comida: [], 
    cena: [] 
  };
  recetasDisponibles: Receta[] = [];
  
  categorias: { id: number, nombre: string }[] = [];
  categoriasNombres: string[] = [];
  categoriasDesayuno: string[] = ['Desayuno'];
  categoriasMap: Map<number, string> = new Map();
  
  menuGenerado: Comida[] = [];
  menuMap: { [key: string]: Comida } = {};

  constructor(
    private menuService: MenuSemanalService,
    private recetasService: RecetasService,
    private pdfService: PdfGenerator
  ) {}

  ngOnInit(): void {
    forkJoin({
      recetas: this.recetasService.getRecetas(),
      categorias: this.recetasService.getCategorias()
    }).subscribe({
      next: ({ recetas, categorias }) => {
        this.recetasDisponibles = recetas;
        this.categorias = categorias;
        
        this.categoriasMap = new Map(
          categorias.map(cat => [cat.id, cat.nombre])
        );
        
        this.categoriasNombres = categorias.map(cat => cat.nombre);
        
        console.log('✅ Categorías cargadas:', this.categorias);
      },
      error: (err) => {
        console.error('Error al cargar datos iniciales', err);
      }
    });

    this.cargarMenuUsuario();
  }

  calcularDiasSemana(fechaInicio?: string, fechaFin?: string): void {
    const diasOrdenados: DiaConFecha[] = [];
    const nombresDias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
    
    if (fechaInicio && fechaFin) {
      const inicio = new Date(fechaInicio + 'T00:00:00');
      const fin = new Date(fechaFin + 'T00:00:00');
      
      const fechaActual = new Date(inicio);
      
      while (fechaActual <= fin) {
        const diaSemana = fechaActual.getDay();
        const nombreDia = nombresDias[diaSemana];
        
        const dia = fechaActual.getDate().toString().padStart(2, '0');
        const mes = (fechaActual.getMonth() + 1).toString().padStart(2, '0');
        const anio = fechaActual.getFullYear();
        const fechaFormateada = `${dia}/${mes}/${anio}`;
        
        diasOrdenados.push({
          nombre: nombreDia,
          fecha: fechaFormateada,
          nombreCompleto: `${nombreDia} (${fechaFormateada})`
        });
        
        fechaActual.setDate(fechaActual.getDate() + 1);
      }
    } else {
      const hoy = new Date();
      const hora = hoy.getHours();
      
      let fechaInicioCalc: Date;
      if (hora >= 16) {
        fechaInicioCalc = new Date(hoy);
        fechaInicioCalc.setDate(hoy.getDate() + 1);
      } else {
        fechaInicioCalc = new Date(hoy);
      }
      
      fechaInicioCalc.setHours(0, 0, 0, 0);
      
      for (let i = 0; i < 7; i++) {
        const fecha = new Date(fechaInicioCalc);
        fecha.setDate(fechaInicioCalc.getDate() + i);
        
        const diaSemana = fecha.getDay();
        const nombreDia = nombresDias[diaSemana];
        
        const dia = fecha.getDate().toString().padStart(2, '0');
        const mes = (fecha.getMonth() + 1).toString().padStart(2, '0');
        const anio = fecha.getFullYear();
        const fechaFormateada = `${dia}/${mes}/${anio}`;
        
        diasOrdenados.push({
          nombre: nombreDia,
          fecha: fechaFormateada,
          nombreCompleto: `${nombreDia} (${fechaFormateada})`
        });
      }
    }
    
    this.diasSemana = diasOrdenados;
  }

  cargarMenuUsuario() {
    this.menuService.obtenerMenuUsuario().subscribe({
      next: (res) => {
        this.menuSemanalCompleto = this._enriquecerConNutrientes(res);
        this.existeMenuEstaSemana = true;
        this.activarMenuSemanal = false;
        
        this.fechaCreacionMenu = this.formatearFecha(res.fechaCreacion);
        this.fechaInicioMenu = this.formatearFecha(res.fechaInicio);
        this.fechaFinMenu = this.formatearFecha(res.fechaFin);
        
        this.mensaje = null;
        
        console.log('📅 Menú cargado:', {
          fechaCreacion: this.fechaCreacionMenu,
          fechaInicio: this.fechaInicioMenu,
          fechaFin: this.fechaFinMenu,
          diasDisponibles: Object.keys(res.recetasPorDia || {})
        });
        
        if (res.fechaInicio && res.fechaFin) {
          this.calcularDiasSemana(res.fechaInicio, res.fechaFin);
        }
      },
      error: (err) => {
        if (err.status === 404) {
          this.existeMenuEstaSemana = false;
          this.menuSemanalCompleto = null;
          this.activarMenuSemanal = true;
          this.mensaje = 'No hay menú semanal vigente. Genera uno nuevo.';
          
          this.calcularDiasSemana();
        } else if (err.status === 400 && err.error?.menuExistenteId) {
          this.mensaje = 'Ya existe un menú vigente que cubre estas fechas.';
          setTimeout(() => this.cargarMenuUsuario(), 500);
        } else {
          this.mensaje = err.error?.error || 'Error al cargar menú';
          console.error(err);
        }
      }
    });
  }

  generarMenu(): void {
    if (!this.activarMenuSemanal) return;

    this.menuGenerado = this.diasSemana.flatMap(diaObj => {
      const comidas: Comida[] = [
        { dia: diaObj.nombre, tipo: 'comida', recetaId: this._seleccionarRecetaAleatoria(this.preferencias.comida)?.id || 0 },
        { dia: diaObj.nombre, tipo: 'cena', recetaId: this._seleccionarRecetaAleatoria(this.preferencias.cena)?.id || 0 }
      ];

      if (this.incluirDesayuno) {
        comidas.unshift({ 
          dia: diaObj.nombre, 
          tipo: 'desayuno', 
          recetaId: this._seleccionarRecetaAleatoria(this.preferencias.desayuno)?.id || 0 
        });
      }

      return comidas;
    });

    this.menuGenerado.forEach(c => this.menuMap[`${c.dia}-${c.tipo}`] = c);
  }

  guardarMenu() {
    if (!this.menuGenerado || this.menuGenerado.length === 0) {
      this.mensaje = 'Genera un menú antes de guardar.';
      return;
    }

    this.menuService.guardarMenu(this.menuGenerado).subscribe({
      next: (res) => {
        this.mensaje = `Menú guardado correctamente (${this.formatearFecha(res.fechaInicio)} - ${this.formatearFecha(res.fechaFin)})`;
        this.cargarMenuUsuario();
      },
      error: (err) => {
        if (err.status === 400 && err.error?.menuExistenteId) {
          this.mensaje = 'Ya existe un menú vigente que cubre estas fechas.';
          this.cargarMenuUsuario();
        } else {
          this.mensaje = err.error?.error || 'Error al guardar menú';
          console.error(err);
        }
      }
    });
  }

  borrarMenu(): void {
    if (!confirm('¿Estás seguro de que quieres borrar el menú semanal?')) {
      return;
    }

    this.menuService.borrarMenu().subscribe({
      next: () => {
        this.mensaje = 'Menú borrado correctamente.';
        this.existeMenuEstaSemana = false;
        this.menuSemanalCompleto = null;
        this.activarMenuSemanal = true;
        this.menuGenerado = [];
        this.menuMap = {};
        this.fechaCreacionMenu = '';
        this.fechaInicioMenu = '';
        this.fechaFinMenu = '';
        
        this.calcularDiasSemana();
      },
      error: (err) => {
        this.mensaje = err.error?.error || 'Error al borrar el menú';
        console.error(err);
      }
    });
  }

  generarListaCompra(): void {
    if (!this.menuSemanalCompleto || !this.menuSemanalCompleto.recetasPorDia) {
      this.mensaje = 'No hay menú disponible para generar lista de compra';
      return;
    }

    const recetasDelMenu: Receta[] = [];
    Object.values(this.menuSemanalCompleto.recetasPorDia).forEach((comidas: any) => {
      comidas.forEach((c: any) => {
        const receta = this.recetasDisponibles.find(r => r.id === c.id);
        if (receta) recetasDelMenu.push(receta);
      });
    });

    const ingredientesAgrupados = this._agruparIngredientes(recetasDelMenu);
    const fechaInicio = this.diasSemana[0]?.fecha || '';
    const fechaFin = this.diasSemana[this.diasSemana.length - 1]?.fecha || '';

    this.pdfService.generarListaCompra(ingredientesAgrupados, fechaInicio, fechaFin);
    this.mensaje = 'Lista de compra generada correctamente';
  }

  generarListaCheckbox(): void {
    if (!this.menuSemanalCompleto || !this.menuSemanalCompleto.recetasPorDia) {
      this.mensaje = 'No hay menú disponible para generar lista de compra';
      return;
    }

    const recetasDelMenu: Receta[] = [];
    Object.values(this.menuSemanalCompleto.recetasPorDia).forEach((comidas: any) => {
      comidas.forEach((c: any) => {
        const receta = this.recetasDisponibles.find(r => r.id === c.id);
        if (receta) recetasDelMenu.push(receta);
      });
    });

    const ingredientesAgrupados = this._agruparIngredientes(recetasDelMenu);
    const fechaInicio = this.diasSemana[0]?.fecha || '';
    const fechaFin = this.diasSemana[this.diasSemana.length - 1]?.fecha || '';

    this.pdfService.generarListaCheckbox(ingredientesAgrupados, fechaInicio, fechaFin);
    this.mensaje = 'Lista con checkbox generada correctamente';
  }

  sustituirReceta(dia: string, tipo: 'desayuno'|'comida'|'cena', recetaId: number) {
    if (!this.activarMenuSemanal) return;
    const c: Comida = { dia, tipo, recetaId };
    this.menuMap[`${dia}-${tipo}`] = c;
    this.menuGenerado = Object.values(this.menuMap);
  }

  private _seleccionarRecetaAleatoria(preferenciasNombres: string[]): Receta | null {
    if (preferenciasNombres.length === 0) {
      if (this.recetasDisponibles.length === 0) return null;
      return this.recetasDisponibles[Math.floor(Math.random() * this.recetasDisponibles.length)];
    }
    
    const filtradas = this.recetasDisponibles.filter(r => {
      if (r.categoria === null || r.categoria === undefined) return false;
      
      const categoriaId = typeof r.categoria === 'number' ? r.categoria : Number(r.categoria);
      const nombreCategoria = this.categoriasMap.get(categoriaId);
      
      return nombreCategoria && preferenciasNombres.includes(nombreCategoria);
    });
    
    if (filtradas.length === 0) return null;
    return filtradas[Math.floor(Math.random() * filtradas.length)];
  }

  filtrarRecetasPorCategoria(tipo: 'desayuno'|'comida'|'cena'): Receta[] {
    let preferenciasDelTipo: string[];
    
    if (tipo === 'desayuno') {
      preferenciasDelTipo = this.preferencias.desayuno.length > 0 
        ? this.preferencias.desayuno 
        : this.categoriasDesayuno;
    } else if (tipo === 'comida') {
      preferenciasDelTipo = this.preferencias.comida;
    } else {
      preferenciasDelTipo = this.preferencias.cena;
    }
    
    if (preferenciasDelTipo.length === 0) {
      return this.recetasDisponibles;
    }
    
    return this.recetasDisponibles.filter(r => {
      if (r.categoria === null || r.categoria === undefined) return false;
      
      const categoriaId = typeof r.categoria === 'number' ? r.categoria : Number(r.categoria);
      const nombreCategoria = this.categoriasMap.get(categoriaId);
      
      return nombreCategoria && preferenciasDelTipo.includes(nombreCategoria);
    });
  }

  private _agruparIngredientes(recetas: Receta[]): IngredienteAgrupado[] {
    const mapa = new Map<string, IngredienteAgrupado>();

    recetas.forEach(receta => {
      const nombreReceta = receta.nombre;
      const ingredientes = (receta as any).ingredientes || [];
      
      ingredientes.forEach((ing: any) => {
        const nombreIng = ing.nombre || (ing.ingrediente?.nombre);
        const cantidad = Number(ing.cantidad || 0);
        const medida = ing.medida || 'g';

        if (!nombreIng || cantidad === 0) return;

        const clave = `${nombreIng}-${medida}`;
        
        if (mapa.has(clave)) {
          const existente = mapa.get(clave)!;
          existente.cantidadTotal += cantidad;
          if (!existente.recetas.includes(nombreReceta)) {
            existente.recetas.push(nombreReceta);
          }
        } else {
          mapa.set(clave, {
            nombre: nombreIng,
            cantidadTotal: cantidad,
            medida: medida,
            recetas: [nombreReceta]
          });
        }
      });
    });

    return Array.from(mapa.values()).sort((a, b) => 
      a.nombre.localeCompare(b.nombre)
    );
  }

  private _enriquecerConNutrientes(apiResponse: any): any {
    if (!apiResponse || !apiResponse.recetasPorDia) return apiResponse;

    const recetasPorDia = apiResponse.recetasPorDia;
    const resultado: any = { ...apiResponse, recetasPorDia: {} };

    const ordenTipos: { [key: string]: number } = {
      'desayuno': 1,
      'comida': 2,
      'cena': 3
    };

    Object.keys(recetasPorDia).forEach((dia) => {
      resultado.recetasPorDia[dia] = recetasPorDia[dia]
        .map((r: any) => {
          const recetaCompleta = this.recetasDisponibles.find(rec => rec.id === r.id);
          let calorias = 0, proteinas = 0, grasas = 0, carbohidratos = 0;

          if (recetaCompleta && Array.isArray((recetaCompleta as any).ingredientes)) {
            (recetaCompleta as any).ingredientes.forEach((ingRel: any) => {
              const ing = ingRel.ingrediente || ingRel;
              const cantidad = Number(ingRel.cantidad || 1);
              if (ing && typeof ing.calorias === 'number') calorias += ing.calorias * cantidad;
              if (ing && typeof ing.proteinas === 'number') proteinas += ing.proteinas * cantidad;
              if (ing && typeof ing.grasas === 'number') grasas += ing.grasas * cantidad;
              if (ing && typeof ing.carbohidratos === 'number') carbohidratos += ing.carbohidratos * cantidad;
            });
          }

          if ((recetaCompleta as any)?.calorias && calorias === 0) calorias = (recetaCompleta as any).calorias || 0;
          if ((recetaCompleta as any)?.proteinas && proteinas === 0) proteinas = (recetaCompleta as any).proteinas || 0;
          if ((recetaCompleta as any)?.grasas && grasas === 0) grasas = (recetaCompleta as any).grasas || 0;
          if ((recetaCompleta as any)?.carbohidratos && carbohidratos === 0) carbohidratos = (recetaCompleta as any).carbohidratos || 0;

          return {
            ...r,
            calorias: Math.round(calorias),
            proteinas: Math.round(proteinas * 10) / 10,
            grasas: Math.round(grasas * 10) / 10,
            carbohidratos: Math.round(carbohidratos * 10) / 10
          };
        })
        .sort((a: any, b: any) => {
          const ordenA = ordenTipos[a.tipo] || 999;
          const ordenB = ordenTipos[b.tipo] || 999;
          return ordenA - ordenB;
        });
    });

    return resultado;
  }

  private formatearFecha(fecha: string): string {
    if (!fecha) return '';
    const partes = fecha.split('-');
    if (partes.length !== 3) return fecha;
    return `${partes[2]}/${partes[1]}/${partes[0]}`;
  }
}