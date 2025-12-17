// src/app/servicios/user.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface UserRegister {
  email: string;
  password: string;
  role?: string; 
}

export interface UserData {
  id: number;
  email: string;
  roles: string[];
}

@Injectable({
  providedIn: 'root'
})
export class User {
  private apiUrlRegister = 'https://proyecto-recetas-backend.onrender.com/api/register';
  private apiUrlUsers = 'https://proyecto-recetas-backend.onrender.com/api/users';

  constructor(private http: HttpClient) {}

  register(user: UserRegister): Observable<any> {
    return this.http.post(this.apiUrlRegister, user);
  }

  getUsers(): Observable<UserData[]> {
    return this.http.get<UserData[]>(this.apiUrlUsers);
  }

  deleteUser(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrlUsers}/${id}`);
  }

  updateUser(id: number, data: { email?: string; roles?: string[] }): Observable<any> {
    return this.http.put(`${this.apiUrlUsers}/${id}`, data);
  }
}
