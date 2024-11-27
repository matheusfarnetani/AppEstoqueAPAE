// auth.service.ts
import { Injectable, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from '../../../environments/enviroments'

@Injectable({
    providedIn: 'root'
})

export class AdminService {

    private endPoint = `${environment.apiUrl}/api/pessoas/create`;

    constructor(private http: HttpClient) { }

    cadDoador(tipo_pessoa: string, nome: string, documento: string, data_nascimento: string, email: string, endereco_id: string): Observable<any> {
        const token = localStorage.getItem('authToken')
        const headers = new HttpHeaders({
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
        });
        const body = {
            tipo_pessoa: tipo_pessoa,
            nome: nome,
            documento: documento,
            data_nascimento: data_nascimento,
            email: email,
            endereco_id: endereco_id,
        }

        return this.http.post(this.endPoint, body, { headers }).pipe(
            catchError((error) => {
                console.error('Login error:', error);
                return throwError(() => new Error(error.error?.message || 'Server Error'));
            })
        );

    }
}