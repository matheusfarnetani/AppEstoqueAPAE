// auth.service.ts
import { Injectable, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from '../../../environments/enviroments'

@Injectable({
  providedIn: 'root'
})
export class HomeSerevice {

  private endPoint = `${environment.apiUrl}/api/users/` + localStorage.getItem('user');

  constructor(private http: HttpClient) {}

  getName(): Observable<any> {
    const token = localStorage.getItem('authToken')
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    });

    return this.http.get(this.endPoint, { headers }).pipe( 
      catchError((error) => {
        console.error('Login error:', error);
        return throwError(() => new Error(error.error?.message || 'Server Error'));
      })
    );

}
}