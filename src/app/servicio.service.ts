import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ServicioService {

  arrayAnalizadores:String[] = [];

  addArrayAn(info){
    this.arrayAnalizadores.push(info);
  }
  getArrayAn(){
    return this.arrayAnalizadores;
  }
  
  constructor() { }
}
