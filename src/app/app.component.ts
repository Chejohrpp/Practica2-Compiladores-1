import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'practica2-compi1';
  arrayListAnCont: {'id':String, 'cont':String, 'gramatica': any}[] = [];
  activarEntradaTxt: boolean = false;
  gramaticaActual:any;
  nameGramActual: String;
  activarArbol:boolean = false;
  private cont:number = 1;

  addArrayListAn(info:String, gramHecha:any){
    let strc = {'id': 'Analizador ' + this.cont , 'cont':info, 'gramatica' : gramHecha}
    this.arrayListAnCont.push(strc);
    this.cont++
  }
}
