import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  token: string;
  userId: number;
  roles: string[]; 
}

@Injectable({
  providedIn: 'root'
})
export class Auth {
  private apiUrl = 'https://proyecto-recetas-backend.onrender.com/api/login';

  constructor(private http: HttpClient) {}

  login(credentials: LoginRequest): Observable<LoginResponse> {
    return this.http.post<LoginResponse>(this.apiUrl, credentials);
  }

  setUserId(userId: number) {
    localStorage.setItem('userId', userId.toString());
  }

  getUserId(): number | null {
    const id = localStorage.getItem('userId');
    return id ? +id : null;
  }
  
  setToken(token: string) {
    localStorage.setItem('jwt', token);
  }

  getToken(): string | null {
    return localStorage.getItem('jwt');
  }

  setRoles(roles: string[]) {
    localStorage.setItem('userRoles', JSON.stringify(roles));
  }

  getRoles(): string[] {
    const roles = localStorage.getItem('userRoles');
    return roles ? JSON.parse(roles) : [];
  }

  isAdmin(): boolean {
    return this.getRoles().includes('ROLE_ADMIN');
  }

  logout() {
    localStorage.removeItem('jwt');
    localStorage.removeItem('userId');
    localStorage.removeItem('userRoles'); 
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }
}
