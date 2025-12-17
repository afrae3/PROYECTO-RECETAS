// src/app/componentes/registro/registro.ts
import { Component } from '@angular/core';
import { User, UserRegister } from '../../servicios/user';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-registro',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './registro.html',
  styleUrls: ['./registro.css']
})
export class Registro {
  email: string = '';
  password: string = '';
  mensaje: string = '';
  mostrarError: boolean = false;
  mostrarExito: boolean = false;
  cargando: boolean = false;

  constructor(private userService: User, private router: Router) {}

  onSubmit() {
    if (!this.email || !this.password) {
      this.mostrarError = true;
      this.mostrarExito = false;
      this.mensaje = 'Por favor, completa todos los campos.';
      return;
    }

    this.cargando = true;
    this.mostrarError = false;
    this.mostrarExito = false;
    this.mensaje = '';

    const user: UserRegister = { 
      email: this.email, 
      password: this.password 
    };

    this.userService.register(user).subscribe({
      next: (res) => {
        this.cargando = false;
        this.mostrarExito = true;
        this.mensaje = 'Usuario registrado correctamente';
        
        setTimeout(() => {
          this.router.navigate(['/login']);
        }, 1500);
      },
      error: (err) => {
        this.cargando = false;
        this.mostrarError = true;
        
        if (err.status === 400) {
          this.mensaje = err.error?.error || 'El usuario ya existe o los datos son inválidos';
        } else if (err.status === 0) {
          this.mensaje = 'No se pudo conectar con el servidor';
        } else {
          this.mensaje = 'Error al registrar. Intenta nuevamente';
        }
      }
    });
  }
}