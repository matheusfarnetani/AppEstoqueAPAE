import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/enviroments';
import { ItemEstoque } from './item-estoque'; // Crie este arquivo de interface


@Injectable({
    providedIn: 'root'
})
export class EstoqueService {
    private apiUrl = `${environment.apiUrl}/api/estoque`; // URL da sua API

    constructor(private http: HttpClient) {
        
    }

    getItens(): Observable<any> {
        const token = localStorage.getItem('authToken');
        const headers = new HttpHeaders({
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        });
        return this.http.get<any>(`${this.apiUrl}/view/view_estoque_completo`, {headers});
    }

    createItem(item: any): Observable<any> {
        const token = localStorage.getItem('authToken');
        const headers = new HttpHeaders({
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        });
        return this.http.post(`${this.apiUrl}/create`, item);
    }

    deleteItem(id: number): Observable<any> {
        const token = localStorage.getItem('authToken');
        const headers = new HttpHeaders({
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        });
        return this.http.delete(`${this.apiUrl}/${id}`);
    }

}