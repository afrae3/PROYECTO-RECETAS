import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { ListaRecetas } from './componentes/lista-recetas/lista-recetas';
import { Navbar } from './componentes/navbar/navbar';
import { Calendario } from './componentes/calendario/calendario';
import { Dashboard } from './componentes/dashboard/dashboard';
import { Favoritos } from './componentes/favoritos/favoritos';
import { Login } from './componentes/login/login';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, ListaRecetas, Navbar, Calendario, Dashboard,Favoritos, Login],
  templateUrl: './app.html',
  styleUrls: ['./app.css']
})
export class App {
  protected readonly title = signal('frontend-recetas');
}
