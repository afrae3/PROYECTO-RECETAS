import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RecetasService, Receta, IngredienteReceta } from '../../servicios/recetas';

@Component({
  selector: 'app-gestion-recetas',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './gestion-recetas.html',
  styleUrls: ['./gestion-recetas.css']
})
export class GestionRecetas implements OnInit {

  recetas: Receta[] = [];
  receta: Receta = this.nuevaReceta();

  categorias: {id:number,nombre:string}[] = [];
  ingredientes: {id:number,nombre:string}[] = [];
  alergenos: {id:number,nombre:string}[] = [];
  tags: {id:number,nombre:string}[] = [];

  ingredienteSeleccionado: number | null = null;
  cantidadIngrediente: number = 0;
  medidaIngrediente: string = 'g';
  alergenoSeleccionado: number | null = null;
  tagSeleccionado: number | null = null;
  nuevaInstruccion: string = '';
  
  instruccionEditando: number | null = null;
  textoInstruccionEditando: string = '';
  
  modoEdicion: boolean = false;
  
  imagenFile: File | null = null;
  imagenPreview: string | null = null;

  constructor(private recetasService: RecetasService) {}

  ngOnInit() {
    this.cargarSelects();
    this.cargarRecetas();
  }

  nuevaReceta(): Receta {
    return {
      id: 0,
      nombre: '',
      descripcion: '',
      categoria: undefined,
      ingredientes: [],
      instrucciones: [],
      dificultad: null,
      alergenos: [],
      tagsSaludables: []
    };
  }

  cargarSelects() {
    this.recetasService.getCategorias().subscribe(data => this.categorias = data);
    this.recetasService.getIngredientes().subscribe(data => this.ingredientes = data);
    this.recetasService.getAlergenos().subscribe(data => this.alergenos = data);
    this.recetasService.getTags().subscribe(data => this.tags = data);
  }

  cargarRecetas() {
    this.recetasService.getRecetas().subscribe(data => this.recetas = data);
  }

  resetForm() {
    this.receta = this.nuevaReceta();
    this.modoEdicion = false;
    this.nuevaInstruccion = '';
    this.imagenFile = null;
    this.imagenPreview = null;
    this.ingredienteSeleccionado = null;
    this.cantidadIngrediente = 0;
    this.medidaIngrediente = 'g';
    this.alergenoSeleccionado = null;
    this.tagSeleccionado = null;
    this.instruccionEditando = null;
    this.textoInstruccionEditando = '';
  }

  onFileSelected(event: any) {
    const file = event.target.files[0];
    if (file) {
      this.imagenFile = file;
      
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.imagenPreview = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }

  agregarIngrediente() {
    if (!this.ingredienteSeleccionado || !this.cantidadIngrediente) {
      alert('Selecciona un ingrediente y especifica la cantidad');
      return;
    }

    const ing = this.ingredientes.find(i => i.id === this.ingredienteSeleccionado);
    if (ing) {
      this.receta.ingredientes = this.receta.ingredientes ?? [];
      this.receta.ingredientes.push({ 
        id: ing.id!, 
        nombre: ing.nombre, 
        cantidad: this.cantidadIngrediente, 
        medida: this.medidaIngrediente 
      });
      
      this.ingredienteSeleccionado = null;
      this.cantidadIngrediente = 0;
      this.medidaIngrediente = 'g';
    }
  }

  agregarAlergeno() {
    if (!this.alergenoSeleccionado) {
      alert('Selecciona un alérgeno');
      return;
    }

    this.receta.alergenos = this.receta.alergenos ?? [];
    if (!this.receta.alergenos.includes(this.alergenoSeleccionado)) {
      this.receta.alergenos.push(this.alergenoSeleccionado);
      this.alergenoSeleccionado = null;
    } else {
      alert('Este alérgeno ya está agregado');
    }
  }

  agregarTag() {
    if (!this.tagSeleccionado) {
      alert('Selecciona un tag');
      return;
    }

    this.receta.tagsSaludables = this.receta.tagsSaludables ?? [];
    if (!this.receta.tagsSaludables.includes(this.tagSeleccionado)) {
      this.receta.tagsSaludables.push(this.tagSeleccionado);
      this.tagSeleccionado = null;
    } else {
      alert('Este tag ya está agregado');
    }
  }

  agregarInstruccion() {
    this.receta.instrucciones = this.receta.instrucciones ?? [];
    if (this.nuevaInstruccion.trim()) {
      this.receta.instrucciones.push(this.nuevaInstruccion.trim());
      this.nuevaInstruccion = '';
    }
  }

  quitarIngrediente(index: number) { this.receta.ingredientes?.splice(index, 1); }
  quitarAlergeno(index: number) { this.receta.alergenos?.splice(index, 1); }
  quitarTag(index: number) { this.receta.tagsSaludables?.splice(index, 1); }
  quitarInstruccion(index: number) { this.receta.instrucciones?.splice(index, 1); }

  editarInstruccion(index: number) {
    this.instruccionEditando = index;
    this.textoInstruccionEditando = this.receta.instrucciones?.[index] || '';
  }

  guardarEdicionInstruccion(index: number) {
    if (this.receta.instrucciones && this.textoInstruccionEditando.trim()) {
      this.receta.instrucciones[index] = this.textoInstruccionEditando.trim();
      this.cancelarEdicionInstruccion();
    }
  }

  cancelarEdicionInstruccion() {
    this.instruccionEditando = null;
    this.textoInstruccionEditando = '';
  }

  getNombreAlergeno(idOrNombre: number | string): string {
    if (typeof idOrNombre === 'string') {
      return idOrNombre;
    }
    return this.alergenos.find(a => a.id === idOrNombre)?.nombre ?? '';
  }

  getNombreTag(idOrNombre: number | string): string {
    if (typeof idOrNombre === 'string') {
      return idOrNombre;
    }
    return this.tags.find(t => t.id === idOrNombre)?.nombre ?? '';
  }

  getNombreCategoria(id: number | string | undefined): string {
    if (!id && id !== 0) return 'Sin categoría';
    
    if (typeof id === 'string') {
      return id;
    }
    
    return this.categorias.find(c => c.id === id)?.nombre ?? 'Sin categoría';
  }

  editar(r: Receta) {
    let categoriaId: number | undefined = undefined;
    if (typeof r.categoria === 'string') {
      const cat = this.categorias.find(c => c.nombre === r.categoria);
      categoriaId = cat?.id;
    } else if (typeof r.categoria === 'number') {
      categoriaId = r.categoria;
    }

    this.receta = {
      ...r,
      categoria: categoriaId,
      ingredientes: r.ingredientes?.map(ing => ({
        id: ing.id!,
        nombre: ing.nombre,
        cantidad: ing.cantidad,
        medida: ing.medida
      })) || [],
      alergenos: r.alergenos?.map(item => {
        if (typeof item === 'number') return item;
        const alergeno = this.alergenos.find(a => a.nombre === item);
        return alergeno?.id || 0;
      }).filter(id => id > 0) || [],
      tagsSaludables: r.tagsSaludables?.map(item => {
        if (typeof item === 'number') return item;
        const tag = this.tags.find(t => t.nombre === item);
        return tag?.id || 0;
      }).filter(id => id > 0) || []
    };
    
    this.modoEdicion = true;
    this.imagenPreview = r.imagen ? `imagen/${r.imagen}` : null;
    
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  borrar(id: number) {
    if (!confirm('¿Seguro que quieres borrar esta receta?')) return;
    this.recetasService.borrarReceta(id).subscribe(() => this.cargarRecetas());
  }

  guardarReceta() {
    const formData = new FormData();
    
    formData.append('nombre', this.receta.nombre);
    formData.append('descripcion', this.receta.descripcion || '');
    formData.append('tiempoPreparacion', String(this.receta.tiempoPreparacion || 0));
    formData.append('porciones', String(this.receta.porciones || 1));
    formData.append('dificultad', this.receta.dificultad || '');
    formData.append('categoria', String(this.receta.categoria || ''));

    if (this.imagenFile) {
      formData.append('imagen', this.imagenFile);
    }

    formData.append('ingredientes', JSON.stringify(this.receta.ingredientes || []));
    formData.append('instrucciones', JSON.stringify(this.receta.instrucciones || []));
    formData.append('alergenos', JSON.stringify(this.receta.alergenos || []));
    formData.append('tagsSaludables', JSON.stringify(this.receta.tagsSaludables || []));

    if (this.modoEdicion && this.receta.id) {
      this.recetasService.editarReceta(this.receta.id, formData)
        .subscribe(() => {
          alert('Receta actualizada correctamente');
          this.cargarRecetas();
          this.resetForm();
        });
    } else {
      this.recetasService.crearReceta(formData)
        .subscribe(() => {
          alert('Receta creada correctamente');
          this.cargarRecetas();
          this.resetForm();
        });
    }
  }
}