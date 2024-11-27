// auth.service.ts
import { Injectable, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { environment } from '../../../environments/enviroments'

@Injectable({
  providedIn: 'root'
})

export class DoaService {

  private endPoint = `${environment.apiUrl}/api/doacoes/create`;

  constructor(private http: HttpClient) {}

  postDocao(pessoas_id: string, descricao: string, data_doacao: string): Observable<any> {
    const token = localStorage.getItem('authToken')
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    });

    const body =  { pessoas_id:pessoas_id, 
      descricao:descricao, 
      data_doacao:data_doacao}

    return this.http.post(this.endPoint, body, { headers }).pipe( 
      catchError((error) => {
        console.error('post doação error:', error);
        return throwError(() => new Error(error.error?.message || 'Server Error'));
      })
    );

}
}