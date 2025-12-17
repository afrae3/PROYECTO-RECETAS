import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { User, UserData } from '../../servicios/user';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-gestion-usuarios',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './gestion-usuarios.html',
  styleUrls: ['./gestion-usuarios.css']
})
export class GestionUsuarios implements OnInit {
  usuarios: UserData[] = [];
  editUserId: number | null = null;
  editEmail: string = '';
  editRoles: string = '';
  
  nuevoEmail: string = '';
  nuevoPassword: string = '';
  nuevoRoles: string = 'ROLE_USER';
  mostrarFormulario: boolean = false;

  constructor(private userService: User) {}

  ngOnInit() {
    this.cargarUsuarios();
  }

  cargarUsuarios() {
    this.userService.getUsers().subscribe({
      next: (data) => this.usuarios = data,
      error: (err) => console.error('Error al cargar usuarios', err)
    });
  }

  borrarUsuario(id: number) {
    if (!confirm('¿Seguro que quieres borrar este usuario?')) return;
    this.userService.deleteUser(id).subscribe({
      next: () => this.cargarUsuarios(),
      error: (err) => console.error('Error al borrar usuario', err)
    });
  }

  editarUsuario(usuario: UserData) {
    this.editUserId = usuario.id;
    this.editEmail = usuario.email;
    this.editRoles = usuario.roles.join(', ');
  }

  guardarUsuario() {
    if (!this.editUserId) return;
    const rolesArray = this.editRoles.split(',').map(r => r.trim()).filter(r => r);
    this.userService.updateUser(this.editUserId, { email: this.editEmail, roles: rolesArray }).subscribe({
      next: () => {
        this.editUserId = null;
        this.editEmail = '';
        this.editRoles = '';
        this.cargarUsuarios();
      },
      error: (err) => console.error('Error al actualizar usuario', err)
    });
  }

  cancelarEdicion() {
    this.editUserId = null;
    this.editEmail = '';
    this.editRoles = '';
  }

  toggleFormulario() {
    this.mostrarFormulario = !this.mostrarFormulario;
    if (!this.mostrarFormulario) {
      this.limpiarFormulario();
    }
  }

  limpiarFormulario() {
    this.nuevoEmail = '';
    this.nuevoPassword = '';
    this.nuevoRoles = 'ROLE_USER';
  }

  crearUsuario() {
    if (!this.nuevoEmail || !this.nuevoPassword) {
      alert('Email y contraseña son obligatorios');
      return;
    }

    const nuevoUsuario = {
      email: this.nuevoEmail,
      password: this.nuevoPassword,
      role: this.nuevoRoles
    };

    this.userService.register(nuevoUsuario).subscribe({
      next: () => {
        alert('Usuario creado correctamente');
        this.limpiarFormulario();
        this.mostrarFormulario = false;
        this.cargarUsuarios();
      },
      error: (err) => {
        console.error('Error al crear usuario', err);
        alert('Error al crear usuario: ' + (err.error?.error || 'Error desconocido'));
      }
    });
  }
}