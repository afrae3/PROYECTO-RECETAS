// src/app/componentes/login/login.ts
import { Component } from '@angular/core';
import { Auth, LoginRequest, LoginResponse } from '../../servicios/auth';
import { Router, RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './login.html',
  styleUrls: ['./login.css']
})
export class Login {
  email: string = '';
  password: string = '';
  mensaje: string = '';
  mostrarError: boolean = false;
  cargando: boolean = false;

  constructor(private authService: Auth, private router: Router) {}

  onSubmit() {
    if (!this.email || !this.password) {
      this.mostrarError = true;
      this.mensaje = 'Por favor, completa todos los campos.';
      return;
    }

    this.cargando = true;
    this.mostrarError = false;
    this.mensaje = '';

    const credentials: LoginRequest = {
      email: this.email,
      password: this.password
    };

    this.authService.login(credentials).subscribe({
      next: (res: LoginResponse) => {
        console.log('Respuesta del login:', res);

        this.authService.setToken(res.token);
        this.authService.setUserId(res.userId);
        this.authService.setRoles(res.roles);

        this.cargando = false;
        this.router.navigate(['/']);
      },
      error: (err) => {
        this.cargando = false;
        this.mostrarError = true;
        
        if (err.status === 401) {
          this.mensaje = 'Correo o contraseña incorrectos';
        } else if (err.status === 400) {
          this.mensaje = err.error?.error || 'Datos inválidos';
        } else if (err.status === 0) {
          this.mensaje = 'No se pudo conectar con el servidor';
        } else {
          this.mensaje = 'Error al iniciar sesión. Intenta nuevamente';
        }
      }
    });
  }
}