
import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { Auth } from '../servicios/auth';

export const authGuard: CanActivateFn = () => {
  const authService = inject(Auth);
  const router = inject(Router);

  const token = authService.getToken();

  if (token) {
    // Si hay token, permite acceder
    return true;
  } else {
    // Si no hay token, redirige al login
    router.navigate(['/login']);
    return false;
  }
};
