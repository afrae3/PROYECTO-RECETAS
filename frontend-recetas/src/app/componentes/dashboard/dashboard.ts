import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { DashboardService, EstadisticasResponse } from '../../servicios/dashboard';
import { ObjetivosService, ObjetivosPersonales} from '../../servicios/objetivosService';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, FormsModule, HttpClientModule],
  templateUrl: './dashboard.html',
  styleUrls: ['./dashboard.css']
})
export class Dashboard implements OnInit {
  estadisticas: EstadisticasResponse | null = null;
  loading = true;
  error: string | null = null;
  diasOrdenados = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

  mostrarFormularioObjetivos = false;
  tieneObjetivos = false;
  
  datosPersonales: ObjetivosPersonales = {
    sexo: 'masculino',
    edad: 30,
    peso: 70,
    altura: 170,
    nivelActividad: 'moderado',
    objetivo: 'mantener'
  };

  constructor(
    private dashboard: DashboardService,
    private objetivosService: ObjetivosService
  ) {}

  ngOnInit(): void {
    this.cargarDatos();
  }

  cargarDatos(): void {
    const usuarioId = Number(localStorage.getItem('userId'));
    if (!usuarioId) {
      this.error = 'Usuario no identificado';
      this.loading = false;
      return;
    }

    this.dashboard.obtenerEstadisticas(usuarioId).subscribe({
      next: (data) => {
        console.log('✅ Datos recibidos:', data);
        this.estadisticas = data;
        this.tieneObjetivos = !!data.objetivos;
        
        if (data.objetivos) {
          this.objetivosService.obtener(usuarioId).subscribe({
            next: (objetivos) => {
              this.datosPersonales = {
                sexo: objetivos.sexo,
                edad: objetivos.edad,
                peso: objetivos.peso,
                altura: objetivos.altura,
                nivelActividad: objetivos.nivelActividad,
                objetivo: objetivos.objetivo
              };
            }
          });
        }
        
        this.loading = false;
      },
      error: (err) => {
        console.error('❌ Error:', err);
        this.error = err.error?.error || 'No se pudieron cargar las estadísticas';
        this.loading = false;
      }
    });
  }

  get diasConDatos(): string[] {
    if (!this.estadisticas) return [];
    return this.diasOrdenados.filter(dia => this.estadisticas!.datosPorDia[dia]);
  }

  obtenerComidasOrdenadas(dia: string): any[] {
    if (!this.estadisticas?.datosPorDia[dia]?.comidas) return [];
    
    const ordenComidas: { [key: string]: number } = {
      'desayuno': 1,
      'comida': 2,
      'cena': 3
    };
    
    return [...this.estadisticas.datosPorDia[dia].comidas].sort((a, b) => {
      return (ordenComidas[a.tipo.toLowerCase()] || 99) - (ordenComidas[b.tipo.toLowerCase()] || 99);
    });
  }

  calcularPorcentajeObjetivo(tipo: 'calorias' | 'proteinas' | 'grasas' | 'carbohidratos'): number {
    if (!this.estadisticas?.objetivos) return 0;
    const promedio = this.estadisticas.promediosDiarios[tipo];
    const objetivo = this.estadisticas.objetivos[tipo];
    return objetivo > 0 ? Math.round((promedio / objetivo) * 100) : 0;
  }

  toggleFormularioObjetivos(): void {
    this.mostrarFormularioObjetivos = !this.mostrarFormularioObjetivos;
  }

  calcularYGuardarObjetivos(): void {
    const usuarioId = Number(localStorage.getItem('userId'));
    if (!usuarioId) return;

    this.objetivosService.guardar(usuarioId, this.datosPersonales).subscribe({
      next: (response) => {
        console.log('Objetivos calculados:', response.objetivos);
        alert(`Objetivos calculados correctamente:
        
Calorías: ${response.objetivos.calorias} kcal/día
Proteínas: ${response.objetivos.proteinas} g/día
Grasas: ${response.objetivos.grasas} g/día
Carbohidratos: ${response.objetivos.carbohidratos} g/día
Fibra: ${response.objetivos.fibra} g/día`);
        
        this.mostrarFormularioObjetivos = false;
        this.cargarDatos();
      },
      error: (err) => {
        console.error('Error al calcular objetivos:', err);
        alert('Error al calcular objetivos');
      }
    });
  }

  eliminarObjetivos(): void {
    if (!confirm('¿Estás seguro de eliminar tus objetivos nutricionales?')) return;

    const usuarioId = Number(localStorage.getItem('userId'));
    if (!usuarioId) return;

    this.objetivosService.eliminar(usuarioId).subscribe({
      next: () => {
        alert('Objetivos eliminados correctamente');
        this.cargarDatos();
      },
      error: (err) => {
        console.error('Error al eliminar objetivos:', err);
        alert('Error al eliminar objetivos');
      }
    });
  }

  getNombreSexo(sexo: string): string {
    return sexo === 'masculino' ? 'Masculino' : 'Femenino';
  }

  getNombreActividad(nivel: string): string {
    const niveles: { [key: string]: string } = {
      'sedentario': 'Sedentario (poco o ningún ejercicio)',
      'ligero': 'Ligero (ejercicio 1-3 días/semana)',
      'moderado': 'Moderado (ejercicio 3-5 días/semana)',
      'activo': 'Activo (ejercicio 6-7 días/semana)',
      'muy_activo': 'Muy activo (ejercicio intenso diario)'
    };
    return niveles[nivel] || nivel;
  }

  getNombreObjetivo(objetivo: string): string {
    const objetivos: { [key: string]: string } = {
      'perder_peso': 'Perder peso',
      'mantener': 'Mantener peso',
      'ganar_musculo': 'Ganar músculo'
    };
    return objetivos[objetivo] || objetivo;
  }
}