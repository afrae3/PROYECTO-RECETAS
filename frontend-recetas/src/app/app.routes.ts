import { Routes } from '@angular/router';
import { Dashboard } from './componentes/dashboard/dashboard';
import { Favoritos } from './componentes/favoritos/favoritos';
import { Calendario } from './componentes/calendario/calendario';
import { Login } from './componentes/login/login';
import { Registro } from './componentes/registro/registro';
import { ListaRecetas } from './componentes/lista-recetas/lista-recetas';
import { authGuard } from './guards/auth-guard';
import { GestionUsuarios } from './componentes/gestion-usuarios/gestion-usuarios';
import { GestionRecetas } from './componentes/gestion-recetas/gestion-recetas';

export const routes: Routes = [
  { path: '', component: ListaRecetas },

  { path: 'dashboard', component: Dashboard, canActivate: [authGuard] },
  { path: 'recetas', component: ListaRecetas },
  { path: 'favoritos', component: Favoritos, canActivate: [authGuard] },
  { path: 'calendario', component: Calendario, canActivate: [authGuard] },
  { path: 'login', component: Login },
  { path: 'registro', component: Registro },
  { path: 'gestion-usuarios', component: GestionUsuarios, canActivate: [authGuard] },
  { path: 'gestion-recetas', component: GestionRecetas, canActivate: [authGuard] },
];
