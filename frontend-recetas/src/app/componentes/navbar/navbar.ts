// src/app/componentes/navbar/navbar.ts
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { Auth } from '../../servicios/auth';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './navbar.html',
  styleUrls: ['./navbar.css']
})
export class Navbar {
  menuAbierto = false; 

  constructor(public auth: Auth, private router: Router) {}

  toggleMenu() {
    this.menuAbierto = !this.menuAbierto;
  }


  logout() {
    this.auth.logout();
    this.router.navigate(['/login']);
  }

  isAdmin(): boolean {
    return this.auth.getRoles()?.includes('ROLE_ADMIN') ?? false;
  }
}
