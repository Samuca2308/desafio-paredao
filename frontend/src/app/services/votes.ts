import { Injectable, Signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { toSignal } from '@angular/core/rxjs-interop';
import { Contestant } from './contestant-interface'
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})

export class VotesService {
  apiUrl = "/voting"

  constructor(private http: HttpClient) {}

  getContestants(): Signal<Array<Contestant> | null> {
    return toSignal(this.http.get<any>(`${this.apiUrl}/contestants`));
  }

  postVote(contestant: number): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/votes?contestant_id=${contestant}`, {});
  }

  getTotalVote(): Observable<Array<any>> {
    return this.http.get<any>(`${this.apiUrl}/total`);
  }
}
